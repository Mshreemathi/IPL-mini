using System;
using System.Data;
using System.Web.UI.WebControls;

namespace IPLProject
{
    public partial class SeatMasterPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                BindStands();
                BindGrid();
            }
        }

        void BindStands()
        {
            ddlStand.DataSource = Db.GetTable("SELECT s.StandId, (m.MatchName + ' - ' + s.StandName) AS StandText FROM StandDetails s INNER JOIN MatchDetails m ON s.MatchId=m.MatchId");
            ddlStand.DataTextField = "StandText";
            ddlStand.DataValueField = "StandId";
            ddlStand.DataBind();
            ddlStand.Items.Insert(0, new ListItem("-- Select Stand --", ""));
        }

        void BindGrid()
        {
            string sql = "SELECT s.SeatId, st.StandName, s.SeatNumber, s.Price FROM SeatDetails s INNER JOIN StandDetails st ON s.StandId=st.StandId ORDER BY s.SeatId DESC";
            gvSeats.DataSource = Db.GetTable(sql);
            gvSeats.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            Db.ExecuteNonQuery("INSERT INTO SeatDetails (StandId, SeatNumber, Price, IsBooked) VALUES (?, ?, ?, 0)",
                Convert.ToInt32(ddlStand.SelectedValue), txtSeatNumber.Text.Trim(), Convert.ToDecimal(txtPrice.Text.Trim()));
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Seat added successfully!";
            ClearForm();
            BindGrid();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid || string.IsNullOrEmpty(hfSeatId.Value)) return;
            Db.ExecuteNonQuery("UPDATE SeatDetails SET StandId=?, SeatNumber=?, Price=? WHERE SeatId=?",
                Convert.ToInt32(ddlStand.SelectedValue), txtSeatNumber.Text.Trim(), Convert.ToDecimal(txtPrice.Text.Trim()), Convert.ToInt32(hfSeatId.Value));
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Seat updated successfully!";
            ClearForm();
            BindGrid();
        }

        protected void gvSeats_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "EditRow")
            {
                DataTable dt = Db.GetTable("SELECT * FROM SeatDetails WHERE SeatId=?", id);
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    hfSeatId.Value = r["SeatId"].ToString();
                    ddlStand.SelectedValue = r["StandId"].ToString();
                    txtSeatNumber.Text = r["SeatNumber"].ToString();
                    txtPrice.Text = Convert.ToDecimal(r["Price"]).ToString("0.00");
                    btnAdd.Visible = false;
                    btnUpdate.Visible = true;
                }
            }
            else if (e.CommandName == "DeleteRow")
            {
                Db.ExecuteNonQuery("DELETE FROM SeatDetails WHERE SeatId=?", id);
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Seat deleted.";
                ClearForm();
                BindGrid();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e) { ClearForm(); }

        void ClearForm()
        {
            hfSeatId.Value = "";
            ddlStand.SelectedIndex = 0;
            txtSeatNumber.Text = "";
            txtPrice.Text = "";
            btnAdd.Visible = true;
            btnUpdate.Visible = false;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("StandMaster.aspx");
        }
    }
}

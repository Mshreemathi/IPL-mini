using System;
using System.Data;
using System.Web.UI.WebControls;

namespace IPLProject
{
    public partial class StandMasterPage : System.Web.UI.Page
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
                BindMatches();
                BindGrid();
            }
        }

        void BindMatches()
        {
            ddlMatch.DataSource = Db.GetTable("SELECT MatchId, MatchName FROM MatchDetails");
            ddlMatch.DataTextField = "MatchName";
            ddlMatch.DataValueField = "MatchId";
            ddlMatch.DataBind();
            ddlMatch.Items.Insert(0, new ListItem("-- Select Match --", ""));
        }

        void BindGrid()
        {
            string sql = "SELECT s.StandId, m.MatchName, s.StandName, s.Price, s.TotalSeats FROM StandDetails s INNER JOIN MatchDetails m ON s.MatchId=m.MatchId ORDER BY s.StandId DESC";
            gvStands.DataSource = Db.GetTable(sql);
            gvStands.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            Db.ExecuteNonQuery("INSERT INTO StandDetails (MatchId, StandName, Price, TotalSeats) VALUES (?, ?, ?, ?)",
                Convert.ToInt32(ddlMatch.SelectedValue), txtStandName.Text.Trim(), Convert.ToDecimal(txtPrice.Text.Trim()), Convert.ToInt32(txtSeats.Text.Trim()));
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Stand added successfully!";
            ClearForm();
            BindGrid();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid || string.IsNullOrEmpty(hfStandId.Value)) return;
            Db.ExecuteNonQuery("UPDATE StandDetails SET MatchId=?, StandName=?, Price=?, TotalSeats=? WHERE StandId=?",
                Convert.ToInt32(ddlMatch.SelectedValue), txtStandName.Text.Trim(), Convert.ToDecimal(txtPrice.Text.Trim()), Convert.ToInt32(txtSeats.Text.Trim()), Convert.ToInt32(hfStandId.Value));
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Stand updated successfully!";
            ClearForm();
            BindGrid();
        }

        protected void gvStands_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "EditRow")
            {
                DataTable dt = Db.GetTable("SELECT * FROM StandDetails WHERE StandId=?", id);
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    hfStandId.Value = r["StandId"].ToString();
                    ddlMatch.SelectedValue = r["MatchId"].ToString();
                    txtStandName.Text = r["StandName"].ToString();
                    txtPrice.Text = Convert.ToDecimal(r["Price"]).ToString("0.00");
                    txtSeats.Text = r["TotalSeats"].ToString();
                    btnAdd.Visible = false;
                    btnUpdate.Visible = true;
                }
            }
            else if (e.CommandName == "DeleteRow")
            {
                Db.ExecuteNonQuery("DELETE FROM StandDetails WHERE StandId=?", id);
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Stand deleted.";
                ClearForm();
                BindGrid();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e) { ClearForm(); }

        void ClearForm()
        {
            hfStandId.Value = "";
            ddlMatch.SelectedIndex = 0;
            txtStandName.Text = "";
            txtPrice.Text = "";
            txtSeats.Text = "";
            btnAdd.Visible = true;
            btnUpdate.Visible = false;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Match.aspx");
        }
    }
}

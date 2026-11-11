using System;
using System.Data;
using System.Web.UI.WebControls;

namespace IPLProject
{
    public partial class MatchPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack) BindGrid();
        }

        void BindGrid()
        {
            gvMatches.DataSource = Db.GetTable("SELECT * FROM MatchDetails ORDER BY MatchId DESC");
            gvMatches.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            DateTime dtVal;
            if (!DateTime.TryParse(txtDate.Text.Trim(), out dtVal))
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Enter valid date (e.g. 2026-04-15 19:30)";
                return;
            }
            Db.ExecuteNonQuery("INSERT INTO MatchDetails (MatchName, TeamA, TeamB, Venue, MatchDate) VALUES (?, ?, ?, ?, ?)",
                txtMatchName.Text.Trim(), txtTeamA.Text.Trim(), txtTeamB.Text.Trim(), txtVenue.Text.Trim(), dtVal.ToString("yyyy-MM-dd HH:mm:ss"));
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Match added successfully!";
            ClearForm();
            BindGrid();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid || string.IsNullOrEmpty(hfMatchId.Value)) return;
            DateTime dtVal;
            if (!DateTime.TryParse(txtDate.Text.Trim(), out dtVal))
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Enter valid date (e.g. 2026-04-15 19:30)";
                return;
            }
            Db.ExecuteNonQuery("UPDATE MatchDetails SET MatchName=?, TeamA=?, TeamB=?, Venue=?, MatchDate=? WHERE MatchId=?",
                txtMatchName.Text.Trim(), txtTeamA.Text.Trim(), txtTeamB.Text.Trim(), txtVenue.Text.Trim(), dtVal.ToString("yyyy-MM-dd HH:mm:ss"), Convert.ToInt32(hfMatchId.Value));
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Match updated successfully!";
            ClearForm();
            BindGrid();
        }

        protected void gvMatches_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "EditRow")
            {
                DataTable dt = Db.GetTable("SELECT * FROM MatchDetails WHERE MatchId=?", id);
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    hfMatchId.Value = r["MatchId"].ToString();
                    txtMatchName.Text = r["MatchName"].ToString();
                    txtTeamA.Text = r["TeamA"].ToString();
                    txtTeamB.Text = r["TeamB"].ToString();
                    txtVenue.Text = r["Venue"].ToString();
                    txtDate.Text = Convert.ToDateTime(r["MatchDate"]).ToString("yyyy-MM-dd HH:mm");
                    btnAdd.Visible = false;
                    btnUpdate.Visible = true;
                }
            }
            else if (e.CommandName == "DeleteRow")
            {
                Db.ExecuteNonQuery("DELETE FROM MatchDetails WHERE MatchId=?", id);
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Match deleted.";
                ClearForm();
                BindGrid();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e) { ClearForm(); }

        void ClearForm()
        {
            hfMatchId.Value = "";
            txtMatchName.Text = "";
            txtTeamA.Text = "";
            txtTeamB.Text = "";
            txtVenue.Text = "";
            txtDate.Text = "";
            btnAdd.Visible = true;
            btnUpdate.Visible = false;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}

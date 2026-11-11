using System;
using System.Data;
using System.Web.UI.WebControls;

namespace IPLProject
{
    public partial class BookingPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "User")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                BindCustomers();
                BindMatches();
                BindStands();
                BindSeats();
                BindGrid();
            }
        }

        void BindCustomers()
        {
            ddlCustomer.DataSource = Db.GetTable("SELECT CustomerId, FullName FROM Customers");
            ddlCustomer.DataTextField = "FullName";
            ddlCustomer.DataValueField = "CustomerId";
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem("-- Select Customer --", ""));
        }

        void BindMatches()
        {
            ddlMatch.DataSource = Db.GetTable("SELECT MatchId, MatchName FROM MatchDetails");
            ddlMatch.DataTextField = "MatchName";
            ddlMatch.DataValueField = "MatchId";
            ddlMatch.DataBind();
            ddlMatch.Items.Insert(0, new ListItem("-- Select Match --", ""));
        }

        void BindStands()
        {
            ddlStand.Items.Clear();
            if (!string.IsNullOrEmpty(ddlMatch.SelectedValue))
            {
                ddlStand.DataSource = Db.GetTable("SELECT StandId, StandName FROM StandDetails WHERE MatchId=?", Convert.ToInt32(ddlMatch.SelectedValue));
                ddlStand.DataTextField = "StandName";
                ddlStand.DataValueField = "StandId";
                ddlStand.DataBind();
            }
            ddlStand.Items.Insert(0, new ListItem("-- Select Stand --", ""));
        }

        void BindSeats()
        {
            ddlSeat.Items.Clear();
            if (!string.IsNullOrEmpty(ddlStand.SelectedValue))
            {
                ddlSeat.DataSource = Db.GetTable("SELECT SeatId, SeatNumber FROM SeatDetails WHERE StandId=?", Convert.ToInt32(ddlStand.SelectedValue));
                ddlSeat.DataTextField = "SeatNumber";
                ddlSeat.DataValueField = "SeatId";
                ddlSeat.DataBind();
            }
            ddlSeat.Items.Insert(0, new ListItem("-- Select Seat --", ""));
        }

        void CalculateTotal()
        {
            decimal price = 0;
            if (!string.IsNullOrEmpty(ddlSeat.SelectedValue))
            {
                object p = Db.ExecuteScalar("SELECT Price FROM SeatDetails WHERE SeatId=?", Convert.ToInt32(ddlSeat.SelectedValue));
                if (p != null && p != DBNull.Value) price = Convert.ToDecimal(p);
            }
            else if (!string.IsNullOrEmpty(ddlStand.SelectedValue))
            {
                object p = Db.ExecuteScalar("SELECT Price FROM StandDetails WHERE StandId=?", Convert.ToInt32(ddlStand.SelectedValue));
                if (p != null && p != DBNull.Value) price = Convert.ToDecimal(p);
            }

            int count = 1;
            int.TryParse(txtTicketCount.Text.Trim(), out count);
            if (count < 1) count = 1;
            txtTotalAmount.Text = (price * count).ToString("0.00");
        }

        protected void ddlMatch_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindStands();
            BindSeats();
            CalculateTotal();
        }

        protected void ddlStand_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindSeats();
            CalculateTotal();
        }

        protected void ddlSeat_SelectedIndexChanged(object sender, EventArgs e) { CalculateTotal(); }
        protected void txtTicketCount_TextChanged(object sender, EventArgs e) { CalculateTotal(); }

        void BindGrid()
        {
            string sql = "SELECT b.BookingId, c.FullName, m.MatchName, st.StandName, s.SeatNumber, b.TicketCount, b.TotalAmount " +
                         "FROM (((Bookings b INNER JOIN Customers c ON b.CustomerId = c.CustomerId) " +
                         "INNER JOIN MatchDetails m ON b.MatchId = m.MatchId) " +
                         "INNER JOIN StandDetails st ON b.StandId = st.StandId) " +
                         "INNER JOIN SeatDetails s ON b.SeatId = s.SeatId ORDER BY b.BookingId DESC";
            gvBookings.DataSource = Db.GetTable(sql);
            gvBookings.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            CalculateTotal();
            Db.ExecuteNonQuery("INSERT INTO Bookings (CustomerId, MatchId, StandId, SeatId, TicketCount, TotalAmount, BookingDate) VALUES (?, ?, ?, ?, ?, ?, ?)",
                Convert.ToInt32(ddlCustomer.SelectedValue),
                Convert.ToInt32(ddlMatch.SelectedValue),
                Convert.ToInt32(ddlStand.SelectedValue),
                Convert.ToInt32(ddlSeat.SelectedValue),
                Convert.ToInt32(txtTicketCount.Text.Trim()),
                Convert.ToDecimal(txtTotalAmount.Text),
                DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Booking added successfully!";
            ClearForm();
            BindGrid();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid || string.IsNullOrEmpty(hfBookingId.Value)) return;
            CalculateTotal();
            Db.ExecuteNonQuery("UPDATE Bookings SET CustomerId=?, MatchId=?, StandId=?, SeatId=?, TicketCount=?, TotalAmount=? WHERE BookingId=?",
                Convert.ToInt32(ddlCustomer.SelectedValue),
                Convert.ToInt32(ddlMatch.SelectedValue),
                Convert.ToInt32(ddlStand.SelectedValue),
                Convert.ToInt32(ddlSeat.SelectedValue),
                Convert.ToInt32(txtTicketCount.Text.Trim()),
                Convert.ToDecimal(txtTotalAmount.Text),
                Convert.ToInt32(hfBookingId.Value));
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Booking updated successfully!";
            ClearForm();
            BindGrid();
        }

        protected void gvBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "EditRow")
            {
                DataTable dt = Db.GetTable("SELECT * FROM Bookings WHERE BookingId=?", id);
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    hfBookingId.Value = r["BookingId"].ToString();
                    ddlCustomer.SelectedValue = r["CustomerId"].ToString();
                    ddlMatch.SelectedValue = r["MatchId"].ToString();
                    BindStands();
                    ddlStand.SelectedValue = r["StandId"].ToString();
                    BindSeats();
                    ddlSeat.SelectedValue = r["SeatId"].ToString();
                    txtTicketCount.Text = r["TicketCount"].ToString();
                    txtTotalAmount.Text = Convert.ToDecimal(r["TotalAmount"]).ToString("0.00");
                    btnAdd.Visible = false;
                    btnUpdate.Visible = true;
                }
            }
            else if (e.CommandName == "DeleteRow")
            {
                Db.ExecuteNonQuery("DELETE FROM Bookings WHERE BookingId=?", id);
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Booking deleted.";
                ClearForm();
                BindGrid();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e) { ClearForm(); }

        void ClearForm()
        {
            hfBookingId.Value = "";
            ddlCustomer.SelectedIndex = 0;
            ddlMatch.SelectedIndex = 0;
            ddlStand.Items.Clear();
            ddlStand.Items.Insert(0, new ListItem("-- Select Stand --", ""));
            ddlSeat.Items.Clear();
            ddlSeat.Items.Insert(0, new ListItem("-- Select Seat --", ""));
            txtTicketCount.Text = "1";
            txtTotalAmount.Text = "";
            btnAdd.Visible = true;
            btnUpdate.Visible = false;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Customer.aspx");
        }
    }
}

using System;
using System.Data;
using System.Web.UI.WebControls;

namespace IPLProject
{
    public partial class CustomerPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "User")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack) BindGrid();
        }

        void BindGrid()
        {
            gvCustomers.DataSource = Db.GetTable("SELECT * FROM Customers ORDER BY CustomerId DESC");
            gvCustomers.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            Db.ExecuteNonQuery("INSERT INTO Customers (FullName, Email, Phone, City) VALUES (?, ?, ?, ?)",
                txtName.Text.Trim(), txtEmail.Text.Trim(), txtPhone.Text.Trim(), txtCity.Text.Trim());
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Customer added successfully!";
            ClearForm();
            BindGrid();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid || string.IsNullOrEmpty(hfCustomerId.Value)) return;
            Db.ExecuteNonQuery("UPDATE Customers SET FullName=?, Email=?, Phone=?, City=? WHERE CustomerId=?",
                txtName.Text.Trim(), txtEmail.Text.Trim(), txtPhone.Text.Trim(), txtCity.Text.Trim(), Convert.ToInt32(hfCustomerId.Value));
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Customer updated successfully!";
            ClearForm();
            BindGrid();
        }

        protected void gvCustomers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "EditRow")
            {
                DataTable dt = Db.GetTable("SELECT * FROM Customers WHERE CustomerId=?", id);
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    hfCustomerId.Value = r["CustomerId"].ToString();
                    txtName.Text = r["FullName"].ToString();
                    txtEmail.Text = r["Email"].ToString();
                    txtPhone.Text = r["Phone"].ToString();
                    txtCity.Text = r["City"].ToString();
                    btnAdd.Visible = false;
                    btnUpdate.Visible = true;
                }
            }
            else if (e.CommandName == "DeleteRow")
            {
                Db.ExecuteNonQuery("DELETE FROM Customers WHERE CustomerId=?", id);
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Customer deleted.";
                ClearForm();
                BindGrid();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e) { ClearForm(); }

        void ClearForm()
        {
            hfCustomerId.Value = "";
            txtName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtCity.Text = "";
            btnAdd.Visible = true;
            btnUpdate.Visible = false;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}

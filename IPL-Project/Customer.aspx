<%@ Page Title="Customer Form" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="IPLProject.CustomerPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2 style="color: #1E40AF; margin-top:0;">User - Customer Details</h2>
        <asp:Button ID="btnBack" runat="server" Text="<< Back to Login" CssClass="btn-ash" OnClick="btnBack_Click" CausesValidation="false" />
    </div>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>

    <div class="form-box">
        <h3 style="margin-top:0;">Add / Update Customer</h3>
        <asp:HiddenField ID="hfCustomerId" runat="server" />

        <label>Customer Name <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtName" runat="server" placeholder="Enter Full Name"></asp:TextBox>

        <label>Email <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter Email"></asp:TextBox>

        <label>Phone <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtPhone" runat="server" placeholder="Enter Phone Number"></asp:TextBox>

        <label>City <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtCity" runat="server" placeholder="Enter City"></asp:TextBox>

        <div style="margin-top:10px;">
            <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn-green" OnClick="btnAdd_Click" />
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn-blue" OnClick="btnUpdate_Click" Visible="false" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn-ash" OnClick="btnClear_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="False" CssClass="grid-table" OnRowCommand="gvCustomers_RowCommand">
        <Columns>
            <asp:BoundField DataField="CustomerId" HeaderText="ID" />
            <asp:BoundField DataField="FullName" HeaderText="Full Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Phone" HeaderText="Phone" />
            <asp:BoundField DataField="City" HeaderText="City" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditRow" CommandArgument='<%# Eval("CustomerId") %>' CssClass="btn-blue" CausesValidation="false" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteRow" CommandArgument='<%# Eval("CustomerId") %>' CssClass="btn-red" OnClientClick="return confirm('Delete this customer?');" CausesValidation="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="IPLProject.Login" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>IPL Ticket Booking - Login</title>
    <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="max-width: 400px; margin: 80px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(30,58,138,0.1);">
            <h2 style="text-align: center; color: #1E40AF; margin-top: 0;">IPL Ticket Booking Login</h2>
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>

            <label>Username <asp:RequiredFieldValidator ID="rfvUser" runat="server" ControlToValidate="txtUsername" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter username"></asp:TextBox>

            <label>Password <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtPassword" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter password"></asp:TextBox>

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-green" OnClick="btnLogin_Click" Width="100%" style="margin-top:10px;" />

            <div style="margin-top: 20px; font-size: 12px; color: #4B5563; border-top: 1px solid #BFDBFE; padding-top: 10px;">
                <strong>Lab Test Credentials:</strong><br />
                Admin: <b>admin</b> / <b>admin123</b> (Matches, Stands, Seats)<br />
                User: <b>user1</b> / <b>user123</b> (Customer &amp; Booking Forms)
            </div>
        </div>
    </form>
</body>
</html>

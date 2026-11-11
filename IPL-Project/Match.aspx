<%@ Page Title="Match Form" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Match.aspx.cs" Inherits="IPLProject.MatchPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2 style="color: #1E40AF; margin-top:0;">Admin - Match Management</h2>
        <asp:Button ID="btnBack" runat="server" Text="<< Back to Login" CssClass="btn-ash" OnClick="btnBack_Click" CausesValidation="false" />
    </div>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>

    <div class="form-box">
        <h3 style="margin-top:0;">Add / Update Match</h3>
        <asp:HiddenField ID="hfMatchId" runat="server" />

        <label>Match Name <asp:RequiredFieldValidator ID="rfvMatchName" runat="server" ControlToValidate="txtMatchName" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtMatchName" runat="server" placeholder="e.g. CSK vs MI - Match 01"></asp:TextBox>

        <label>Team A <asp:RequiredFieldValidator ID="rfvTeamA" runat="server" ControlToValidate="txtTeamA" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtTeamA" runat="server" placeholder="e.g. CSK"></asp:TextBox>

        <label>Team B <asp:RequiredFieldValidator ID="rfvTeamB" runat="server" ControlToValidate="txtTeamB" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtTeamB" runat="server" placeholder="e.g. MI"></asp:TextBox>

        <label>Venue <asp:RequiredFieldValidator ID="rfvVenue" runat="server" ControlToValidate="txtVenue" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtVenue" runat="server" placeholder="e.g. Chepauk Stadium, Chennai"></asp:TextBox>

        <label>Match Date (YYYY-MM-DD HH:MM) <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtDate" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtDate" runat="server" placeholder="2026-04-15 19:30"></asp:TextBox>

        <div style="margin-top:10px;">
            <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn-green" OnClick="btnAdd_Click" />
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn-blue" OnClick="btnUpdate_Click" Visible="false" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn-ash" OnClick="btnClear_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:GridView ID="gvMatches" runat="server" AutoGenerateColumns="False" CssClass="grid-table" OnRowCommand="gvMatches_RowCommand">
        <Columns>
            <asp:BoundField DataField="MatchId" HeaderText="ID" />
            <asp:BoundField DataField="MatchName" HeaderText="Match" />
            <asp:BoundField DataField="TeamA" HeaderText="Team A" />
            <asp:BoundField DataField="TeamB" HeaderText="Team B" />
            <asp:BoundField DataField="Venue" HeaderText="Venue" />
            <asp:BoundField DataField="MatchDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditRow" CommandArgument='<%# Eval("MatchId") %>' CssClass="btn-blue" CausesValidation="false" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteRow" CommandArgument='<%# Eval("MatchId") %>' CssClass="btn-red" OnClientClick="return confirm('Delete this match?');" CausesValidation="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

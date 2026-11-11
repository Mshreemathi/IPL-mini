<%@ Page Title="Stand Form" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="StandMaster.aspx.cs" Inherits="IPLProject.StandMasterPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2 style="color: #1E40AF; margin-top:0;">Admin - Stand Management</h2>
        <asp:Button ID="btnBack" runat="server" Text="<< Back to Matches" CssClass="btn-ash" OnClick="btnBack_Click" CausesValidation="false" />
    </div>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>

    <div class="form-box">
        <h3 style="margin-top:0;">Add / Update Stand</h3>
        <asp:HiddenField ID="hfStandId" runat="server" />

        <label>Select Match <asp:RequiredFieldValidator ID="rfvMatch" runat="server" ControlToValidate="ddlMatch" InitialValue="" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:DropDownList ID="ddlMatch" runat="server"></asp:DropDownList>

        <label>Stand Name <asp:RequiredFieldValidator ID="rfvStandName" runat="server" ControlToValidate="txtStandName" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtStandName" runat="server" placeholder="e.g. North VIP Stand"></asp:TextBox>

        <label>Base Price (Rs) <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtPrice" runat="server" placeholder="e.g. 2500"></asp:TextBox>

        <label>Total Seats <asp:RequiredFieldValidator ID="rfvSeats" runat="server" ControlToValidate="txtSeats" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtSeats" runat="server" placeholder="e.g. 50"></asp:TextBox>

        <div style="margin-top:10px;">
            <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn-green" OnClick="btnAdd_Click" />
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn-blue" OnClick="btnUpdate_Click" Visible="false" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn-ash" OnClick="btnClear_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:GridView ID="gvStands" runat="server" AutoGenerateColumns="False" CssClass="grid-table" OnRowCommand="gvStands_RowCommand">
        <Columns>
            <asp:BoundField DataField="StandId" HeaderText="ID" />
            <asp:BoundField DataField="MatchName" HeaderText="Match" />
            <asp:BoundField DataField="StandName" HeaderText="Stand Name" />
            <asp:BoundField DataField="Price" HeaderText="Price (Rs)" DataFormatString="{0:N2}" />
            <asp:BoundField DataField="TotalSeats" HeaderText="Total Seats" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditRow" CommandArgument='<%# Eval("StandId") %>' CssClass="btn-blue" CausesValidation="false" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteRow" CommandArgument='<%# Eval("StandId") %>' CssClass="btn-red" OnClientClick="return confirm('Delete this stand?');" CausesValidation="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

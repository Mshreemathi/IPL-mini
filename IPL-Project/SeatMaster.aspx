<%@ Page Title="Seat Form" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="SeatMaster.aspx.cs" Inherits="IPLProject.SeatMasterPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2 style="color: #1E40AF; margin-top:0;">Admin - Seat Management</h2>
        <asp:Button ID="btnBack" runat="server" Text="<< Back to Stands" CssClass="btn-ash" OnClick="btnBack_Click" CausesValidation="false" />
    </div>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>

    <div class="form-box">
        <h3 style="margin-top:0;">Add / Update Seat</h3>
        <asp:HiddenField ID="hfSeatId" runat="server" />

        <label>Select Stand <asp:RequiredFieldValidator ID="rfvStand" runat="server" ControlToValidate="ddlStand" InitialValue="" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:DropDownList ID="ddlStand" runat="server"></asp:DropDownList>

        <label>Seat Number <asp:RequiredFieldValidator ID="rfvSeatNumber" runat="server" ControlToValidate="txtSeatNumber" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtSeatNumber" runat="server" placeholder="e.g. N-101"></asp:TextBox>

        <label>Seat Price (Rs) <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtPrice" runat="server" placeholder="e.g. 3500"></asp:TextBox>

        <div style="margin-top:10px;">
            <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn-green" OnClick="btnAdd_Click" />
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn-blue" OnClick="btnUpdate_Click" Visible="false" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn-ash" OnClick="btnClear_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:GridView ID="gvSeats" runat="server" AutoGenerateColumns="False" CssClass="grid-table" OnRowCommand="gvSeats_RowCommand">
        <Columns>
            <asp:BoundField DataField="SeatId" HeaderText="ID" />
            <asp:BoundField DataField="StandName" HeaderText="Stand" />
            <asp:BoundField DataField="SeatNumber" HeaderText="Seat No" />
            <asp:BoundField DataField="Price" HeaderText="Price (Rs)" DataFormatString="{0:N2}" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditRow" CommandArgument='<%# Eval("SeatId") %>' CssClass="btn-blue" CausesValidation="false" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteRow" CommandArgument='<%# Eval("SeatId") %>' CssClass="btn-red" OnClientClick="return confirm('Delete this seat?');" CausesValidation="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

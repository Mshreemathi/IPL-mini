<%@ Page Title="Booking Form" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="IPLProject.BookingPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display:flex; justify-content:space-between; align-items:center;">
        <h2 style="color: #1E40AF; margin-top:0;">User - Ticket Booking Form</h2>
        <asp:Button ID="btnBack" runat="server" Text="<< Back to Customer Form" CssClass="btn-ash" OnClick="btnBack_Click" CausesValidation="false" />
    </div>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>

    <div class="form-box">
        <h3 style="margin-top:0;">Add / Update Booking</h3>
        <asp:HiddenField ID="hfBookingId" runat="server" />

        <label>Select Customer <asp:RequiredFieldValidator ID="rfvCust" runat="server" ControlToValidate="ddlCustomer" InitialValue="" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:DropDownList ID="ddlCustomer" runat="server"></asp:DropDownList>

        <label>Select Match <asp:RequiredFieldValidator ID="rfvMatch" runat="server" ControlToValidate="ddlMatch" InitialValue="" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:DropDownList ID="ddlMatch" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMatch_SelectedIndexChanged"></asp:DropDownList>

        <label>Select Stand <asp:RequiredFieldValidator ID="rfvStand" runat="server" ControlToValidate="ddlStand" InitialValue="" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:DropDownList ID="ddlStand" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStand_SelectedIndexChanged"></asp:DropDownList>

        <label>Select Seat <asp:RequiredFieldValidator ID="rfvSeat" runat="server" ControlToValidate="ddlSeat" InitialValue="" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:DropDownList ID="ddlSeat" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSeat_SelectedIndexChanged"></asp:DropDownList>

        <label>Ticket Count <asp:RequiredFieldValidator ID="rfvCount" runat="server" ControlToValidate="txtTicketCount" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtTicketCount" runat="server" Text="1" AutoPostBack="true" OnTextChanged="txtTicketCount_TextChanged"></asp:TextBox>

        <label>Total Amount (Rs)</label>
        <asp:TextBox ID="txtTotalAmount" runat="server" ReadOnly="true"></asp:TextBox>

        <div style="margin-top:10px;">
            <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn-green" OnClick="btnAdd_Click" />
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn-blue" OnClick="btnUpdate_Click" Visible="false" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn-ash" OnClick="btnClear_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False" CssClass="grid-table" OnRowCommand="gvBookings_RowCommand">
        <Columns>
            <asp:BoundField DataField="BookingId" HeaderText="ID" />
            <asp:BoundField DataField="FullName" HeaderText="Customer" />
            <asp:BoundField DataField="MatchName" HeaderText="Match" />
            <asp:BoundField DataField="StandName" HeaderText="Stand" />
            <asp:BoundField DataField="SeatNumber" HeaderText="Seat" />
            <asp:BoundField DataField="TicketCount" HeaderText="Tickets" />
            <asp:BoundField DataField="TotalAmount" HeaderText="Total (Rs)" DataFormatString="{0:N2}" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditRow" CommandArgument='<%# Eval("BookingId") %>' CssClass="btn-blue" CausesValidation="false" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteRow" CommandArgument='<%# Eval("BookingId") %>' CssClass="btn-red" OnClientClick="return confirm('Delete this booking?');" CausesValidation="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

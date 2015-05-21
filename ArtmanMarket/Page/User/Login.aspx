<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Page_User_Login" Title="ورود به سايت" ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Src="~/WebControls/User/LoginPanel.ascx" TagName="LoginPanel" TagPrefix="uc2" %>
<asp:Content ID="LoginContent" ContentPlaceHolderID="MasterContentPlaceHolder" runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            ورود به سايت</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        &nbsp;<asp:Label ID="CaptionLabel" Font-Bold="true" runat="server" Text="براي ورود به اين قسمت بايد ابتدا وارد سايت شويد."
            Visible='<%# !Request.IsAuthenticated && !String.IsNullOrEmpty(Request.QueryString["ReturnUrl"]) %>'></asp:Label>
        <br />
        <br />
        <br />
        <center>
            <uc2:LoginPanel ID="UserLoginPanel" runat="server" />
            <%--<asp:Panel ID="AdminInfoPanel" runat="server" Style="font-family: Courier New; font-weight: bold;
                color: OrangeRed; text-align: center; direction: ltr" Visible='<%# !Request.IsAuthenticated %>'>
                <br />
                Admin Username : admin&nbsp;
                <br />
                Admin Password : artman
            </asp:Panel>--%>
            <br />
            <br />
        </center>
    </div>
</asp:Content>

<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ChangePassword.aspx.cs" Inherits="Page_User_ChangePassword" Title="تغيير کلمه عبور"
    ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Src="~/WebControls/User/ChangePasswordPanel.ascx" TagName="ChangePasswordPanel"
    TagPrefix="uc1" %>
<asp:Content ID="MasterHeadContent" ContentPlaceHolderID="HeadContentPlaceHolder"
    runat="Server">
    <link href="<%= ResolveUrl("~/StyleSheets/AjaxControlStyles.css") %>" rel="stylesheet"
        type="text/css" />
</asp:Content>
<asp:Content ID="ChangePasswordContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            تغيير کلمه عبور</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <uc1:ChangePasswordPanel ID="UserChangePasswordPanel" runat="server"></uc1:ChangePasswordPanel>
        &nbsp;<br />
    </div>
</asp:Content>

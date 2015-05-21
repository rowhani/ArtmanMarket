<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" Title="دسترسي محدود" %>

<asp:Content ID="AccessDeniedContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <br />
        &nbsp; <span style="color: #ff0000; font-family: Tahoma; font-weight: bold">پيغام خطا!</span>
        <br />
        <br />
        <center>
            <span style="font-size: 14pt; color: maroon; font-family: Tahoma, sans-serif">شما اجازه
                دسترسي به اين قسمت را نداريد.</span>
            <br />
            <br />
            <span style="font-size: 14pt; font-style: italic; color: maroon; font-family: Verdana, sans-serif">
                HTTP Error 401 - Access Denied </span>
        </center>
        <br />
    </div>
</asp:Content>

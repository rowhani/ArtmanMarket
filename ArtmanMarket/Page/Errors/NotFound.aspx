<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" Title="صفحه اشتباه" %>

<asp:Content ID="AccessDeniedContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <br />
        &nbsp; <span style="font-family: Tahoma; font-weight: bold">کاربر گرامي:</span>
        <br />
        <br />
        <center>
            <span style="font-size: 14pt; color: maroon; font-family: Tahoma, sans-serif">صفحه مورد
                نظر شما وجود ندارد.</span>
            <br />
            <br />
            <span style="font-size: 14pt; font-style: italic; color: maroon; font-family: Verdana, sans-serif">
                HTTP Error 404 - Not Found </span>
        </center>
        <br />
    </div>
</asp:Content>

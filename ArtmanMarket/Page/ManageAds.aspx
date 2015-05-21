<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ManageAds.aspx.cs" Inherits="Page_ManageAds" Title="مديريت تبليغات"
    MaintainScrollPositionOnPostback="true" ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Src="~/WebControls/Master/FlashAdPanel.ascx" TagName="FlashAdPanel"
    TagPrefix="uc1" %>
<asp:Content ID="AdsContent" ContentPlaceHolderID="MasterContentPlaceHolder" runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            مديريت تبليغات</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <b>دراين قسمت شما مي توانيد تبليغ مورد نظر خود را حذف، اضافه، و يا جابجا کنيد.</b>
        <br />
        <br />
        <br />
        <uc1:FlashAdPanel ID="ManageAdsFlashAdPanel" runat="server" />
        <br />
    </div>
</asp:Content>

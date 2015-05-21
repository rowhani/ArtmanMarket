<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ShowCategory.aspx.cs" Inherits="Page_Product_ShowCategory" Title="نمايش زيرشاخه"
    ErrorPage="~/Page/Errors/Error500.htm" MaintainScrollPositionOnPostback="true" %>

<%@ Register Src="~/WebControls/Product/ProductList.ascx" TagName="ProductList" TagPrefix="uc1" %>
<asp:Content ID="MasterHeadContent" ContentPlaceHolderID="HeadContentPlaceHolder"
    runat="Server">
    <link href="<%= ResolveUrl("~/StyleSheets/AjaxControlStyles.css") %>" rel="stylesheet"
        type="text/css" />
</asp:Content>
<asp:Content ID="ShowCategoryContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            نمايش زيرشاخه</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <center>
            <uc1:ProductList ID="ShowCategoryProductList" runat="server" TitleLogoUrl="~/Images/Product/category.jpg"
                TitleText="زيرشاخه" NumOfItemsPerPage="9" SqlSelectQuery='<%# "SELECT ID, Name, LogoImageUrl, BrandImageUrl, ImagesUrl, ModifiedDate, MinPrice, MaxPrice, Overview, Details, Tags, Rate, Hits, Category_ID, CreatedDate FROM Product WHERE Category_ID=" + Request.QueryString["catid"] %>' />
            <asp:Label ID="NotFoundLabel" runat="server" Text="هيچ کالايي در اين زيرشاخه يافت نشد."
                Style="font-family: Tahoma; font-size: smaller; font-weight: bold; direction: rtl"
                Visible='<%# ShowCategoryProductList.NumOfRecords == 0 %>'></asp:Label>
            <br />
            <br />
            <asp:Panel ID="SubCategoryListPanel" runat="server" Style="font-family: Tahoma; font-size: small;
                font-weight: bold; direction: rtl; text-align: right" Visible="false">
                <br />
                <asp:Label ID="SubCategoryListTitleLabel" runat="server" Text="ليست زيرشاخه ها" ForeColor="#009999"></asp:Label>
                <br />
                <br />
                <asp:BulletedList ID="SubCategoryBulletedList" runat="server" DisplayMode="HyperLink">
                </asp:BulletedList>
            </asp:Panel>
        </center>
        &nbsp;
        <br />
    </div>
</asp:Content>

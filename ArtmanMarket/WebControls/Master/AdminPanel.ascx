<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdminPanel.ascx.cs" Inherits="WebControls_Master_AdminPanel" %>
<%-- <%@ OutputCache Duration="6000" VaryByParam="None"%> --%>
<link href="~/StyleSheets/ControlStyles.css" rel="stylesheet" type="text/css" />
<asp:Panel ID="AdminPanel" runat="server" Style="text-align: right" Width="200" Visible='<%# Request.IsAuthenticated && ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()) %>'>
    <asp:Image ID="AdminLogoImage" Style="margin-right: 1px" runat="server" ImageUrl="~/Images/Admin/AdminLogo.gif"
        Width="202"></asp:Image>
    <div class="loginTable" style="direction: rtl; line-height: 20px; padding-bottom: 5px;
        background-color: White">
        &nbsp;<asp:HyperLink ID="AddProductHyperLink" runat="server" NavigateUrl="~/Page/Product/AddProduct.aspx">اضافه کردن محصول</asp:HyperLink><br />
        &nbsp;<asp:HyperLink ID="EditAndRemoveProductHyperLink" runat="server" NavigateUrl="~/Page/Product/SearchProduct.aspx">ويرايش و حذف محصولات</asp:HyperLink><br />
        &nbsp;<asp:HyperLink ID="AddShopHyperLink" runat="server" NavigateUrl="~/Page/Shop/Seller.aspx">اضافه کردن فروشگاه</asp:HyperLink><br />
        &nbsp;<asp:HyperLink ID="EditAndRemoveShopHyperLink" runat="server" NavigateUrl="~/Page/Shop/ManageShop.aspx">ويرايش و حذف فروشگاه ها</asp:HyperLink><br />
        &nbsp;<asp:HyperLink ID="ManageAccountHyperLink" runat="server" NavigateUrl="~/Page/User/ManageAccount.aspx">مديريت کاربران</asp:HyperLink><br />
        &nbsp;<asp:HyperLink ID="ManageCategoriesHyperLink" runat="server" NavigateUrl="~/Page/Product/ManageCategory.aspx">مديريت شاخه ها</asp:HyperLink><br />
        &nbsp;<asp:HyperLink ID="ManageAdsHyperLink" runat="server" NavigateUrl="~/Page/ManageAds.aspx">مديريت تبليغات</asp:HyperLink><br />
        &nbsp;<asp:HyperLink ID="ManageResourcesHyperLink" runat="server" NavigateUrl="~/Page/FileManager/ResourceManager.aspx">مديريت منابع</asp:HyperLink><br />
        &nbsp;<asp:HyperLink ID="ManageDatabaseHyperLink" runat="server" NavigateUrl="~/Page/ManageDatabase.aspx">مديريت پايگاه داده</asp:HyperLink><br />
        &nbsp;<asp:HyperLink ID="ManageLayoutHyperLink" runat="server" NavigateUrl="~/Page/ManageLayout.aspx">مديريت طرح بندي</asp:HyperLink><br />
    </div>
</asp:Panel>

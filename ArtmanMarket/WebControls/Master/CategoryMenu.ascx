<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CategoryMenu.ascx.cs"
    Inherits="WebControls_Master_CategoryMenu" %>
<div dir="rtl" align="right">
    <asp:Menu ID="CategoriesMenu" runat="server" BackColor="#E3EAEB" DataSourceID="CategorySiteMapDataSource"
        Font-Size="small" Font-Names="Tahoma" ForeColor="blue" Orientation="Vertical"
        DynamicPopOutImageUrl="~/Images/TreeLineImages/Menu_Popout.gif" StaticPopOutImageUrl="~/Images/TreeLineImages/Menu_Popout.gif">
        <StaticMenuItemStyle HorizontalPadding="3px" VerticalPadding="5px" BorderColor="silver" BorderWidth="1px" />
        <DynamicHoverStyle BackColor="#666666" ForeColor="White" />
        <DynamicMenuStyle BackColor="#E3EAEB" CssClass="dynamicMenu" />
        <StaticSelectedStyle BackColor="#1C5E55" />
        <DynamicSelectedStyle BackColor="#1C5E55" />
        <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="5px" BorderColor="silver" BorderWidth="1px" />
        <StaticHoverStyle BackColor="#666666" ForeColor="White" />
        <DataBindings>
            <asp:MenuItemBinding TextField="Title" NavigateUrlField="Url" ValueField="Key" ToolTipField="Description"
                Selectable="true" />
        </DataBindings>
    </asp:Menu>
    <asp:SiteMapDataSource ID="CategorySiteMapDataSource" runat="server" ShowStartingNode="false" />
</div>

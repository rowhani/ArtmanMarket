<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductList.ascx.cs" Inherits="WebControls_Product_ProductList" %>
<%@ Register Src="~/WebControls/Product/ProductOverviewPanel.ascx" TagName="ProductOverviewPanel"
    TagPrefix="uc1" %>
<center>
    <asp:Panel ID="ProductListPanel" Width="535" HorizontalAlign="Center" runat="server">
        <asp:Panel ID="HeaderPanel" runat="server" Style="text-align: right; direction: rtl;"
            Visible='<%# String.IsNullOrEmpty(TitleLogoUrl) && String.IsNullOrEmpty(TitleText) ? false : true %>'>
            <table>
                <tr>
                    <td>
                        <asp:Image ID="TitleImage" runat="server" ImageUrl='<%# TitleLogoUrl %>' Width="40px"
                            Height="40px" Visible='<%# !String.IsNullOrEmpty(TitleLogoUrl) %>' />
                    </td>
                    <td>
                        <asp:Label ID="TitleLabel" runat="server" CssClass="productPanelTitle" Text='<%# TitleText %>'></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
        </asp:Panel>
        <uc1:ProductOverviewPanel ID="UpdatedProductOverviewPanel" runat="server" TitleText="کالاهاي به روز شده"
            TitleLogoUrl="~/Images/Product/updated.jpg" />
        <br />
        <br />
        <uc1:ProductOverviewPanel ID="MostViewedProductOverviewPane" runat="server" TitleText="پربيننده ترين کالاها"
            TitleLogoUrl="~/Images/Product/mostViewed.jpg" />
        <br />
        <br />
        <uc1:ProductOverviewPanel ID="MostRatedProductOverviewPanel" runat="server" TitleText="پرامتيازترين کالاها"
            TitleLogoUrl="~/Images/Product/mostRated.jpg" />
        <br />
        <br />
        <uc1:ProductOverviewPanel ID="NewestProductOverviewPanel" runat="server" TitleText="جديدترين محصولات"
            TitleLogoUrl="~/Images/Product/newest.gif" />
    </asp:Panel>
</center>

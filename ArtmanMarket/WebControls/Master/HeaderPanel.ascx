<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HeaderPanel.ascx.cs" Inherits="WebControls_Master_HeaderPanel" %>
<link href="~/StyleSheets/ControlStyles.css" rel="stylesheet" type="text/css" />
<div id="header">
    <div id="headerLeft">
        <asp:HyperLink ID="ArtmanMarketEnLogoHyperLink" runat="server" Style="border-width: 0px;"
            ImageUrl="~/Images/Master/ArtmanMarketEnLogo.png" NavigateUrl="~/"></asp:HyperLink>
    </div>
    <div id="headerCenter">
        <div style="vertical-align: bottom">
            <asp:Image ID="ArtmanHeaderLogoImage" runat="server" ImageUrl="~/Images/Master/ArtmanHeaderLogo.png"
                Style="border-width: 0px; top: 1px; vertical-align: bottom;" />
        </div>
        <div id="headerLinks">
            <asp:HyperLink ID="HomeHyperLink" CssClass="hlHome" runat="server" ToolTip="صفحه‌ي اصلي"
                Text="صفحه‌ي اصلي" NavigateUrl="~/"></asp:HyperLink>
            <asp:HyperLink ID="CatsHyperLink" CssClass="hlCat" runat="server" ToolTip="کالاها"
                Text="کالاها" NavigateUrl="~/Page/Product/ShowAllCategories.aspx"></asp:HyperLink>
            <asp:HyperLink ID="NewsHyperLink" CssClass="hlNews" runat="server" ToolTip="اخبار"
                Text="اخبار" NavigateUrl="~/Page/News.aspx"></asp:HyperLink>
            <asp:HyperLink ID="AboutHyperLink" CssClass="hlAbout" runat="server" ToolTip="درباره‌ي ما"
                Text="درباره‌ي ما" NavigateUrl="~/Page/AboutUs.aspx"></asp:HyperLink>
            <asp:HyperLink ID="ContactHyperLink" CssClass="hlContact" runat="server" ToolTip="تماس با ما"
                Text="تماس با ما" NavigateUrl="~/Page/ContactUs.aspx"></asp:HyperLink>
        </div>
    </div>
    <div id="headerRight">
        <div style="margin-top: 15px">
            <asp:HyperLink ID="ArtmanMarketFaLogoHyperLink" runat="server" Style="border-width: 0px;"
                ImageUrl="~/Images/Master/ArtmanMarketFaLogo.png" NavigateUrl="~/"></asp:HyperLink>
            <asp:Panel ID="SearchPanel" runat="server" CssClass="searchBox" DefaultButton="SearchImageButton">
                <table cellpadding="0" cellspacing="0">
                    <tbody>
                        <tr>
                            <td>
                                <asp:Image ID="SearchRightImage" runat="server" Style="border-width: 0px;" ImageUrl="~/Images/Master/SearchRight.gif" />
                            </td>
                            <td>
                                <asp:Image ID="SearchIconImage" runat="server" Style="border-width: 0px;" ImageUrl="~/Images/Master/SearchIcon.gif" />
                            </td>
                            <td id="txt">
                                <asp:TextBox ID="SearchTextBox" runat="server" Text='<%# !String.IsNullOrEmpty(Request.QueryString["q"]) ? Request.QueryString["q"] : "جستجوي کالا" %>'
                                    CssClass="searchTextBox" MaxLength="40" onblur="if(this.value=='')this.value='جستجوي کالا';"
                                    onfocus="this.value=''"></asp:TextBox>
                            </td>
                            <td id="btn">
                                <asp:ImageButton ID="SearchImageButton" runat="server" Width="19px" Height="24px"
                                    ImageUrl="~/Images/Master/SearchGo.gif" BorderWidth="0px" CausesValidation="false"
                                    OnClick="SearchImageButton_Click" ValidationGroup="HeadSearchPanel" />
                            </td>
                            <td>
                                <asp:Image ID="SearchLeftImage" runat="server" Style="border-width: 0px;" ImageUrl="~/Images/Master/SearchLeft.gif" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </asp:Panel>
        </div>
    </div>
</div>

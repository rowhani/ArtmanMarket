<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FooterPanel.ascx.cs" Inherits="WebControls_Master_FooterPanel" %>
<%--  <%@ OutputCache Duration="6000" VaryByParam="None" %> --%>
<link href="~/StyleSheets/ControlStyles.css" rel="stylesheet" type="text/css" />
<div id="footer" style="position: relative;">
    <div style="position: absolute; left: 0px; top: 0px; padding: 3px;">
        <a href="#TOP" style="font-size: 9px">ʌ بازگشت به بالاي صفحه</a>
    </div>
    <div id="footerCenter">
        <div>
            <table style="width: 530px; text-align: center; margin: auto" cellspacing="0" cellpadding="0"
                border="0">
                <tr>
                    <td>
                        <asp:Image ID="BottomMenuRightImage" runat="server" ImageUrl="~/Images/Master/BottomMenuRight.gif"
                            Style="border-width: 0px;" />
                    </td>
                    <td style="background-color: #3c5c9b; text-align: center;" id="bottomMenu">
                        <asp:HyperLink ID="HomeHyperLink" runat="server" ToolTip="صفحه‌ي اصلي" Text="صفحه‌ي اصلي"
                            NavigateUrl="~/"></asp:HyperLink>
                        &nbsp; &nbsp;<asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Master/BottomMenuSeperator.gif"
                            Style="border-width: 0px;" />
                        &nbsp;&nbsp;
                        <asp:HyperLink ID="CatsHyperLink" runat="server" ToolTip="کالاها" Text="کالاها" NavigateUrl="~/Page/Product/ShowAllCategories.aspx"></asp:HyperLink>
                        &nbsp; &nbsp;<asp:Image ID="Image2" runat="server" ImageUrl="~/Images/Master/BottomMenuSeperator.gif"
                            Style="border-width: 0px;" />
                        &nbsp;&nbsp;
                        <asp:HyperLink ID="NewsHyperLink" runat="server" ToolTip="اخبار" Text="اخبار" NavigateUrl="~/Page/News.aspx"></asp:HyperLink>
                        &nbsp; &nbsp;<asp:Image ID="Image3" runat="server" ImageUrl="~/Images/Master/BottomMenuSeperator.gif"
                            Style="border-width: 0px;" />
                        &nbsp;&nbsp;
                        <asp:HyperLink ID="AboutHyperLink" runat="server" ToolTip="درباره‌ي ما" Text="درباره‌ي ما"
                            NavigateUrl="~/Page/AboutUs.aspx"></asp:HyperLink>
                        &nbsp; &nbsp;<asp:Image ID="Image5" runat="server" ImageUrl="~/Images/Master/BottomMenuSeperator.gif"
                            Style="border-width: 0px;" />
                        &nbsp;&nbsp;
                        <asp:HyperLink ID="ContactHyperLink" CssClass="hlContact" runat="server" ToolTip="تماس با ما"
                            Text="تماس با ما" NavigateUrl="~/Page/ContactUs.aspx"></asp:HyperLink>
                    </td>
                    <td>
                        <asp:Image ID="BottomMenuLeftImage" runat="server" ImageUrl="~/Images/Master/BottomMenuLeft.gif"
                            Style="border-width: 0px;" />
                    </td>
                </tr>
            </table>
        </div>
        Copyright© 2004-2011 Artman<sup>®</sup> Market
        <br />
        <span style="color: #ff6600; font-weight: bold">Developer: Payman Rowhani </span>
    </div>
</div>

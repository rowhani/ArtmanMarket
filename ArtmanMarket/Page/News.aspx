<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="News.aspx.cs" Inherits="Page_News" Title="اخبار" ErrorPage="~/Page/News.aspx" %>

<%@ Register Assembly="RssToolkit" Namespace="RssToolkit.Web.WebControls" TagPrefix="cc1" %>
<asp:Content ID="NewsContent" ContentPlaceHolderID="MasterContentPlaceHolder" runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: gray">
            اخبار</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <asp:Panel ID="NewsPanel" runat="server" EnableViewState="false">
            <table cellspacing="5">
                <tr>
                    <td valign="top">
                        <br />
                        <strong><span style="color: #0066cc; font-weight: bold; font-size: 20px">&nbsp;&nbsp;&nbsp;فهرست
                            خبرگزاري ها</span></strong>
                        <br />
                        <br />
                        <asp:TreeView ID="NewsListTreeView" runat="server" DataSourceID="NewsListSiteMapDataSource"
                            ImageSet="News" NodeIndent="10" ShowExpandCollapse="false">
                            <DataBindings>
                                <asp:TreeNodeBinding TextField="Title" ValueField="Key" NavigateUrlField="Url" SelectAction="Select" />
                            </DataBindings>
                            <ParentNodeStyle Font-Bold="False" />
                            <HoverNodeStyle Font-Underline="True" />
                            <SelectedNodeStyle Font-Underline="True" Font-Bold="true" HorizontalPadding="0px"
                                VerticalPadding="0px" />
                            <NodeStyle Font-Names="Tahoma" Font-Size="10pt" ForeColor="Black" HorizontalPadding="5px"
                                NodeSpacing="0px" VerticalPadding="0px" />
                        </asp:TreeView>
                        <asp:SiteMapDataSource ID="NewsListSiteMapDataSource" runat="server" SiteMapProvider="NewsFeedProvider"
                            ShowStartingNode="false" />
                    </td>
                    <td valign="top">
                        <div style="width: 255px">
                            <asp:SqlDataSource ID="NewsFeedSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
                                SelectCommand="SELECT * FROM [NewsFeed] WHERE ([ID] = @ID)">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" DefaultValue="1" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:FormView ID="NewsFormView" runat="server" DataKeyNames="ID" DataSourceID="NewsFeedSqlDataSource">
                                <ItemTemplate>
                                    <center>
                                        <asp:Label ID="CaptionLabel" runat="server" Text='<%# Eval("Title") %>' Width="255px"
                                            Font-Bold="true" Font-Size="17px" Font-Names="Tahoma" ForeColor="#ff6633"></asp:Label>
                                        <br />
                                        <br />
                                        <br />
                                    </center>
                                    <cc1:RssDataSource ID="NewsRssDataSource" runat="server" MaxItems="20" Url='<%# Eval("Url") %>'>
                                    </cc1:RssDataSource>
                                    <asp:Repeater ID="NewsRepeater" runat="server" DataSourceID="NewsRssDataSource">
                                        <HeaderTemplate>
                                            <table width="255px">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr style="vertical-align: middle">
                                                <td>
                                                    <asp:Image ID="FeedImage" runat="server" ToolTip="RSS" ImageUrl="~/Images/Admin/feed.png" /></td>
                                                <td>
                                                    <asp:HyperLink ID="FeedTitleHyperLink" runat="server" NavigateUrl='<%# Eval("link") %>'
                                                        Width="255px" Text='<%# Eval("title") %>' Style="text-decoration: none; font-size: 15px;
                                                        font-family: Tahoma" Target="_blank"></asp:HyperLink></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Label ID="FeedPubDateLabel" runat="server" Text='<%# GetPersianDate(Eval("pubDateParsed")) %>'
                                                        Width="255px" Font-Size="Small" Font-Italic="true" Style="margin-top: 2px"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Label ID="FeedDescriptionLabel" runat="server" Text='<%# Eval("description") %>'
                                                        Width="255px" Style="text-align: justify"></asp:Label>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                        <SeparatorTemplate>
                                            <tr>
                                                <td colspan="2">
                                                    &nbsp;</td>
                                            </tr>
                                        </SeparatorTemplate>
                                    </asp:Repeater>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <div style="text-align: center; font-weight: bold; font-family: Tahoma; font-size: small;
                                        color: Violet; width: 255px">
                                        از ليست سمت چپ خبرگزاري مورد نظر خود را انتخاب نماييد.
                                    </div>
                                </EmptyDataTemplate>
                            </asp:FormView>
                        </div>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
    </div>
</asp:Content>

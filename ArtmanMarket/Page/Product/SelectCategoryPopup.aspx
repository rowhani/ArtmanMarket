<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectCategoryPopup.aspx.cs"
    Inherits="Page_Product_SelectCategoryPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>انتخاب زيرشاخه</title>
    <link href="~/StyleSheets/ControlStyles.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor="white" style="background-color: White; background: url()">
    <form id="form1" runat="server" style="background-color: White">
        <div class="signupTable">
            <asp:MultiView ID="SelectCategoryMultiView" runat="server" ActiveViewIndex="0">
                <asp:View ID="SelectCategoryView" runat="server">
                    <br />
                    <asp:Label ID="TitleLabel" runat="server" Font-Size="Medium" Font-Bold="True" Font-Names="Tahoma"
                        ForeColor="Peru">
        لطفا از ليست زير يک زيرشاخه انتخاب نماييد
                    </asp:Label>
                    <br />
                    <br />
                    <br />
                    <asp:TreeView ID="CategoryTreeView" runat="server" DataSourceID="CategorySiteMapDataSource"
                        ExpandDepth="FullyExpand" ImageSet="BulletedList" ShowExpandCollapse="False"
                        OnSelectedNodeChanged="CategoryTreeView_SelectedNodeChanged">
                        <RootNodeStyle Font-Bold="True" ForeColor="#006600" />
                        <ParentNodeStyle Font-Bold="true" />
                        <LeafNodeStyle ForeColor="blue" />
                        <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                        <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px"
                            VerticalPadding="0px" />
                        <NodeStyle Font-Names="Tahoma" Font-Size="10pt" ForeColor="Black" HorizontalPadding="5px"
                            NodeSpacing="2px" VerticalPadding="5px" />
                        <DataBindings>
                            <asp:TreeNodeBinding TextField="Title" ValueField="Key" SelectAction="Select" ToolTipField="Description" />
                        </DataBindings>
                    </asp:TreeView>
                    <asp:SiteMapDataSource ID="CategorySiteMapDataSource" runat="server" ShowStartingNode="false" />
                </asp:View>
                <asp:View ID="ErrorView" runat="server">
                    <br />
                    <br />
                    <center>
                        <asp:Label ID="ErrorLabel" runat="server" Font-Size="Small" Font-Bold="True" Font-Names="Tahoma"
                            ForeColor="Red">
        هيچ زيرشاخه ای وجود ندارد.
                        </asp:Label>
                        <br />
                        <br />
                        <br />
                        <asp:HyperLink ID="CreateNewCategoryHyperLink" runat="server" NavigateUrl="~/Page/Product/ManageCategory.aspx"
                            Target="_blank" Font-Underline="true">ساخت زيرشاخه جديد</asp:HyperLink>
                    </center>
                </asp:View>
            </asp:MultiView>
            <br />
            <br />
        </div>
    </form>
</body>
</html>

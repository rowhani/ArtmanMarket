<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ShowAllCategories.aspx.cs" Inherits="Page_Product_ShowAllCategories"
    Title="نمايش تمام شاخه ها و کالاها" ErrorPage="~/Page/Errors/Error500.htm" %>

<asp:Content ID="CategoriesContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            شاخه ها و کالاها</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <div class="signupTable">
            <asp:TreeView ID="CategoryTreeView" runat="server" DataSourceID="CategorySiteMapDataSource"
                ExpandDepth="FullyExpand" ImageSet="BulletedList" ShowExpandCollapse="False">
                <RootNodeStyle Font-Bold="True" ForeColor="#006600" />
                <ParentNodeStyle Font-Bold="true" />
                <LeafNodeStyle ForeColor="blue" />
                <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px"
                    VerticalPadding="0px" />
                <NodeStyle Font-Names="Tahoma" Font-Size="10pt" ForeColor="Black" HorizontalPadding="5px"
                    NodeSpacing="2px" VerticalPadding="5px" />
                <DataBindings>
                    <asp:TreeNodeBinding TextField="Title" NavigateUrlField="Url" ValueField="Key" SelectAction="selectexpand"
                        ToolTipField="Description" />
                </DataBindings>
            </asp:TreeView>
            <asp:SiteMapDataSource ID="CategorySiteMapDataSource" runat="server" ShowStartingNode="false" />
            <br />
            <br />
        </div>
    </div>
</asp:Content>

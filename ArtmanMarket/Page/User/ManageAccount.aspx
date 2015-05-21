<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ManageAccount.aspx.cs" Inherits="Page_User_ManageAccount" Title="مديريت کاربران"
    ErrorPage="~/Page/Errors/Error500.htm" %>

<asp:Content ID="MasterHeadContent" ContentPlaceHolderID="HeadContentPlaceHolder"
    runat="Server">

    <script language="javascript" type="text/javascript" src='<%= Page.ResolveUrl("~/JavaScripts/GridViewSelect.js")%>'></script>

    <!-- Note that the script needs a seperate close tag, i.e. </script> when a scriptmanager exists on the page -->
</asp:Content>
<asp:Content ID="ManageAccountContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            مديريت کاربران</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <asp:Panel ID="ManageAccountPanel" runat="server" DefaultButton="DeleteButton">
            <div style="direction: rtl; text-align: right; float: right; font-size: 12px">
                <asp:GridView EnableViewState="false" ID="ManageGridView" runat="server" AllowPaging="True"
                    AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999"
                    BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="Username"
                    DataSourceID="ManageSqlDataSource" ForeColor="Black" GridLines="Vertical" HorizontalAlign="Center"
                    OnDataBound="ManageGridView_DataBound" Font-Names="Tahoma">
                    <FooterStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:HyperLinkField DataNavigateUrlFields="Username" DataNavigateUrlFormatString="~/Page/User/ViewDetail.aspx?UserID={0}"
                            DataTextField="Username" HeaderText="نام کاربري" SortExpression="Username" Target="_blank" />
                        <asp:BoundField DataField="FirstName" HeaderText="نام" SortExpression="FirstName" />
                        <asp:BoundField DataField="LastName" HeaderText="نام خانوادگي" SortExpression="LastName" />
                        <asp:BoundField DataField="Email" HeaderText="پست الکترونيکي" SortExpression="Email" />
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox runat="server" ID="HeaderLevelCheckBox" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="RowLevelCheckBox" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                </asp:GridView>
                <br />
                <asp:Button ID="DeleteButton" runat="server" Text="حذف کاربران انتخاب شده" BackColor="#547EB4"
                    ForeColor="#FFFFFF" Font-Bold="True" Font-Size="11px" Font-Names="Tahoma" OnClick="DeleteButton_Click"
                    OnClientClick="javascript: return CheckForSelectedItems();" Height="25px" /><br />
                <br />
                <asp:SqlDataSource ID="ManageSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
                    SelectCommand="SELECT [Username], [Email], [FirstName], [LastName] FROM [Account]"
                    DeleteCommand="DELETE FROM [Account] WHERE [Username] = @Username"></asp:SqlDataSource>
            </div>
        </asp:Panel>
    </div>
</asp:Content>

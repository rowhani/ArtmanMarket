<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SearchProduct.aspx.cs" Inherits="Page_Product_SearchProduct" Title="جستجوي کالا"
    ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Src="~/WebControls/Product/ProductOverviewPanel.ascx" TagName="ProductOverviewPanel"
    TagPrefix="uc1" %>
<asp:Content ID="MasterHeadContent" ContentPlaceHolderID="HeadContentPlaceHolder"
    runat="Server">
    <link href="<%= ResolveUrl("~/StyleSheets/AjaxControlStyles.css") %>" rel="stylesheet"
        type="text/css" />
</asp:Content>
<asp:Content ID="SearchContent" ContentPlaceHolderID="MasterContentPlaceHolder" runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            جستجوي کالا</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <asp:Panel ID="AdvancedSearchPanel" runat="server" DefaultButton="SearchButton">
            <table class="signupTable">
                <tr>
                    <td>
                        <asp:Label ID="NameLabel" runat="server" AssociatedControlID="NameTextBox">نام کالا يا شاخه*</asp:Label>
                    </td>
                    <td>
                        &nbsp;<asp:TextBox ID="NameTextBox" MaxLength="100" runat="server" Width="150px"
                            Text='<%# Request.QueryString["q"] != "جستجوي کالا" ? Request.QueryString["q"] : "" %>'></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ErrorMessage="*"
                            ControlToValidate="NameTextBox"></asp:RequiredFieldValidator>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <asp:Label ID="MaxPriceLabel" runat="server" AssociatedControlID="MaxPriceTextBox">قيمت بيشينه</asp:Label>
                    </td>
                    <td>
                        &nbsp;<asp:TextBox ID="MaxPriceTextBox" runat="server" Width="50px" Text='<%# Request.QueryString["max"] %>'></asp:TextBox>
                    </td>
                    <td>
                        <asp:RegularExpressionValidator ID="MaxPriceRegularExpressionValidator" runat="server"
                            ErrorMessage="عدد نامعتبر" ValidationExpression="\d+(\.\d+)?" ControlToValidate="MaxPriceTextBox"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="TagLabel" runat="server" AssociatedControlID="TagTextBox">برچسب</asp:Label>
                    </td>
                    <td>
                        &nbsp;<asp:TextBox ID="TagTextBox" MaxLength="200" runat="server" Width="150px" Text='<%# Request.QueryString["tag"] %>'></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <asp:Label ID="MinPriceLabel" runat="server" AssociatedControlID="MinPriceTextBox">قيمت کمينه</asp:Label>
                    </td>
                    <td>
                        &nbsp;<asp:TextBox ID="MinPriceTextBox" runat="server" Width="50px" Text='<%# Request.QueryString["min"] %>'></asp:TextBox>
                    </td>
                    <td>
                        <asp:RegularExpressionValidator ID="MinPriceRegularExpressionValidator" runat="server"
                            ErrorMessage="عدد نامعتبر" ValidationExpression="\d+(\.\d+)?" ControlToValidate="MinPriceTextBox"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="7" style="height: 26px">
                        <asp:Button ID="SearchButton" runat="server" Text="جستجو" Font-Bold="True" Height="28px"
                            Width="57px" OnClick="SearchButton_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <center>
            <uc1:ProductOverviewPanel ID="SearchProductOverviewPanel" runat="server" TitleLogoUrl="~/Images/Product/search.png"
                TitleText="کالاهاي يافت شده" NumOfItemsPerPage="9" />
            <asp:Label ID="NotFoundLabel" runat="server" Text="کالايي يافت نشد." Style="font-family: Tahoma;
                font-size: smaller; font-weight: bold; direction: rtl" Visible='<%# (SearchProductOverviewPanel.NumOfRecords == 0) && (Request.QueryString["q"] != "جستجوي کالا") %>'></asp:Label>
        </center>
        <br />
    </div>
</asp:Content>

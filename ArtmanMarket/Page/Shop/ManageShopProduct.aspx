<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ManageShopProduct.aspx.cs" Inherits="Page_Shop_ManageShopProduct" Title="مديريت محصولات فروشگاه"
    ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Src="~/WebControls/Common/WaitPanel.ascx" TagName="WaitPanel" TagPrefix="uc1" %>
<asp:Content ID="ManageShopProductContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            مديريت محصولات فروشگاه</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <center>
            <table>
                <tr>
                    <td>
                        <asp:Image ID="ShopImage" runat="server" ImageUrl="~/Images/Shop/defaultShop.png"
                            Width="40px" Height="40px" />
                    </td>
                    <td style="font-size:13px">
                        ليست محصولات&nbsp;
                        <asp:HyperLink ID="ShopHyperLink" runat="server" Font-Bold="True" Target="_blank"></asp:HyperLink>
                    </td>
                </tr>
            </table>
            <br />
            <asp:Label ID="ErrorLabel" runat="server" Style="font-family: Tahoma; font-size: smaller;
                font-weight: bold; direction: rtl;" Visible="false">
                هيچ فروشگاهي انتخاب نشده است.
                
            </asp:Label>
        </center>
        <div class="signupTable">
            <asp:UpdatePanel ID="ManageShopProductUpdatePanel" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="ManageShopProductGridView" runat="server" DataSourceID="ManageShopProductSqlDataSource"
                        AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEDFDE"
                        Width="540px" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black"
                        GridLines="Vertical" AutoGenerateColumns="False" DataKeyNames="Product_ID,Shop_ID"
                        OnRowUpdated="ManageShopProductGridView_RowUpdated" OnRowUpdating="ManageShopProductGridView_RowUpdating"
                        OnRowDeleted="ManageShopProductGridView_RowDeleted" HeaderStyle-Font-Size="11px">
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="Product_ID" DataNavigateUrlFormatString="~/Page/Product/ShowProduct.aspx?ID={0}"
                                DataTextField="Name" DataTextFormatString="{0}" HeaderText="نام کالا" SortExpression="Name"
                                Target="_blank" />
                            <asp:TemplateField HeaderText="قيمت (ريال)" SortExpression="Price">
                                <ItemStyle Width="90px" />
                                <HeaderStyle Width="90px" />
                                <EditItemTemplate>
                                    <asp:TextBox ID="PriceTextBox" runat="server" Width="70px" Text='<%# Bind("Price") %>'></asp:TextBox>
                                    &nbsp;
                                    <asp:RequiredFieldValidator ID="PriceRequiredFieldValidator" runat="server" ErrorMessage="*"
                                        ControlToValidate="PriceTextBox" Font-Size="9px" ValidationGroup="ManageShopProductGridView"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="PriceRegularExpressionValidator" runat="server"
                                        ControlToValidate="PriceTextBox" Font-Size="9px" ValidationGroup="ManageShopProductGridView"
                                        ErrorMessage="قيمت نامعتبر" ValidationExpression="\d+(\.\d+)?" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="PriceLabel" runat="server" Text='<%# Decimal.Parse(Eval("Price").ToString()).ToString("#,#") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Warranty" HeaderText="ضمانتنامه" SortExpression="Warranty">
                                <ItemStyle Width="85px" />
                                <HeaderStyle Width="85px" />
                                <ControlStyle Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="WarrantyDuration" HeaderText="مدت ضمانتنامه" SortExpression="WarrantyDuration">
                                <ItemStyle Width="85px" />
                                <HeaderStyle Width="85px" />
                                <ControlStyle Width="80px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="توضيحات فروشنده" SortExpression="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>'
                                        Rows="3" TextMode="MultiLine" Width="100px" Font-Size="9px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:TextBox ID="ReadOnlyDescriptionTextBox" runat="server" Text='<%# Eval("Description").ToString().Trim() %>'
                                        TextMode="MultiLine" ReadOnly="true" Wrap="true" BorderStyle="None" BorderWidth="0"
                                        BackColor="#F7F7DE" Width="100px" Font-Size="9px" Rows="3"></asp:TextBox>
                                </ItemTemplate>
                                <AlternatingItemTemplate>
                                    <asp:TextBox ID="ReadOnlyDescriptionTextBox" runat="server" Text='<%# Eval("Description").ToString().Trim() %>'
                                        TextMode="MultiLine" ReadOnly="true" Wrap="true" BorderStyle="None" BorderWidth="0"
                                        BackColor="White" Width="100px" Font-Size="9px" Rows="3"></asp:TextBox>
                                </AlternatingItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowDeleteButton="True" ValidationGroup="ManageShopProductGridView"
                                ShowEditButton="True" DeleteText="حذف کالا" EditText="تغيير" UpdateText="بروز رساني"
                                CancelText="لغو" ButtonType="Button">
                                <ControlStyle Font-Bold="True" Font-Size="11px" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:CommandField>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <RowStyle BackColor="#F7F7DE" />
                        <EditRowStyle VerticalAlign="Top" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="ManageShopProductSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
                        DeleteCommand="DELETE FROM [Product_Shop] WHERE [Product_ID] = @Product_ID AND [Shop_ID] = @Shop_ID"
                        SelectCommand="SELECT Product.ID, Product.Name, Product_Shop.Product_ID, Product_Shop.Shop_ID, Product_Shop.Price, Product_Shop.Warranty, Product_Shop.WarrantyDuration, Product_Shop.Description FROM Product INNER JOIN Product_Shop ON Product.ID = Product_Shop.Product_ID WHERE ([Shop_ID] = @Shop_ID)"
                        UpdateCommand="UPDATE [Product_Shop] SET [Price] = @Price, [ModifiedDate] = @ModifiedDate, [Warranty] = @Warranty, [WarrantyDuration] = @WarrantyDuration, [Description] = @Description WHERE [Product_ID] = @Product_ID AND [Shop_ID] = @Shop_ID">
                        <DeleteParameters>
                            <asp:Parameter Name="Product_ID" Type="Int32" />
                            <asp:Parameter Name="Shop_ID" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Price" Type="Decimal" />
                            <asp:Parameter Name="ModifiedDate" Type="DateTime" />
                            <asp:Parameter Name="Warranty" Type="String" />
                            <asp:Parameter Name="WarrantyDuration" Type="String" />
                            <asp:Parameter Name="Description" Type="String" />
                            <asp:Parameter Name="Product_ID" Type="Int32" />
                            <asp:Parameter Name="Shop_ID" Type="Int32" />
                        </UpdateParameters>
                        <SelectParameters>
                            <asp:QueryStringParameter Name="Shop_ID" QueryStringField="ShopID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="ManageShopProductUpdateProgress" runat="server" AssociatedUpdatePanelID="ManageShopProductUpdatePanel">
                <ProgressTemplate>
                    <uc1:WaitPanel ID="ManageShopProductWaitPanel" runat="server" />
                </ProgressTemplate>
            </asp:UpdateProgress>
            <br />
            <br />
            <br />
            اقدام به
            <asp:HyperLink ID="CreateProductHyperLink" runat="server" Font-Bold="true" NavigateUrl='<%# "~/Page/Product/AddProduct.aspx?ShopID=" + Request.QueryString["ShopID"].Trim() %>'>ساخت</asp:HyperLink>
            يا <b>انتخاب</b> محصولات اين فروشگاه از طريق
            <asp:HyperLink ID="SelectProductByCategoryHyperLink" Font-Bold="true" runat="server"
                NavigateUrl='<%# "~/Page/Product/ShowAllCategories.aspx?adshid=" + Request.QueryString["ShopID"].Trim() %>'>شاخه ها</asp:HyperLink>
            و
            <asp:HyperLink ID="SelectProductBySearchHyperLink" runat="server" Font-Bold="true"
                NavigateUrl='<%# "~/Page/Product/SearchProduct.aspx?adshid=" + Request.QueryString["ShopID"].Trim() %>'>جستجو</asp:HyperLink>
        </div>
        &nbsp;
        <br />
    </div>
</asp:Content>

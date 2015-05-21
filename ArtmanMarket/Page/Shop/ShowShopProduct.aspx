<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ShowShopProduct.aspx.cs" Inherits="Page_Shop_ShowShopProduct" Title="نمايش محصولات فروشگاه"
    ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Src="~/WebControls/Common/WaitPanel.ascx" TagName="WaitPanel" TagPrefix="uc1" %>
<asp:Content ID="ShowShopProductContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            نمايش محصولات فروشگاه</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <center>
            <asp:Label ID="ErrorLabel" runat="server" Style="font-family: Tahoma; font-size: small;
                font-weight: bold; direction: rtl" Visible="false">
                هيچ فروشگاهي انتخاب نشده است.
            </asp:Label>
        </center>
        <div class="signupTable">
            <asp:UpdatePanel ID="ShowShopProductUpdatePanel" runat="server">
                <contenttemplate>
                <center>
                    <table>
                        <tr>
                            <td>
                                <asp:Image ID="ShopImage" runat="server" ImageUrl="~/Images/Shop/defaultShop.png" Width="40px"
                                    Height="40px" />
                            </td>
                            <td>
                                ليست محصولات&nbsp;
                                <asp:HyperLink ID="ShopHyperLink" runat="server" Font-Bold="True" Target="_blank"></asp:HyperLink>
                            </td>
                        </tr>
                    </table></center>
                    <br />
                
                    <asp:GridView ID="ShowShopProductGridView" runat="server" DataSourceID="ShowShopProductSqlDataSource"
                        AllowPaging="True" EnableViewState="false" AllowSorting="True" BackColor="White" Width="540px"
                        BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" AutoGenerateColumns="False"
                        DataKeyNames="Product_ID,Shop_ID">
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="Product_ID" DataNavigateUrlFormatString="~/Page/Product/ShowProduct.aspx?ID={0}"
                                DataTextField="Name" DataTextFormatString="{0}" HeaderText="نام کالا" SortExpression="Name"
                                Target="_blank" />
                            <asp:TemplateField HeaderText="قيمت (ريال)" SortExpression="Price">
                                <ItemTemplate>
                                    <asp:Label ID="PriceLabel" runat="server" Text='<%# Decimal.Parse(Eval("Price").ToString()).ToString("#,#") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="بروزرساني" SortExpression="ModifiedDate">
                                <ItemTemplate>
                                    <asp:Label ID="ModifiedDateLabel" runat="server" Text='<%# GetModifiedDuration(Eval("ModifiedDate")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Warranty" HeaderText="ضمانتنامه" SortExpression="Warranty">
                            </asp:BoundField>
                            <asp:BoundField DataField="WarrantyDuration" HeaderText="مدت ضمانتنامه" SortExpression="WarrantyDuration">
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="توضيحات فروشنده" SortExpression="Description">
                                <ItemTemplate>
                                    <asp:TextBox ID="ReadOnlyDescriptionTextBox" runat="server" Text='<%# Eval("Description").ToString().Trim() %>'
                                        Rows="3" TextMode="MultiLine" ReadOnly="true" Wrap="true" BorderStyle="None" Font-Size="9px"
                                        BorderWidth="0" BackColor="White"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <RowStyle BackColor="White" ForeColor="#003399" Font-Size="11px" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <HeaderStyle BackColor="#003399" HorizontalAlign="Center" Font-Size="11px" Font-Bold="True" ForeColor="#CCCCFF" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="ShowShopProductSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
                        SelectCommand="SELECT Product.ID, Product.Name, Product_Shop.Product_ID, Product_Shop.Shop_ID, Product_Shop.Price, Product_Shop.ModifiedDate, Product_Shop.Warranty, Product_Shop.WarrantyDuration, Product_Shop.Description FROM Product INNER JOIN Product_Shop ON Product.ID = Product_Shop.Product_ID WHERE ([Shop_ID] = @Shop_ID)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="Shop_ID" QueryStringField="ShopID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </contenttemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="ShowShopProductUpdateProgress" runat="server" AssociatedUpdatePanelID="ShowShopProductUpdatePanel">
                <progresstemplate>
                    <uc1:WaitPanel ID="ShowShopProductWaitPanel" runat="server" />
                </progresstemplate>
            </asp:UpdateProgress>
        </div>
        &nbsp;<br />
    </div>
</asp:Content>

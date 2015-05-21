<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ManageShop.aspx.cs" Inherits="Page_Shop_ManageShop" Title="مديريت فروشگاه ها"
    ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Src="~/WebControls/Common/WaitPanel.ascx" TagName="WaitPanel" TagPrefix="uc1" %>
<asp:Content ID="ManageShopContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            مديريت فروشگاه ها</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <div class="signupTable">
            <asp:UpdatePanel ID="ManageShopUpdatePanel" runat="server">
                <contenttemplate>
                    <center>
                        <strong>ليست تمام فروشگاه ها</strong>
                        <br />
                        <br />
                        <asp:GridView ID="ManageShopGridView" runat="server" DataSourceID="ManageShopSqlDataSource"
                            AllowPaging="True" EnableViewState="false" AllowSorting="True" BackColor="#DEBA84"
                            BorderColor="#DEBA84" BorderStyle="Dotted" BorderWidth="1px" CellPadding="3"
                            AutoGenerateColumns="False" DataKeyNames="ID" CellSpacing="2" Width="540px">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="LogoImage" runat="server" ImageUrl='<%# !String.IsNullOrEmpty(Eval("Logo").ToString().Trim()) ? Eval("Logo") : "~/Images/Shop/defaultShop.png" %>'
                                            Width="40px" Height="40px"></asp:Image>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="~/Page/Shop/Seller.aspx?ShopID={0}"
                                    DataTextField="Name" DataTextFormatString="{0}" HeaderText="نام فروشگاه" SortExpression="Name"
                                    Target="_blank" />
                                <asp:BoundField DataField="ResponsibleName" HeaderText="نام مسئول" SortExpression="ResponsibleName" />
                                <asp:BoundField DataField="Email" HeaderText="پست الکترونيکي" SortExpression="Email" />
                                <asp:BoundField DataField="Phone" HeaderText="تلفن" SortExpression="Phone" />
                                <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="~/Page/Shop/ManageShopProduct.aspx?ShopID={0}"
                                    Text="مشاهده و ويرايش محصولات" HeaderText="محصولات فروشگاه" Target="_blank" />
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        ويرايش فروشگاه
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:HyperLink ID="EditHyperLink" ToolTip="ويرايش" runat="server" Target="_blank"
                                            NavigateUrl='<%# "~/Page/Shop/Seller.aspx?ShopID=" + Eval("ID") %>'>
                                            <asp:Image ID="EditImage" runat="server" ImageUrl="~/Images/Product/edit.jpg" Width="24px"
                                                Height="24px" />
                                        </asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField DeleteImageUrl="~/Images/Product/remove.jpg" DeleteText="حذف" ShowDeleteButton="True"
                                    ButtonType="Image" HeaderText="حذف فروشگاه">
                                    <ControlStyle Height="24px" Width="24px" />
                                </asp:CommandField>
                            </Columns>
                            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        </asp:GridView>
                    </center>
                    <br />
                    <asp:HyperLink ID="AddShopHyperLink" runat="server" NavigateUrl="~/Page/Shop/Seller.aspx"
                        Target="_blank">ساخت يک فروشگاه جديد</asp:HyperLink>&nbsp;
                    <asp:SqlDataSource ID="ManageShopSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
                        SelectCommand="SELECT * FROM [Shop]" DeleteCommand="DELETE FROM [Shop] WHERE [ID] = @ID">
                        <DeleteParameters>
                            <asp:Parameter Name="ID" Type="Int32" />
                        </DeleteParameters>
                    </asp:SqlDataSource>
                </contenttemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="ManageShopUpdateProgress" runat="server" AssociatedUpdatePanelID="ManageShopUpdatePanel">
                <progresstemplate>
                    <uc1:WaitPanel ID="ManageShopWaitPanel" runat="server" />
                </progresstemplate>
            </asp:UpdateProgress>
        </div>
        <br />
        &nbsp;
        <br />
    </div>
</asp:Content>

<%@ Control Language="C#" AutoEventWireup="true" ClassName="ProductOverviewPanel"
    CodeFile="ProductOverviewPanel.ascx.cs" Inherits="WebControls_Product_ProductOverviewPanel" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Register Src="~/WebControls/Common/WaitPanel.ascx" TagName="WaitPanel" TagPrefix="wtp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<link href="~/StyleSheets/ControlStyles.css" rel="stylesheet" type="text/css" />
<link href="~/StyleSheets/AjaxControlStyles.css" rel="stylesheet" type="text/css" />

<script language="javascript" type="text/javascript">
    function CheckForSelectedProducts(CheckBoxIDs, type)
    {
        checked = false;
        for (var i = 0; i < CheckBoxIDs.length; i++)
        {
            var cb = document.getElementById(CheckBoxIDs[i]);
            if (cb != 'undefined' && cb != null && cb.checked)
            {
                checked = true;
                break;
            }
        }

        if (!checked)
        {
            if (type == "delete")
                alert('.هيچ محصولي براي حذف انتخاب نشده است');
            else
                alert('.هيچ محصولي براي اضافه کردن به فروشگاه انتخاب نشده است');
                
            return false;
        }
        else 
        {   
            if (type == "delete")
                return confirm('آيا واقعا مايل به حذف اين محصولات هستيد؟');
            else
                return true;
        }      
}      
</script>

<center>
    <asp:UpdatePanel ID="ProductUpdatePanel" runat="server">
        <ContentTemplate>
            <ajax:RoundedCornersExtender ID="ProductParentRoundedCornersExtender" runat="server"
                TargetControlID="ProductParentPanel" Radius="6" Corners="All" BorderColor="limegreen" />
            <asp:Panel ID="ProductParentPanel" runat="server" HorizontalAlign="Center" Direction="RightToLeft"
                Width="530">
                <asp:Panel ID="ProductHeaderPanel" runat="server" Style="padding-left: 10px; padding-right: 5px">
                    <div style="text-align: right; float: right; direction: rtl;">
                        <table>
                            <tr>
                                <td rowspan="2">
                                    <asp:Image ID="TitleImage" runat="server" ImageUrl='<%# TitleLogoUrl %>' Width="40px"
                                        Height="40px" />
                                </td>
                                <td>
                                    <asp:Label ID="TitleLabel" runat="server" CssClass="productPanelTitle" Text='<%# TitleText %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="ProductCountLabel" runat="server" Visible='<%# ProductCountLabelVisible %>'
                                        CssClass="productPanelTitle">(<%# ProductPager.RecordCount %> مورد)</asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />
                    <asp:Panel ID="NumOfItemsPanel" runat="server" Style="text-align: left; float: left;
                        direction: rtl;">
                        <asp:Label ID="NumOfItemsLabel" runat="server" Style="color: #ff6600; font-family: Tahoma;
                            font-size: 12pt" Text="نمايش"></asp:Label>
                        <asp:DropDownList ID="NumOfItemsDropDownList" runat="server" ToolTip="تعداد محصولات در هر صفحه"
                            SelectedValue='<%# NumOfItemsPerPage %>' AutoPostBack="true" OnSelectedIndexChanged="NumOfItemsDropDownList_SelectedIndexChanged">
                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                            <asp:ListItem Text="6" Value="6"></asp:ListItem>
                            <asp:ListItem Text="9" Value="9"></asp:ListItem>
                            <asp:ListItem Text="12" Value="12"></asp:ListItem>
                            <asp:ListItem Text="15" Value="15"></asp:ListItem>
                            <asp:ListItem Text="18" Value="18"></asp:ListItem>
                        </asp:DropDownList>
                    </asp:Panel>
                    <br />
                    <br />
                </asp:Panel>
                <asp:DataList ID="ProductDataList" runat="server" CellSpacing="10" RepeatColumns="3"
                    RepeatDirection="Horizontal" HorizontalAlign="Center" DataKeyField="ID">
                    <ItemTemplate>
                        <center>
                            <asp:Panel ID="ProductPanel" runat="server" BorderStyle="Dashed" Direction="RightToLeft"
                                Height='<%# IsAdministrator() ? (IsShopValid ? 467 : 302) : 257 %>' HorizontalAlign="right"
                                Width="160px" BorderColor="DeepSkyBlue" BorderWidth="1px" Font-Names="Tahoma"
                                Font-Size="smaller" Style="display: block;">
                                <div style="height: 25px; width: 80px; text-align: left; float: left; margin-top: 4px;
                                    padding-left: 5px; vertical-align: middle; display: table-cell">
                                    <asp:Image ID="ProductBrandImage" runat="server" Style="max-height: 25px" ImageUrl='<%# GetTrimmedImageUrl(Eval("BrandImageUrl"), "brand") %>' />
                                </div>
                                <br />
                                <br />
                                <center>
                                    <table>
                                        <tr>
                                            <td style="height: 70px; width: 90px; text-align: center">
                                                <asp:HyperLink ID="ProductHyperLink1" runat="server" NavigateUrl='<%# ResolveUrl("~/Page/Product/ShowProduct.aspx") + "?ID=" + Eval("ID") + (IsAdministrator() ? "&ReturnUrl=" + Request.Url.PathAndQuery : "") %>'
                                                    Target='<%# IsAdministrator() ? "_self" : "_blank" %>'>
                                                    <asp:Image ID="ProductLogoImage" runat="server" Style="max-height: 70px; vertical-align: middle"
                                                        ImageUrl='<%# GetTrimmedImageUrl(Eval("LogoImageUrl"), "logo") %>' ImageAlign="Middle"
                                                        ToolTip='<%# Eval("Name").ToString().Trim() %>'></asp:Image>
                                                </asp:HyperLink>
                                            </td>
                                        </tr>
                                    </table>
                                    <div style="height: 1em">
                                        <asp:Image ID="NewIconImage" runat="server" ImageUrl="~/Images/Product/new.gif" ImageAlign="Left"
                                            Style="margin-left: 7px" Visible='<%# ShouldDisplayNewIcon(Eval("CreatedDate")) %>' />
                                    </div>
                                    <div class="productName">
                                        <asp:HyperLink ID="ProductHyperLink2" runat="server" Text='<%# Eval("Name").ToString().Trim() %>'
                                            NavigateUrl='<%# ResolveUrl("~/Page/Product/ShowProduct.aspx") + "?ID=" + Eval("ID") + (IsAdministrator() ? "&ReturnUrl=" + Request.Url.PathAndQuery : "") %>'
                                            Target='<%# IsAdministrator() ? "_self" : "_blank" %>'>    
                                        </asp:HyperLink>
                                        <br />
                                    </div>
                                    <div class="productPriceLabel">
                                        <asp:HyperLink ID="ProductHyperLink3" ForeColor="black" runat="server" Text="قيمت فروشندگان"
                                            NavigateUrl='<%# ResolveUrl("~/Page/Product/ShowProduct.aspx") + "?ID=" + Eval("ID") + (IsAdministrator() ? "&ReturnUrl=" + Request.Url.PathAndQuery : "") %>'
                                            Target='<%# IsAdministrator() ? "_self" : "_blank" %>'>    
                                        </asp:HyperLink>
                                    </div>
                                </center>
                                &nbsp;&nbsp;<asp:Label ID="MinPriceLabel" runat="server" Text="کمينه"></asp:Label>
                                &nbsp;<asp:Label ID="ProductMinPriceLabel" runat="server" Text='' CssClass="productMinPrice"><%# Eval("MinPrice").ToString() != "0" ? Decimal.Parse(Eval("MinPrice").ToString()).ToString("#,#") + " ريال" : "هنوز قيمت ندارد"%></asp:Label><br />
                                &nbsp;&nbsp;<asp:Label ID="MaxPriceLabel" runat="server" Text="بيشينه"></asp:Label>
                                &nbsp;<asp:Label ID="ProductMaxPriceLabel" runat="server" CssClass="productMaxPrice"><%# Eval("MaxPrice").ToString() != "0" ? Decimal.Parse(Eval("MaxPrice").ToString()).ToString("#,#") + " ريال" : "هنوز قيمت ندارد"%></asp:Label><br />
                                <br />
                                &nbsp;&nbsp;<asp:Label ID="ModifiedLabel" runat="server" Text="بروزرساني"></asp:Label>
                                &nbsp;<asp:Label ID="ProductModifiedLabel" runat="server" Font-Size="11px" ForeColor="dimgray"><%# GetModifiedDuration(Eval("ModifiedDate")) %></asp:Label><br />
                                &nbsp;&nbsp;<asp:Label ID="RatingLabel" runat="server" Text="امتياز" Style="margin-right: 8px;
                                    float: right"></asp:Label>
                                <ajax:Rating ID="ProductRatingControl" runat="server" ReadOnly="True" EmptyStarCssClass="emptyRatingStar"
                                    FilledStarCssClass="filledRatingStar" StarCssClass="ratingStar" WaitingStarCssClass="savedRatingStar"
                                    CurrentRating='<%# Eval("Rate") %>' Style="margin-right: 12px; float: right;
                                    margin-top: 5px" RatingDirection="RightToLeftBottomToTop" HorizontalAlign="Right">
                                </ajax:Rating>
                                <asp:Panel ID="ProductControlPanel" runat="server" Visible='<%# IsAdministrator() %>'>
                                    <br />
                                    <table style="text-align: left; float: left;">
                                        <tr>
                                            <td>
                                                <table style="text-align: left; float: left;">
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="DeleteCheckBox" runat="server" ToolTip="انتخاب براي حذف يا اضافه کردن به فروشگاه"
                                                                value='<%# Eval("ID") %>' OnLoad="DeleteCheckBox_Load" />
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ID="DeleteImageButton" runat="server" ImageUrl="~/Images/Product/remove.jpg"
                                                                Width="24px" Height="24px" ImageAlign="Left" CommandArgument='<%# Eval("ID") %>'
                                                                OnClientClick="javascript: return confirm('آيا واقعا مايل به حذف اين محصول هستيد؟');"
                                                                OnClick="DeleteImageButton_Click" ToolTip="حذف اين محصول" Style="border-color: Yellow;
                                                                border-width: 1px; border-style: outset" ValidationGroup="ProductOverviewPanel"
                                                                CausesValidation="false" />
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ID="AddToShopImageButton" runat="server" ImageUrl="~/Images/Product/add.png"
                                                                Width="24px" Height="24px" ImageAlign="Left" Visible='<%# IsShopValid %>' CommandArgument='<%# Eval("ID") %>'
                                                                OnClick="AddToShopImageButton_Click" ToolTip="اضافه کردن اين محصول به فروشگاه"
                                                                Style="border-color: Yellow; border-width: 1px; border-style: outset" CausesValidation="true"
                                                                OnDataBinding="AddToShopImageButton_DataBinding" ValidationGroup="ProductOverviewPanel" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Panel ID="ShopDetailPanel" runat="server" Visible='<%# IsAdministrator() && IsShopValid %>'>
                                                    <table class="signupTable">
                                                        <tr>
                                                            <td colspan="2" align="center">
                                                                <div style="height: 2em">
                                                                    <asp:HyperLink ID="ShopNameLabel" runat="server" Font-Size="x-small" Target="_blank"
                                                                        Font-Bold="true" ForeColor="darkgoldenrod" NavigateUrl='<%# "~/Page/Shop/Seller.aspx?ShopID=" + Request.QueryString["adshid"] %>'>فروشگاه <%# ShopName %></asp:HyperLink>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="PriceLabel" runat="server" AssociatedControlID="PriceTextBox" Font-Size="Small"
                                                                    Text="قيمت (ريال) *"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="PriceTextBox" runat="server" Width="85px" Text="0" Style="direction: ltr"></asp:TextBox>
                                                                &nbsp;
                                                                <asp:RequiredFieldValidator ID="PriceRequiredFieldValidator" runat="server" ErrorMessage="*"
                                                                    ControlToValidate="PriceTextBox" SetFocusOnError="True" ValidationGroup="ProductOverviewPanel"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="PriceRegularExpressionValidator" runat="server"
                                                                    ControlToValidate="PriceTextBox" ErrorMessage="قيمت نامعتبر" ValidationExpression="\d+(\.\d+)?"
                                                                    SetFocusOnError="True" ValidationGroup="ProductOverviewPanel"></asp:RegularExpressionValidator>
                                                            </td>
                                                        </tr>
                                                <td>
                                                    <asp:Label ID="WarrantyLabel" runat="server" AssociatedControlID="WarrantyTextBox"
                                                        Font-Size="Small" Text="ضمانتنامه"></asp:Label>
                                                </td>
                                            <td>
                                                <asp:TextBox ID="WarrantyTextBox" MaxLength="100" runat="server" Width="85px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="WarrantyDurationLabel" runat="server" AssociatedControlID="WarrantyDurationTextBox"
                                                    Font-Size="Small" Text="مدت ضمانتنامه"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="WarrantyDurationTextBox" MaxLength="50" runat="server" Width="85px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="VendorDescriptionLabel" runat="server" AssociatedControlID="VendorDescriptionTextBox"
                                                    Font-Size="Small" Text="توضيحات فروشنده"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="VendorDescriptionTextBox" MaxLength="500" Font-Size="9px" runat="server"
                                                    Width="85px" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                </td> </tr> </table>
                            </asp:Panel>
                            </asp:Panel>
                        </center>
                    </ItemTemplate>
                    <FooterTemplate>
                        <center>
                            <asp:Panel ID="ProductFooterPanel" runat="server" Visible='<%# ShouldDisplayDeleteOrAddAllButton() %>'
                                HorizontalAlign="Center">
                                <asp:Button ID="DeleteAllButton" runat="server" Text="حذف تمام محصولات انتخاب شده"
                                    Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt" ForeColor="#3300ff" Height="27px"
                                    Width="194px" OnClientClick='<%# GetClientDeleteOrAddFunction("delete") %>' OnClick="DeleteAllButton_Click"
                                    CausesValidation="false" ValidationGroup="ProductOverviewPanel" />
                                <br />
                                <asp:Button ID="AddAllToShopButton" runat="server" Text="اضافه کردن تمام محصولات انتخاب شده به فروشگاه"
                                    Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt" ForeColor="#3300ff" Height="27px"
                                    Width="300px" Visible='<%# IsShopValid %>' OnClientClick='<%# GetClientDeleteOrAddFunction("add") %>'
                                    OnClick="AddAllToShopButton_Click" ValidationGroup="ProductOverviewPanel" CausesValidation="true" />
                            </asp:Panel>
                        </center>
                    </FooterTemplate>
                </asp:DataList>
                <center>
                    <webdiyer:AspNetPager ID="ProductPager" runat="server" HorizontalAlign="center" FirstPageText=" اول "
                        LastPageText="آخر " PrevPageText="قبلي " NextPageText="بعدي " ShowBoxThreshold="11"
                        NumericButtonCount="10" SubmitButtonText="برو به صفحه" NavigationButtonsPosition="Right"
                        PrevNextButtonsClass="" TextBeforePageIndexBox="برو به صفحه " TextAfterPageIndexBox="  "
                        PageIndexBoxType="DropDownList" SubmitButtonClass="pagerGoButton" OnPageChanging="ProductPager_PageChanging"
                        Font-Size="Smaller" CurrentPageButtonStyle="color:balck; font-weight: bold" />
                </center>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</center>
<asp:UpdateProgress ID="ProductUpdateProgress" runat="server" AssociatedUpdatePanelID="ProductUpdatePanel">
    <ProgressTemplate>
        <wtp:WaitPanel ID="ProductWaitPanel" runat="server" />
    </ProgressTemplate>
</asp:UpdateProgress>

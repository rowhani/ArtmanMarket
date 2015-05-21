<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ShowProduct.aspx.cs" Inherits="Page_Product_ShowProduct" Title="نمايش محصول"
    ErrorPage="~/Page/Errors/Error500.htm" MaintainScrollPositionOnPostback="true" %>

<%@ Register Src="~/WebControls/Common/ImageBrowser.ascx" TagName="ImageBrowser"
    TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register Assembly="Winthusiasm.HtmlEditor" Namespace="Winthusiasm.HtmlEditor"
    TagPrefix="rte" %>
<asp:Content ID="MasterHeadContent" ContentPlaceHolderID="HeadContentPlaceHolder"
    runat="Server">
    <link href='<%= Page.ResolveUrl("~/StyleSheets/AjaxControlStyles.css")%>' rel="stylesheet"
        type="text/css" />
</asp:Content>
<asp:Content ID="ShowProductContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            <asp:Label ID="CaptionLabel" runat="server" Text="نمايش محصول"></asp:Label></h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <asp:Panel ID="ErrorPanel" runat="server" Visible="false" Style="text-align: center;
            direction: rtl; font-family: Tahoma; font-size: small">
            <br />
            <asp:Label ID="ErrorLabel" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
        </asp:Panel>
        <asp:MultiView ID="UpdateProductMultiView" runat="server" ActiveViewIndex="0">
            <asp:View ID="UpdatePanelView" runat="server">
                <asp:SqlDataSource ID="ShowProductSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
                    DeleteCommand="DELETE FROM [Product] WHERE [ID] = @ID" UpdateCommand="UPDATE [Product] SET [Name] = @Name, [LogoImageUrl] = @LogoImageUrl, [BrandImageUrl] = @BrandImageUrl, [ImagesUrl] = @ImagesUrl, [ModifiedDate] = @ModifiedDate, [MinPrice] = @MinPrice, [MaxPrice] = @MaxPrice, [Overview] = @Overview, [Details] = @Details, [Tags] = @Tags, [Rate] = @Rate, [Category_ID] = @Category_ID WHERE [ID] = @ID"
                    SelectCommand="SELECT Product.ID, Product.Name, Product.LogoImageUrl, Product.BrandImageUrl, Product.ImagesUrl, Product.ModifiedDate, Product.MinPrice, Product.MaxPrice, Product.Overview, Product.Details, Product.Tags, Product.Rate, Product.Hits, Product.Category_ID, Product.CreatedDate, Category.Title, Category.URL FROM Product INNER JOIN Category ON Product.Category_ID=Category.ID WHERE (Product.ID = @ID)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SiteMapDataSource ID="CategorySiteMapDataSource" runat="server" />
                <asp:TreeView ID="CategoryTreeView" runat="server" DataSourceID="CategorySiteMapDataSource"
                    Visible="false">
                    <DataBindings>
                        <asp:TreeNodeBinding TextField="Title" ValueField="Key" />
                    </DataBindings>
                </asp:TreeView>
                <asp:FormView ID="ShowProductFormView" runat="server" DataKeyNames="ID" DataSourceID="ShowProductSqlDataSource"
                    Width="535px" CssClass="signupTable" OnItemUpdating="ShowProductFormView_ItemUpdating"
                    EnableViewState="false" HorizontalAlign="Center">
                    <ItemTemplate>
                        <center>
                            <asp:Panel runat="server" ID="ShowProductItemPanel" Width="500px" DefaultButton="PlayButton"
                                HorizontalAlign="center">
                                <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title").ToString().Trim() + " - " + Eval("Name").ToString().Trim() %>'
                                    Width="500px" Height="30px" Style="background-color: #336699; color: White; font-family: Tahoma;
                                    font-size: 11pt; font-weight: bold; text-align: center; direction: rtl; vertical-align: middle;
                                    display: table-cell"></asp:Label>
                                <div style="height: 25px; width: 80px; text-align: left; float: left">
                                    <asp:Image ID="BrandImage" runat="server" Style="max-height: 25px" ImageAlign="Left"
                                        ToolTip='<%# Eval("Name").ToString().Trim() %>' ImageUrl='<%# Eval("BrandImageUrl").ToString().Trim() != ""? Eval("BrandImageUrl").ToString().Trim(): "~/Images/Product/nobrand.gif" %>' />
                                </div>
                                <br />
                                <br />
                                <center>
                                    <ajax:SlideShowExtender ID="ProductSlideShowExtender" runat="server" SlideShowServiceMethod="GetSlides"
                                        TargetControlID="ProductImages" ImageDescriptionLabelID="DescriptionLabel" NextButtonID="NextButton"
                                        PlayButtonID="PlayButton" PreviousButtonID="PreviousButton" PlayButtonText="پخش اسلايد"
                                        StopButtonText="توقف اسلايد" Loop="true" AutoPlay="false" ImageTitleLabelID="DescriptionLabel"
                                        UseContextKey="true" ContextKey='<%# Request.QueryString["ID"] %>'>
                                    </ajax:SlideShowExtender>
                                    <br />
                                    <table style="height: 265px">
                                        <tr>
                                            <td>
                                                <asp:Image ID="ProductImages" runat="server" Style="max-height: 260px; vertical-align: middle"
                                                    ImageUrl='<%# Eval("LogoImageUrl").ToString().Trim() != "" ? Eval("LogoImageUrl").ToString().Trim() : "~/Images/Product/nologo.gif" %>' />
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <asp:Label ID="DescriptionLabel" runat="server" Font-Bold="True" Text='<%# Eval("LogoImageUrl").ToString().Trim() != "" ? "لوگوي کالا" : ""%>'></asp:Label>
                                    <br />
                                    <br />
                                    <asp:Button ID="PreviousButton" runat="server" BackColor="#0099FF" Font-Bold="True"
                                        Font-Names="Tahoma" Font-Size="10pt" ForeColor="Gold" Height="30px" Text="تصوير قبلي"
                                        Width="90px" BorderStyle="Outset" Style="cursor: poniter; cursor: hand" Enabled='<%# Eval("ImagesUrl").ToString().Trim() != "" && Eval("ImagesUrl").ToString().IndexOf("|") != -1 %>' />&nbsp;
                                    <asp:Button ID="PlayButton" runat="server" BackColor="#0099FF" Font-Bold="True" Font-Names="Tahoma"
                                        Font-Size="10pt" ForeColor="Gold" Height="30px" Text="پخش اسلايد" Width="90px"
                                        Enabled='<%# Eval("ImagesUrl").ToString().Trim() != "" && Eval("ImagesUrl").ToString().IndexOf("|") != -1 %>'
                                        BorderStyle="Outset" Style="cursor: poniter; cursor: hand" />&nbsp;
                                    <asp:Button ID="NextButton" runat="server" BackColor="#0099FF" Font-Bold="True" Font-Names="Tahoma"
                                        Font-Size="10pt" ForeColor="Gold" Height="30px" Text="تصوير بعدي" Width="90px"
                                        Enabled='<%# Eval("ImagesUrl").ToString().Trim() != "" && Eval("ImagesUrl").ToString().IndexOf("|") != -1 %>'
                                        BorderStyle="Outset" Style="cursor: poniter; cursor: hand" />
                                    <br />
                                    <br />
                                    <br />
                                    <div class="signupTable" style="font-weight: bold; color: Gray">
                                        تاريخ بروز رساني:&nbsp;&nbsp;<asp:Label Style="color: Teal" ID="ModifiedDateLabel"
                                            runat="server"><%# GetPersianDate(Eval("ModifiedDate"))%></asp:Label>
                                        <br />
                                        <br />
                                        <asp:Label ID="RatingLabel" runat="server" Text="امتياز:" Style="margin-right: 2px;
                                            float: right"></asp:Label>
                                        &nbsp;&nbsp;<ajax:Rating ID="ProductRatingControl" runat="server" EmptyStarCssClass="emptyRatingStar"
                                            ReadOnly="true" FilledStarCssClass="filledRatingStar" StarCssClass="ratingStar"
                                            WaitingStarCssClass="savedRatingStar" CurrentRating='<%# Eval("Rate") %>' Style="margin-right: 8px;
                                            float: right; margin-top: 5px" RatingDirection="RightToLeftBottomToTop" HorizontalAlign="Right">
                                        </ajax:Rating>
                                        <br />
                                        <br />
                                        تعداد بازديدها: &nbsp;&nbsp;<asp:Label Style="color: Maroon" ID="HitsLabel" runat="server"
                                            Text='<%# Eval("Hits") %>'></asp:Label>
                                    </div>
                                    <br />
                                    <br />
                                    <div class="signupTable">
                                        <b>برچسب ها :&nbsp;&nbsp; </b><span style="font-size: 11px">
                                            <asp:Literal ID="TagsHLinkLiteral" runat="server" Text='<%# GetHLinksForTags(Eval("Tags"))%>'></asp:Literal>
                                        </span>
                                    </div>
                                    <br />
                                    <div class="signupTable">
                                        <ajax:TabContainer ID="SpecTabContainer" runat="server" ActiveTabIndex="0" Width="500px">
                                            <ajax:TabPanel ID="PriceTabPanel" runat="server" HeaderText="قيمت فروشندگان">
                                                <ContentTemplate>
                                                    <center>
                                                        کمينه:&nbsp;&nbsp;<asp:Label ID="MinPriceLabel" runat="server" CssClass="productMinPrice"><%# Eval("MinPrice").ToString() != "0" ? Decimal.Parse(Eval("MinPrice").ToString()).ToString("#,#") + " ريال" : "هنوز قيمت ندارد"%></asp:Label>
                                                        &nbsp;&nbsp;&nbsp;&nbsp; بيشينه:&nbsp;&nbsp;<asp:Label ID="MaxPriceLabel" runat="server"
                                                            CssClass="productMaxPrice"><%# Eval("MaxPrice").ToString() != "0" ? Decimal.Parse(Eval("MaxPrice").ToString()).ToString("#,#") + " ريال" : "هنوز قيمت ندارد"%></asp:Label>
                                                    </center>
                                                    <br />
                                                    <div style="font-size: x-small">
                                                        بازديدکننده گرامي براي مشاهده مشخصات فروشندگان (تلفن،آدرس،...) لطفاً روي نام آنها
                                                        کليک فرماييد.
                                                    </div>
                                                    <br />
                                                    <asp:UpdatePanel ID="ShowProductShopUpdatePanel" runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ID="ShowProductShopGridView" runat="server" DataSourceID="ShowProductShopSqlDataSource"
                                                                AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#CCCCCC"
                                                                BorderStyle="Solid" BorderWidth="1px" CellPadding="3" AutoGenerateColumns="False"
                                                                DataKeyNames="Product_ID,Shop_ID" Font-Size="X-Small" Width="483px" EnableViewState="False">
                                                                <Columns>
                                                                    <asp:HyperLinkField DataNavigateUrlFields="Shop_ID" DataNavigateUrlFormatString="~/Page/Shop/Seller.aspx?ShopID={0}"
                                                                        DataTextField="Name" DataTextFormatString="{0}" HeaderText="فروشنده" SortExpression="Name"
                                                                        Target="_blank" />
                                                                    <asp:TemplateField HeaderText="قيمت (ريال)" SortExpression="Price">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="PriceLabel" runat="server" Text='<%# Decimal.Parse(Eval("Price").ToString()).ToString("#,#") %>'
                                                                                Width="70px"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="بروزرساني" SortExpression="ModifiedDate">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="ModifiedDateLabel" runat="server" Width="70px" Text='<%# GetModifiedDuration(Eval("ModifiedDate")) %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="Warranty" HeaderText="ضمانت" SortExpression="Warranty">
                                                                        <ItemStyle Width="70px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="WarrantyDuration" HeaderText="مدت ضمانت" SortExpression="WarrantyDuration">
                                                                        <ItemStyle Width="70px" />
                                                                    </asp:BoundField>
                                                                    <asp:TemplateField HeaderText="توضيحات فروشنده" SortExpression="Description">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Eval("Description").ToString().Trim() %>'
                                                                                Rows="3" TextMode="MultiLine" ReadOnly="true" Wrap="true" BorderStyle="None"
                                                                                Width="100px" BorderWidth="0" BackColor="White" Font-Size="X-Small"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <EmptyDataTemplate>
                                                                    <center>
                                                                        هيچ فروشگاهي برای این کالا وجود ندارد.
                                                                    </center>
                                                                </EmptyDataTemplate>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <RowStyle ForeColor="black" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                                            </asp:GridView>
                                                            <asp:SqlDataSource ID="ShowProductShopSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
                                                                SelectCommand="SELECT Shop.ID, Shop.Name, Product_Shop.Product_ID, Product_Shop.Shop_ID, Product_Shop.Price, Product_Shop.ModifiedDate, Product_Shop.Warranty, Product_Shop.WarrantyDuration, Product_Shop.Description FROM Shop INNER JOIN Product_Shop ON Shop.ID = Product_Shop.Shop_ID WHERE ([Product_ID] = @ID)">
                                                                <SelectParameters>
                                                                    <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    <br />
                                                    <asp:UpdateProgress ID="ShowProductShopUpdateProgress" runat="server" AssociatedUpdatePanelID="ShowProductShopUpdatePanel">
                                                        <ProgressTemplate>
                                                            <div class="signupTable">
                                                                <h2>
                                                                    <b>در حال اجرا...</b></h2>
                                                            </div>
                                                            <br />
                                                        </ProgressTemplate>
                                                    </asp:UpdateProgress>
                                                </ContentTemplate>
                                            </ajax:TabPanel>
                                            <ajax:TabPanel ID="OverviewTabPanel" runat="server" HeaderText="مشخصات کلي" Width="483px"
                                                Visible='<%# Eval("Overview").ToString().Trim() != "توضيحات:" %>'>
                                                <ContentTemplate>
                                                    <asp:Label ID="OverviewLabel" runat="server" Font-Size="11px" Text='<%# Eval("Overview").ToString().Trim().Replace("\n", " <br />") %>'
                                                        Width="483px"></asp:Label>
                                                    <br />
                                                    <br />
                                                </ContentTemplate>
                                            </ajax:TabPanel>
                                            <ajax:TabPanel ID="DetailsTabPanel" runat="server" HeaderText="جزئيات" Width="483px"
                                                Visible='<%# Eval("Details").ToString().Trim() != "" %>'>
                                                <ContentTemplate>
                                                    <asp:Literal ID="DetailsLiteral" runat="server" Text='<%# Eval("Details").ToString().Trim() %>'></asp:Literal>
                                                    <br />
                                                </ContentTemplate>
                                            </ajax:TabPanel>
                                            <ajax:TabPanel ID="RatingTabPanel" runat="server" HeaderText="نظرات و امتيازدهي">
                                                <ContentTemplate>
                                                    <div class="signupTable">
                                                        <asp:Label ID="CommentCaptionLabel" runat="server" Style="color: CaptionText; font-family: Tahoma;
                                                            font-weight: bold" Text='<%# "نظرات " + Eval("Title") + " - " + Eval("Name") %>'></asp:Label>
                                                        <br />
                                                        <br />
                                                        <asp:UpdatePanel ID="CommentUpdatePanel" runat="server">
                                                            <ContentTemplate>
                                                                <asp:FormView ID="CommentFormView" runat="server" DefaultMode='<%# GetCommentFormMode() %>'
                                                                    DataSourceID="UserCommentSqlDataSource" OnItemInserted="CommentFormView_ItemInserted"
                                                                    OnItemUpdated="CommentFormView_ItemUpdated">
                                                                    <EmptyDataTemplate>
                                                                        لطفاً براي درج نظر در صورتي که عضو هستيد با استفاده از بخش ورود به سيستم در ستون
                                                                        سمت چپ وارد سايت شويد، در غير اين صورت
                                                                        <asp:HyperLink ID="SignupHyperLink" runat="server" NavigateUrl="~/Page/User/Signup.aspx">عضو</asp:HyperLink>
                                                                        شويد.
                                                                        <br />
                                                                        <br />
                                                                    </EmptyDataTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:Label ID="CommentLabel" runat="server" Text="نظر:" Style="margin-right: 2px;
                                                                            float: right"></asp:Label>&nbsp;&nbsp;
                                                                        <asp:TextBox ID="CommentTextBox" MaxLength="500" Text='<%# Bind("Comment") %>' runat="server"
                                                                            Width="400px" TextMode="MultiLine" Height="60px"></asp:TextBox>
                                                                        <br />
                                                                        <br />
                                                                        <asp:Label ID="RateLabel" runat="server" Text="امتياز:" Style="margin-right: 2px;
                                                                            float: right"></asp:Label>&nbsp;&nbsp;
                                                                        <asp:DropDownList ID="RatingDropDownList" runat="server" SelectedValue='<%# Bind("Rate") %>'>
                                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <br />
                                                                        <br />
                                                                        <asp:UpdateProgress ID="CommentUpdateProgress" runat="server" AssociatedUpdatePanelID="CommentUpdatePanel">
                                                                            <ProgressTemplate>
                                                                                <div class="signupTable">
                                                                                    <h2>
                                                                                        <b>در حال اجرا...</b></h2>
                                                                                </div>
                                                                                <br />
                                                                            </ProgressTemplate>
                                                                        </asp:UpdateProgress>
                                                                        <br />
                                                                        <asp:Button ID="SendCommentButton" runat="server" Text="بروز رساني" CommandName="Update" />
                                                                        <br />
                                                                    </EditItemTemplate>
                                                                    <InsertItemTemplate>
                                                                        <asp:Label ID="CommentLabel" runat="server" Text="نظر:" Style="margin-right: 2px;
                                                                            float: right"></asp:Label>&nbsp;&nbsp;
                                                                        <asp:TextBox ID="CommentTextBox" MaxLength="500" Text='<%# Bind("Comment") %>' runat="server"
                                                                            Width="400px" TextMode="MultiLine" Height="60px"></asp:TextBox>
                                                                        <br />
                                                                        <br />
                                                                        <asp:Label ID="RateLabel" runat="server" Text="امتياز:" Style="margin-right: 2px;
                                                                            float: right"></asp:Label>&nbsp;&nbsp;
                                                                        <asp:DropDownList ID="RatingDropDownList" runat="server" SelectedValue='<%# Bind("Rate") %>'>
                                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <br />
                                                                        <br />
                                                                        <asp:UpdateProgress ID="CommentUpdateProgress" runat="server" AssociatedUpdatePanelID="CommentUpdatePanel">
                                                                            <ProgressTemplate>
                                                                                <div class="signupTable">
                                                                                    <h2>
                                                                                        <b>در حال اجرا...</b></h2>
                                                                                </div>
                                                                                <br />
                                                                            </ProgressTemplate>
                                                                        </asp:UpdateProgress>
                                                                        <br />
                                                                        <asp:Button ID="SendCommentButton" runat="server" Text="ارسال" CommandName="Insert" />
                                                                        <br />
                                                                    </InsertItemTemplate>
                                                                </asp:FormView>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                        <asp:SqlDataSource ID="UserCommentSqlDataSource" runat="server" SelectCommand="SELECT Product_Account.Product_ID, Product_Account.Username, Product_Account.Comment, Product_Account.Rate FROM Product_Account INNER JOIN Product ON Product.ID = Product_Account.Product_ID INNER JOIN Account ON Account.Username = Product_Account.Username WHERE (Account.Username = @Username) AND (Product.ID = @ID)"
                                                            UpdateCommand="InsertOrUpdateProductComment" UpdateCommandType="StoredProcedure"
                                                            InsertCommand="InsertOrUpdateProductComment" InsertCommandType="StoredProcedure"
                                                            ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>">
                                                            <SelectParameters>
                                                                <asp:SessionParameter SessionField="AUTH_USER" Name="Username"></asp:SessionParameter>
                                                                <asp:QueryStringParameter Name="ID" QueryStringField="ID"></asp:QueryStringParameter>
                                                            </SelectParameters>
                                                            <UpdateParameters>
                                                                <asp:SessionParameter SessionField="AUTH_USER" Name="Username"></asp:SessionParameter>
                                                                <asp:QueryStringParameter Name="ID" QueryStringField="ID"></asp:QueryStringParameter>
                                                            </UpdateParameters>
                                                            <InsertParameters>
                                                                <asp:SessionParameter SessionField="AUTH_USER" Name="Username"></asp:SessionParameter>
                                                                <asp:QueryStringParameter Name="ID" QueryStringField="ID"></asp:QueryStringParameter>
                                                            </InsertParameters>
                                                        </asp:SqlDataSource>
                                                    </div>
                                                </ContentTemplate>
                                            </ajax:TabPanel>
                                        </ajax:TabContainer>
                                    </div>
                                </center>
                            </asp:Panel>
                        </center>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Panel ID="ShowProductEditItemPanel" runat="server" DefaultButton="UpdateProductButton_Top"
                            HorizontalAlign="Center">
                            <table class="signupTable" cellspacing="3px">
                                <tr>
                                    <td colspan="3">
                                        <asp:Button ID="UpdateProductButton_Top" runat="server" CommandName="Update" Text="تغيير مشخصات"
                                            OnClick="UpdateProductButton_Click" ValidationGroup="UpdateProduct" />
                                        &nbsp;
                                        <asp:Button ID="DeleteProductButton_Top" runat="server" CommandName="Delete" Text="حذف محصول"
                                            OnClick="DeleteProductButton_Click" ValidationGroup="UpdateProduct" PostBackUrl="#"
                                            CausesValidation="False" OnClientClick="javascript:return confirm('آيا واقعا مايل به حذف اين محصول هستيد؟');" />
                                        &nbsp;
                                        <asp:Button ID="CancelButton_Top" runat="server" UseSubmitBehavior="false" CommandName="Cancel"
                                            Text="انصراف" CausesValidation="False" ValidationGroup="UpdateProduct" OnClick="CancelBackButton_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;</td>
                                    <td style="font-size: 13px; font-style: italic;">
                                        &nbsp;&nbsp;&nbsp;مشخصات اصلي</td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProductNameLabel" runat="server" AssociatedControlID="ProductNameTextBox"
                                            Font-Size="Small" Text="نام کالا *"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="ProductNameTextBox" MaxLength="100" runat="server" Width="400px"
                                            Text='<%# Bind("Name") %>'></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="ProductNameRequiredFieldValidator" runat="server"
                                            ErrorMessage="*" ValidationGroup="UpdateProduct" ControlToValidate="ProductNameTextBox"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CategoryLabel" runat="server" AssociatedControlID="CategoryDropDownList"
                                            Font-Size="Small" Text="زيرشاخه"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="CategoryDropDownList" runat="server" Font-Names="Tahoma" Style="min-width: 400px"
                                            SelectedValue='<%# Bind("Category_ID") %>' OnDataBinding="CategoryDropDownList_DataBinding">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="MaxPriceLabel" runat="server" AssociatedControlID="MaxPriceTextBox"
                                            Font-Size="Small" Text="قيمت بيشينه (ريال) *"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="MaxPriceTextBox" runat="server" Width="400px" Text='<%# Bind("MaxPrice") %>'></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="MaxPriceRequiredFieldValidator" ValidationGroup="UpdateProduct"
                                            runat="server" ErrorMessage="*" ControlToValidate="MaxPriceTextBox" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="MaxPriceRegularExpressionValidator" ValidationGroup="UpdateProduct"
                                            runat="server" ControlToValidate="MaxPriceTextBox" ErrorMessage="قيمت نامعتبر است"
                                            ValidationExpression="\d*\.?\d*" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="MinPriceLabel" runat="server" AssociatedControlID="MinPriceTextBox"
                                            Font-Size="Small" Text="قيمت کمينه (ريال) *"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="MinPriceTextBox" runat="server" Width="400px" Text='<%# Bind("MinPrice") %>'></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="MinPriceRequiredFieldValidator" ValidationGroup="UpdateProduct"
                                            runat="server" ErrorMessage="*" ControlToValidate="MinPriceTextBox" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="MinPriceRegularExpressionValidator" ValidationGroup="UpdateProduct"
                                            runat="server" ControlToValidate="MinPriceTextBox" ErrorMessage="قيمت نامعتبر است"
                                            ValidationExpression="\d*\.?\d*" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProductRatingLabel" runat="server" AssociatedControlID="ProductRatingControl"
                                            Font-Size="Small" Text="امتياز"></asp:Label>
                                    </td>
                                    <td>
                                        <ajax:Rating ID="ProductRatingControl" runat="server" EmptyStarCssClass="emptyRatingStar"
                                            CssClass="sigupTable" FilledStarCssClass="filledRatingStar" StarCssClass="ratingStar"
                                            WaitingStarCssClass="savedRatingStar" Width="65px" RatingDirection="RightToLeftBottomToTop"
                                            BehaviorID="ProductRatingControl_RatingExtender" CurrentRating='<%# Bind("Rate") %>'>
                                        </ajax:Rating>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;</td>
                                    <td style="font-size: 13px; font-style: italic">
                                        &nbsp;&nbsp;&nbsp;توضيحات</td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="OverviewLabel" runat="server" AssociatedControlID="OverviewTextBox"
                                            Font-Size="Small" Text="توضيحات کلي *"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="OverviewTextBox" runat="server" Width="400px" Rows="6" TextMode="MultiLine"
                                            Text='<%# Bind("Overview") %>' Font-Size="10px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator ValidationGroup="UpdateProduct" ID="OverviewRequiredFieldValidator"
                                            runat="server" ErrorMessage="*" ControlToValidate="OverviewTextBox" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="DetailsLabel" runat="server" AssociatedControlID="DetailsHtmlEditor"
                                            Font-Size="Small" Text="جزئيات"></asp:Label>
                                    </td>
                                    <td>
                                        <rte:HtmlEditor ID="DetailsHtmlEditor" runat="server" AspxDirectory="~/Images/Product/ImageBrowser/Aspx"
                                            EnableViewState="true" BackColor="White" ButtonMouseOverBorderColor="49, 106, 197"
                                            ButtonMouseOverColor="193, 210, 238" ContextChanged="" CountLockedColor="Red"
                                            CountNormalColor="Black" CountStateChanged="" CountWarningColor="Navy" DialogBackColor="GhostWhite"
                                            DialogBorderColor="Black" DialogButtonBarColor="LightSteelBlue" DialogForeColor="Black"
                                            DialogHeadingColor="LightSteelBlue" DialogHeadingTextColor="Black" DialogSelectedTabColor="127, 157, 185"
                                            DialogSelectedTabTextColor="White" DialogTableColor="238, 238, 238" DialogTabTextColor="Black"
                                            DialogUnselectedTabColor="LightSteelBlue" EditorBackColor="White" EditorBorderColor="127, 157, 185"
                                            EditorForeColor="Black" EditorInnerBorderColor="Gray" EmotionsFolder="~/Images/AjaxControlImages/HtmlEditorEmotions"
                                            LockedMessage="" ModifiedChanged="" PasteConversion="" SaveButtons="" SelectedTabBackColor="127, 157, 185"
                                            SelectedTabTextColor="White" SizeChanged="" SizeHandleColor="127, 157, 185" TabBackColor="LightSteelBlue"
                                            TabbarBackColor="White" TabForeColor="Black" TabMouseOverColor="LightBlue" ToolbarColor="127, 157, 185"
                                            UrlConversion="" Width="405px" Height="400px" TextDirection="RightToLeft" Toolbars="Select#Format,Select#Font,Select#Size:ForeColor,BackColor;Undo,Redo:Cut,Copy,Paste:Link,Unlink,Image,Symbol,Rule,Table,RemoveFormat:Emotions;Bold,Italic,Underline:Left,Center,Right,Justify|OrderedList,BulletedList|Indent,Outdent|Subscript,Superscript,StrikeThrough"
                                            ImagesDirectory="~/Images/Product/ImageBrowser/images" AllowedImageExtensions="gif,jpg,jpeg,png,bmp"
                                            AllowedMimeTypes="image/gif,image/jpeg,image/pjpeg,image/png,image/x-png,image/bmp"
                                            Text='<%# Bind("Details") %>' ConvertDeprecatedSyntax="false" Style="margin-top: 5px"
                                            AllowedTags="a,abbr,acronym,address,b,big,blockquote,br,caption,center,code,col,colgroup,dd,del,dfn,dir,div,dl,dt,em,fieldset,font,h1,h2,h3,h4,h5,h6,hr,i,img,ins,li,map,ol,p,pre,q,s,small,span,strike,strong,style,sub,sup,table,tbody,td,textarea,tfoot,th,thead,title,tr,tt,u,ul"
                                            AllowedAttributes="align,alt,background,bgcolor,border,cellpadding,cellspacing,class,color,cols,colspan,coords,dir,face,href,hspace,marginheight,marginwidth,noshade,nowrap,rows,rowspan,shape,size,src,style,summary,target,title,usemap,valign" />
                                        <!-- AllowedTags="a,abbr,acronym,address,applet,area,b,base,basefont,bdo,big,blockquote,body,br,button,caption,center,cite,code,col,colgroup,dd,del,dfn,dir,div,dl,dt,em,fieldset,font,form,frame,frameset,h1,h2,h3,h4,h5,h6,head,hr,html,i,iframe,img,input,ins,isindex,kbd,label,legend,li,link,map,menu,meta,noframes,noscript,object,ol,optgroup,option,p,param,pre,q,s,samp,script,select,small,span,strike,strong,style,sub,sup,table,tbody,td,textarea,tfoot,th,thead,title,tr,tt,u,ul,var"
                                                AllowedAttributes="abbr,accept-charset,accept,accesskey,action,align,alink,alt,archive,axis,background,bgcolor,border,cellpadding,cellspacing,char,charoff,charset,checked,cite,class,classid,clear,code,codebase,codetype,color,cols,colspan,compact,content,coords,data,datetime,declare,defer,dir,disabled,enctype,face,for,frame,frameborder,headers,height,href,hreflang,hspace,http-equiv,id,ismap,label,lang,language,link,longdesc,marginheight,marginwidth,maxlength,method,multiple,name,nohref,noresize,noshade,nowrap,object,onblur,onchange,onclick,ondblclick,onfocus,onkeydown,onkeypress,onkeyup,onload,onload,onmousedown,onmousemove,onmouseout,onmouseover,onmouseup,onreset,onselect,onsubmit,onunload,onunload,profile,prompt,readonly,rel,rev,rows,rowspan,rules,scheme,scope,scrolling,selected,shape,size,span,src,standby,start,style,summary,tabindex,target,text,title,type,usemap,valign,value,valuetype,version,vlink,vspace,width" -->
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="TagsLabel" runat="server" AssociatedControlID="TagsTextBox" Font-Size="Small"
                                            Text="برچسب ها"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TagsTextBox" MaxLength="200" runat="server" Width="400px" Text='<%# Bind("Tags") %>'
                                            ToolTip="برچسب ها را با کاما (,) از يکديگر جدا نماييد"></asp:TextBox>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;</td>
                                    <td style="font-size: 13px; font-style: italic">
                                        &nbsp;&nbsp;&nbsp;تصاوير کالا</td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="BrandImageLabel" runat="server" AssociatedControlID="BrandImageBrowser"
                                            Font-Size="Small" Text="علامت تجاري"></asp:Label>
                                    </td>
                                    <td>
                                        <uc1:ImageBrowser ID="BrandImageBrowser" runat="server" ToolTip="مسير تصوير علامت تجاري"
                                            Text='<%# Bind("BrandImageUrl") %>' AddressWidth="280px" ImageVisibility="visible"
                                            ImageUrl='<%# Eval("BrandImageUrl").ToString().Trim() != ""? Eval("BrandImageUrl").ToString().Trim(): "~/Images/Product/nobrand.gif" %>' />
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LogoImageLabel" runat="server" AssociatedControlID="LogoImageBrowser"
                                            Font-Size="Small" Text="لوگوي کالا"></asp:Label>
                                    </td>
                                    <td>
                                        <uc1:ImageBrowser ID="LogoImageBrowser" runat="server" ToolTip="مسير تصوير لوگوي کالا"
                                            Text='<%# Bind("LogoImageUrl") %>' AddressWidth="280px" ImageVisibility="visible"
                                            ImageUrl='<%# Eval("LogoImageUrl").ToString().Trim() != ""? Eval("LogoImageUrl").ToString().Trim(): "~/Images/Product/nologo.gif" %>' />
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="OtherImagesLabel" runat="server" AssociatedControlID="OtherImagesBrowser"
                                            Font-Size="Small" Text="تصاوير کالا"></asp:Label>
                                    </td>
                                    <td>
                                        <uc1:ImageBrowser ID="OtherImagesBrowser" runat="server" ToolTip="مسير تصاوير کالا که با علامت '|' از هم جدا شده اند"
                                            Text='<%# GetOtherImagesUrl(Eval("ImagesUrl")) %>' ImageVisibility="visible"
                                            ImageUrl='<%# OtherImagesUrl %>' AddressWidth="280px" IsAppendable="true" />
                                        <br />
                                        <asp:TextBox ID="TooltipTextBox" runat="server" Height="50px" Width="400px" Style="text-align: right;
                                            direction: rtl; float: right; margin-top: 3px" ToolTip="توضيح هر يک از تصاوير کالا را به ترتيب وارد و با علامت '|' از هم جدا کنيد."
                                            TextMode="MultiLine" Text='<%# ImageToolTips %>'></asp:TextBox>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CommentsLabel" runat="server" AssociatedControlID="ManageCommentsUpdatePanel"
                                            Font-Size="Small" Text="نظرات کاربران"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="ManageCommentsUpdatePanel" runat="server">
                                            <ContentTemplate>
                                                <asp:FormView ID="ManageCommentsFormView" runat="server" AllowPaging="True" DataSourceID="ManageCommentsSqlDataSource"
                                                    DataKeyNames="Username" EnableViewState="true">
                                                    <ItemTemplate>
                                                        <div class="signupTable" style="font-size: small">
                                                            <center>
                                                                کاربر:&nbsp;&nbsp;<asp:HyperLink ID="ManageCommentUsernameHyperLink" runat="server"
                                                                    Text='<%# Bind("Username") %>' NavigateUrl='<%# "~/Page/User/ViewDetail.aspx?UserID=" + Eval("Username").ToString().Trim() %>'
                                                                    ToolTip='<%# Eval("FirstName").ToString().Trim() + " " + Eval("LastName").ToString().Trim() %>'
                                                                    Style="color: Teal; font-weight: bold" Target="_blank"></asp:HyperLink><br />
                                                                <asp:TextBox ID="ManageCommentTextBox" runat="server" Text='<%# Eval("Comment").ToString().Trim() %>'
                                                                    ToolTip='<%# "نظر کاربر: " + Eval("FirstName").ToString().Trim() + " " + Eval("LastName").ToString().Trim() %>'
                                                                    Width="350px" TextMode="MultiLine" Height="100px" ReadOnly="true"></asp:TextBox><br />
                                                            </center>
                                                            <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                                                                Text="حذف نظر">
                                                            </asp:LinkButton>
                                                        </div>
                                                    </ItemTemplate>
                                                    <EmptyDataTemplate>
                                                        <div class="signupTable" style="font-size: small">
                                                            ---
                                                        </div>
                                                    </EmptyDataTemplate>
                                                </asp:FormView>
                                                <asp:SqlDataSource ID="ManageCommentsSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
                                                    DeleteCommand="DELETE FROM Product_Account WHERE (Product_Account.Username = @Username) AND (Product_Account.Product_ID = @ID)"
                                                    SelectCommand="SELECT Product_Account.Comment, Product_Account.Username, Account.FirstName, Account.LastName FROM Product_Account INNER JOIN Account ON Account.Username = Product_Account.Username INNER JOIN Product ON Product.ID = Product_Account.Product_ID WHERE (Product.ID = @ID)">
                                                    <DeleteParameters>
                                                        <asp:QueryStringParameter Name="ID" QueryStringField="ID" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="ID" QueryStringField="ID" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:Button ID="UpdateProductButton_Bottom" runat="server" CommandName="Update" Text="تغيير مشخصات"
                                            OnClick="UpdateProductButton_Click" ValidationGroup="UpdateProduct" />
                                        &nbsp;
                                        <asp:Button ID="DeleteProductButton_Bottom" runat="server" CommandName="Delete" Text="حذف محصول"
                                            OnClick="DeleteProductButton_Click" ValidationGroup="UpdateProduct" PostBackUrl="#"
                                            CausesValidation="False" OnClientClick="javascript: return confirm('آيا واقعا مايل به حذف اين محصول هستيد؟');" />
                                        &nbsp;
                                        <asp:Button ID="CancelButton_Bottom" runat="server" UseSubmitBehavior="false" CommandName="Cancel"
                                            Text="انصراف" CausesValidation="False" ValidationGroup="UpdateProduct" OnClick="CancelBackButton_Click" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </EditItemTemplate>
                </asp:FormView>
            </asp:View>
            <asp:View ID="UpdatePromptView" runat="server">
                <div class="signupTable">
                    <asp:Label ID="UpdateSuccessLabel" runat="server" Text="مشخصات محصول با موفقيت تغيير يافت."
                        Font-Bold="True" ForeColor="#009900" Height="25px" Font-Size="Small"></asp:Label>
                    <br />
                    <br />
                    <asp:Button ID="UpdateBackButton" runat="server" Text="بازگشت به محصول" Font-Bold="True"
                        BackColor="#330099" Font-Size="11pt" ForeColor="#FFFFFF" Height="28px" Width="172px"
                        OnClick="UpdateBackButton_Click" />
                </div>
            </asp:View>
            <asp:View ID="DeletePromptView" runat="server">
                <div class="signupTable">
                    <asp:Label ID="DeleteSuccessLabel" runat="server" Text="محصول با موفقيت حذف شد."
                        Font-Bold="True" ForeColor="#009900" Height="25px" Font-Size="Small"></asp:Label>
                    <br />
                    <br />
                    <asp:Button ID="CancelBackButton" runat="server" Text="بازگشت به صفحه قبل" Font-Bold="True"
                        BackColor="#330099" Font-Size="11pt" ForeColor="#FFFFFF" Height="28px" Width="172px"
                        OnClick="CancelBackButton_Click" />
                </div>
            </asp:View>
        </asp:MultiView>
        &nbsp;<br />
    </div>
</asp:Content>

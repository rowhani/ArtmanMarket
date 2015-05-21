<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Seller.aspx.cs" Inherits="Page_Shop_Seller" Title="صفحه فروشنده" ErrorPage="~/Page/Errors/Error500.htm" %>

<asp:Content ID="SellerContent" ContentPlaceHolderID="MasterContentPlaceHolder" runat="Server">
    <div>
        <h3 class="signupTable" style="color: Gray">
            <asp:Label ID="CaptionLabel" runat="server" Text="نمايش فروشگاه"></asp:Label></h3>
        <hr style="border-top: 1px dashed Gray;" />
        <asp:Panel ID="ErrorPanel" runat="server" Visible="false">
            <br />
            <br />
            <asp:Label ID="ErrorLabel" Style="text-align: center; direction: rtl; font-family: Tahoma;
                font-size: small" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
        </asp:Panel>
        <asp:MultiView ID="ShopMultiView" runat="server" ActiveViewIndex="0">
            <asp:View ID="ShopManageView" runat="server">
                <asp:SqlDataSource ID="ShopSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
                    DeleteCommand="DELETE FROM [Shop] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Shop] ([Name], [Logo], [ResponsibleName], [ResponsibleRole], [Website], [Email], [Phone], [Fax], [Cellular], [Address], [ZipCode], [YahooIM], [Resume]) VALUES (@Name, @Logo, @ResponsibleName, @ResponsibleRole, @Website, @Email, @Phone, @Fax, @Cellular, @Address, @ZipCode, @YahooIM, @Resume)"
                    SelectCommand="SELECT * FROM [Shop] WHERE ([ID] = @ID)" UpdateCommand="UPDATE [Shop] SET [Name] = @Name, [Logo] = @Logo, [ResponsibleName] = @ResponsibleName, [ResponsibleRole] = @ResponsibleRole, [Website] = @Website, [Email] = @Email, [Phone] = @Phone, [Fax] = @Fax, [Cellular] = @Cellular, [Address] = @Address, [ZipCode] = @ZipCode, [YahooIM] = @YahooIM, [Resume] = @Resume WHERE [ID] = @ID">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ID" QueryStringField="ShopID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:FormView ID="ShopFormView" runat="server" DataSourceID="ShopSqlDataSource" OnItemInserting="ShopFormView_ItemInserting"
                    OnItemUpdating="ShopFormView_ItemUpdating" OnItemDeleting="ShopFormView_ItemDeleting"
                    DataKeyNames="ID">
                    <InsertItemTemplate>
                        <asp:Panel ID="ShopInsertPanel" runat="server" DefaultButton="CreateShopButton">
                            <table class="signupTable" cellpadding="2px">
                                <tr>
                                    <td colspan="2">
                                        <b>لطفاً براي ايجاد يک فروشگاه جديد فرم زير را پر کنيد.</b></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <b>مواردي که با علامت * مشخص شده‌اند را حتماً وارد کنيد.</b></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ShopNameLabel" runat="server" Text="نام فروشگاه*" AssociatedControlID="ShopNameTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ShopNameTextBox" MaxLength="100" runat="server" Width="150px" Text='<%# Bind("Name") %>'></asp:TextBox>
                                        &nbsp;
                                        <asp:RequiredFieldValidator ValidationGroup="SellerPanel" ID="ShopNameRequiredFieldValidator"
                                            runat="server" ControlToValidate="ShopNameTextBox" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LogoLabel" runat="server" Text="لوگوي فروشگاه" AssociatedControlID="LogoFileUpload"></asp:Label></td>
                                    <td>
                                        <asp:FileUpload ID="LogoFileUpload" runat="server" Width="238px" />
                                        &nbsp;
                                        <asp:RegularExpressionValidator ValidationGroup="SellerPanel" ID="LogoRegularExpressionValidator"
                                            runat="server" ControlToValidate="LogoFileUpload" ValidationExpression=".+\.(((j|J)(p|P)(e|E)?(g|G))|((g|G)(i|I)(f|F))|((p|P)(n|N)(g|G)))"
                                            ErrorMessage="لوگوي فروشگاه بايد تصويري به فرمت jpg, gif, يا png باشد."></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ResponsibleNameLabel" runat="server" Text="نام مسئول*" AssociatedControlID="ResponsibleNameTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ResponsibleNameTextBox" MaxLength="100" Text='<%# Bind("ResponsibleName") %>'
                                            runat="server" Width="150px"></asp:TextBox>
                                        &nbsp;
                                        <asp:RequiredFieldValidator ValidationGroup="SellerPanel" ID="ResponsibleNameRequiredFieldValidator"
                                            runat="server" ControlToValidate="ResponsibleNameTextBox" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ResponsibleRoleLabel" runat="server" Text="سِمَت" AssociatedControlID="ResponsibleRoleTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ResponsibleRoleTextBox" MaxLength="50" runat="server" Width="150px"
                                            Text='<%# Bind("ResponsibleRole") %>'></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="WebsiteLabel" runat="server" Text="پايگاه اينترنتي" AssociatedControlID="WebsiteTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="WebsiteTextBox" runat="server" MaxLength="200" Width="150px" Text='<%# Bind("Website") %>'></asp:TextBox>
                                        &nbsp;
                                        <asp:RegularExpressionValidator ValidationGroup="SellerPanel" ID="WebsiteRegularExpressionValidator"
                                            runat="server" ControlToValidate="WebsiteTextBox" ErrorMessage="پايگاه اينترنتي نامعتبر است."
                                            ValidationExpression="(http(s)?://)?([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="EmailLabel" runat="server" Text="پست الکترونيکي*" AssociatedControlID="EmailTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="EmailTextBox" runat="server" MaxLength="100" Width="150px" Text='<%# Bind("Email") %>'></asp:TextBox>
                                        &nbsp;
                                        <asp:RequiredFieldValidator ValidationGroup="SellerPanel" ID="EmailRequiredFieldValidator"
                                            runat="server" ControlToValidate="EmailTextBox" ErrorMessage="*">
                                        </asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="EmailRegularExpressionValidator"
                                            runat="server" ControlToValidate="EmailTextBox" ValidationGroup="SellerPanel"
                                            ErrorMessage="ايميل نا معتبر است." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="PhoneLabel" runat="server" Text="تلفن ثابت*" AssociatedControlID="PhoneTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="PhoneTextBox" runat="server" MaxLength="20" Width="150px" Text='<%# Bind("Phone") %>'></asp:TextBox>
                                        &nbsp;
                                        <asp:RequiredFieldValidator ValidationGroup="SellerPanel" ID="PhoneRequiredFieldValidator"
                                            runat="server" ControlToValidate="PhoneTextBox" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="FaxLabel" runat="server" Text="نمابر" AssociatedControlID="FaxTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="FaxTextBox" runat="server" MaxLength="20" Width="150px" Text='<%# Bind("Fax") %>'></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CellularLabel" runat="server" Text="تلفن همراه" AssociatedControlID="CellularTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="CellularTextBox" runat="server" MaxLength="20" Width="150px" Text='<%# Bind("Cellular") %>'></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="AddressLabel" runat="server" Text="نشاني*" AssociatedControlID="AddressTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="AddressTextBox" runat="server" MaxLength="200" Width="150px" TextMode="multiline"
                                            Rows="3" Text='<%# Bind("Address") %>'></asp:TextBox>
                                        &nbsp;
                                        <asp:RequiredFieldValidator ValidationGroup="SellerPanel" ID="AddressRequiredFieldValidator"
                                            runat="server" ControlToValidate="AddressTextBox" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ZipCodeLabel" runat="server" Text="کد پستي" AssociatedControlID="ZipCodeTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ZipCodeTextBox" runat="server" MaxLength="20" Width="150px" Text='<%# Bind("ZipCode") %>'></asp:TextBox>
                                        &nbsp;
                                        <asp:RegularExpressionValidator ValidationGroup="SellerPanel" ID="ZipCodeRegularExpressionValidator"
                                            runat="server" ControlToValidate="ZipCodeTextBox" ErrorMessage="کد پستي نامعتبر است."
                                            ValidationExpression="\d{5}[-]{0,1}\d{5}"></asp:RegularExpressionValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="YahooIMLabel" runat="server" Text="ياهو مسنجر" AssociatedControlID="YahooIMTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="YahooIMTextBox" runat="server" Width="150px" MaxLength="50" Text='<%# Bind("YahooIM") %>'></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ResumeLabel" runat="server" Text="رزومه" AssociatedControlID="ResumeTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ResumeTextBox" runat="server" Width="150px" MaxLength="1000" TextMode="MultiLine"
                                            Rows="3" Text='<%# Bind("Resume") %>'></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="CreateShopButton" ValidationGroup="SellerPanel" runat="server" CommandName="Insert"
                                            Text="ساخت فروشگاه" OnClick="CreateShopButton_Click" /></td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </InsertItemTemplate>
                    <EditItemTemplate>
                        <asp:Panel ID="ShopUpdatePanel" runat="server" EnableViewState="false" DefaultButton="UpdateShopButton">
                            <table class="signupTable" cellpadding="2px">
                                <tr>
                                    <td colspan="2">
                                        <b>لطفاً براي بروزرساني اين فروشگاه فرم زير را ويرايش کنيد.</b></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <b>مواردي که با علامت * مشخص شده‌اند را حتماً وارد کنيد.</b></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ShopNameLabel" runat="server" Text="نام فروشگاه*" AssociatedControlID="ShopNameTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ShopNameTextBox" MaxLength="100" runat="server" Width="150px" Text='<%# Bind("Name") %>'></asp:TextBox>
                                        &nbsp;
                                        <asp:RequiredFieldValidator ValidationGroup="SellerPanel" ID="ShopNameRequiredFieldValidator"
                                            runat="server" ControlToValidate="ShopNameTextBox" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LogoLabel" runat="server" Text="لوگوي فروشگاه" AssociatedControlID="LogoFileUpload"></asp:Label></td>
                                    <td>
                                        <table style="vertical-align: middle; text-align: center">
                                            <tr>
                                                <td>
                                                    <asp:FileUpload ID="LogoFileUpload" runat="server" Width="238px" />
                                                </td>
                                                <td>
                                                    <div style="height: 25px; width: 80px;">
                                                        <asp:Image ID="LogoImage" runat="server" ToolTip="لوگوي فروشگاه" Style="max-height: 25px;
                                                            vertical-align: middle; text-align: right" ImageUrl='<%# Bind("Logo") %>' Visible='<%# !String.IsNullOrEmpty(Eval("Logo").ToString().Trim()) %>' />
                                                    </div>
                                                </td>
                                                <td>
                                                    <asp:RegularExpressionValidator ValidationGroup="SellerPanel" ID="LogoRegularExpressionValidator"
                                                        runat="server" ControlToValidate="LogoFileUpload" ValidationExpression=".+\.(((j|J)(p|P)(e|E)?(g|G))|((g|G)(i|I)(f|F))|((p|P)(n|N)(g|G)))"
                                                        ErrorMessage="لوگوي فروشگاه بايد تصويري به فرمت jpg, gif, يا png باشد."></asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ResponsibleNameLabel" runat="server" Text="نام مسئول*" AssociatedControlID="ResponsibleNameTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ResponsibleNameTextBox" MaxLength="100" Text='<%# Bind("ResponsibleName") %>'
                                            runat="server" Width="150px"></asp:TextBox>
                                        &nbsp;
                                        <asp:RequiredFieldValidator ValidationGroup="SellerPanel" ID="ResponsibleNameRequiredFieldValidator"
                                            runat="server" ControlToValidate="ResponsibleNameTextBox" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ResponsibleRoleLabel" runat="server" Text="سِمَت" AssociatedControlID="ResponsibleRoleTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ResponsibleRoleTextBox" MaxLength="50" runat="server" Width="150px"
                                            Text='<%# Bind("ResponsibleRole") %>'></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="WebsiteLabel" runat="server" Text="پايگاه اينترنتي" AssociatedControlID="WebsiteTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="WebsiteTextBox" MaxLength="200" runat="server" Width="150px" Text='<%# Bind("Website") %>'></asp:TextBox>
                                        &nbsp;
                                        <asp:RegularExpressionValidator ValidationGroup="SellerPanel" ID="WebsiteRegularExpressionValidator"
                                            runat="server" ControlToValidate="WebsiteTextBox" ErrorMessage="پايگاه اينترنتي نامعتبر است."
                                            ValidationExpression="(http(s)?://)?([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="EmailLabel" runat="server" Text="پست الکترونيکي*" AssociatedControlID="EmailTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="EmailTextBox" runat="server" MaxLength="100" Width="150px" Text='<%# Bind("Email") %>'></asp:TextBox>
                                        &nbsp;
                                        <asp:RequiredFieldValidator ValidationGroup="SellerPanel" ID="EmailRequiredFieldValidator"
                                            runat="server" ControlToValidate="EmailTextBox" ErrorMessage="*">
                                        </asp:RequiredFieldValidator><asp:RegularExpressionValidator ValidationGroup="SellerPanel"
                                            ID="EmailRegularExpressionValidator" runat="server" ControlToValidate="EmailTextBox"
                                            ErrorMessage="ايميل نا معتبر است." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="PhoneLabel" runat="server" Text="تلفن ثابت*" AssociatedControlID="PhoneTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="PhoneTextBox" runat="server" MaxLength="20" Width="150px" Text='<%# Bind("Phone") %>'></asp:TextBox>
                                        &nbsp;
                                        <asp:RequiredFieldValidator ValidationGroup="SellerPanel" ID="PhoneRequiredFieldValidator"
                                            runat="server" ControlToValidate="PhoneTextBox" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="FaxLabel" runat="server" Text="نمابر" AssociatedControlID="FaxTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="FaxTextBox" runat="server" Width="150px" MaxLength="20" Text='<%# Bind("Fax") %>'></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CellularLabel" runat="server" Text="تلفن همراه" AssociatedControlID="CellularTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="CellularTextBox" runat="server" MaxLength="20" Width="150px" Text='<%# Bind("Cellular") %>'></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="AddressLabel" runat="server" Text="نشاني*" AssociatedControlID="AddressTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="AddressTextBox" runat="server" Width="150px" MaxLength="200" TextMode="multiline"
                                            Rows="3" Text='<%# Bind("Address") %>'></asp:TextBox>
                                        &nbsp;
                                        <asp:RequiredFieldValidator ValidationGroup="SellerPanel" ID="AddressRequiredFieldValidator"
                                            runat="server" ControlToValidate="AddressTextBox" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ZipCodeLabel" runat="server" Text="کد پستي" AssociatedControlID="ZipCodeTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ZipCodeTextBox" runat="server" Width="150px" MaxLength="20" Text='<%# Bind("ZipCode") %>'></asp:TextBox>
                                        &nbsp;
                                        <asp:RegularExpressionValidator ValidationGroup="SellerPanel" ID="ZipCodeRegularExpressionValidator"
                                            runat="server" ControlToValidate="ZipCodeTextBox" ErrorMessage="کد پستي نامعتبر است."
                                            ValidationExpression="\d{5}[-]{0,1}\d{5}"></asp:RegularExpressionValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="YahooIMLabel" runat="server" Text="ياهو مسنجر" AssociatedControlID="YahooIMTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="YahooIMTextBox" runat="server" Width="150px" MaxLength="50" Text='<%# Bind("YahooIM") %>'></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ResumeLabel" runat="server" Text="رزومه" AssociatedControlID="ResumeTextBox"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ResumeTextBox" runat="server" Width="150px" MaxLength="1000" TextMode="MultiLine"
                                            Rows="3" Text='<%# Bind("Resume") %>'></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:HyperLink ID="ShowProductsHyperLink" runat="server" Target="_blank" NavigateUrl='<%# "~/Page/Shop/ManageShopProduct.aspx?ShopID=" + Request.QueryString["ShopID"].Trim() %>'>ويرايش محصولات اين فروشگاه</asp:HyperLink></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="UpdateShopButton" ValidationGroup="SellerPanel" runat="server" CommandName="Update"
                                            Text="بروزرساني فروشگاه" OnClick="UpdateShopButton_Click" />
                                        &nbsp;
                                        <asp:Button ID="DeleteShopButton" ValidationGroup="SellerPanel" runat="server" CommandName="Delete"
                                            CausesValidation="False" Text="حذف فروشگاه" OnClick="DeleteShopButton_Click"
                                            OnClientClick="javascript: return confirm('آيا واقعا مايل به حذف اين فروشگاه هستيد؟');" />
                                        &nbsp;
                                        <asp:Button ID="CancelButton" ValidationGroup="SellerPanel" runat="server" UseSubmitBehavior="false"
                                            CommandName="Cancel" Text="انصراف" CausesValidation="False" OnClick="ReturnButton_Click" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Panel ID="ShopViewPanel" runat="server" EnableViewState="false">
                            <table class="signupTable" cellpadding="7px" border="1px" style="border: dotted 1px silver"
                                width="540px">
                                <tr style="background-color: #336699; color: White; font-family: Tahoma; font-size: 12pt;
                                    font-weight: bold; direction: rtl; vertical-align: middle">
                                    <td colspan="2">
                                        <table>
                                            <tr>
                                                <td style="height: 25px; width: 25px;">
                                                    <asp:Image ID="LogoImage" runat="server" Style="max-height: 25px; vertical-align: middle;
                                                        text-align: right;" ToolTip='<%# "فروشگاه " + Eval("Name").ToString().Trim() %>'
                                                        ImageUrl='<%# !String.IsNullOrEmpty(Eval("Logo").ToString().Trim()) ? Eval("Logo") : "~/Images/Shop/defaultShop.png" %>' />
                                                </td>
                                                <td style="text-align: right;">
                                                    &nbsp;<asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ResponsibleNameLabel" runat="server" Text="نام مسئول"></asp:Label></td>
                                    <td>
                                        <asp:Label ID="ResponsibleNameValueLabel" Text='<%# Eval("ResponsibleName") %>' runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ResponsibleRoleLabel" runat="server" Text="سِمَت"></asp:Label></td>
                                    <td>
                                        <asp:Label ID="ResponsibleRoleValueLabel" runat="server" Text='<%# Eval("ResponsibleRole") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="WebsiteLabel" runat="server" Text="پايگاه اينترنتي"></asp:Label></td>
                                    <td style="text-align: left;">
                                        <asp:HyperLink ID="WebsiteHyperLink" runat="server" NavigateUrl='<%# Eval("Website") %>'
                                            Text='<%# Eval("Website") %>'></asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="EmailLabel" runat="server" Text="پست الکترونيکي"></asp:Label></td>
                                    <td style="text-align: left;">
                                        <asp:HyperLink ID="EmailHyperLink" runat="server" NavigateUrl='<%# "mailto:" + Eval("Email") %>'
                                            Text='<%# Eval("Email") %>'></asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="PhoneLabel" runat="server" Text="تلفن ثابت"></asp:Label></td>
                                    <td style="text-align: left;">
                                        <asp:Label ID="PhoneValueLabel" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="FaxLabel" runat="server" Text="نمابر"></asp:Label></td>
                                    <td style="text-align: left;">
                                        <asp:Label ID="FaxValueLabel" runat="server" Text='<%# Eval("Fax") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CellularLabel" runat="server" Text="تلفن همراه"></asp:Label></td>
                                    <td style="text-align: left;">
                                        <asp:Label ID="CellularValueLabel" runat="server" Text='<%# Eval("Cellular") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="AddressLabel" runat="server" Text="نشاني"></asp:Label></td>
                                    <td>
                                        <asp:Label ID="AddressValueLabel" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ZipCodeLabel" runat="server" Text="کد پستي"></asp:Label></td>
                                    <td>
                                        <asp:Label ID="ZipCodeValueLabel" runat="server" Text='<%# Eval("ZipCode") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="YahooIMLabel" runat="server" Text="ياهو مسنجر"></asp:Label></td>
                                    <td style="text-align: left; float: left; margin: 0;">
                                        <asp:Panel ID="YahooIMPanel" runat="server" Visible='<%# !String.IsNullOrEmpty(Eval("YahooIM").ToString().Trim()) %>'>

                                            <script type='text/javascript' src='<%# "http://yahoo-status.abzarak.com?s=2&id=" + Eval("YahooIM").ToString().Trim() %>'></script>

                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ResumeLabel" runat="server" Text="رزومه"></asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ResumeTextBox" runat="server" ReadOnly="true" TextMode="MultiLine"
                                            Rows="6" Text='<%# Eval("Resume").ToString().Trim() %>' Width="412px"></asp:TextBox></td>
                                </tr>
                            </table>
                            <div class="signupTable">
                                <br />
                                <asp:HyperLink ID="ShowProductsHyperLink" runat="server" Target="_blank" NavigateUrl='<%# "~/Page/Shop/ShowShopProduct.aspx?ShopID=" + Request.QueryString["ShopID"].Trim() %>'>مشاهده ليست کامل محصولات اين فروشگاه</asp:HyperLink></td>
                            </div>
                        </asp:Panel>
                    </ItemTemplate>
                </asp:FormView>
            </asp:View>
            <asp:View ID="CreateConfirmView" runat="server">
                <div class="signupTable">
                    <asp:Label ID="InsertConfirmLabel" runat="server">فروشگاه جديد با موفقيت ثبت شد.</asp:Label>
                    <br />
                    <br />
                    اکنون شما مي توانيد براي
                    <asp:LinkButton ID="CreateProductLinkButton" runat="server">ساخت</asp:LinkButton>
                    محصولات اين فروشگاه يا انتخاب آنها از طريق
                    <asp:LinkButton ID="SelectProductByCategoryLinkButton" runat="server">شاخه ها</asp:LinkButton>
                    و
                    <asp:LinkButton ID="SelectProductBySearchLinkButton" runat="server">جستجو</asp:LinkButton>
                    اقدام نماييد.
                    <br />
                    <br />
                    <asp:HyperLink ID="CreateNewShopHyperLink" runat="server" NavigateUrl="~/Page/Shop/Seller.aspx">ساخت يک فروشگاه ديگر</asp:HyperLink>
                </div>
            </asp:View>
            <asp:View ID="UpdateConfirmView" runat="server">
                <div class="signupTable">
                    <asp:Label ID="UpdateConfirmLabel" runat="server">فروشگاه با موفقيت بروزرساني شد.</asp:Label>
                    <br />
                    <br />
                    <asp:Button ID="UpdateReturnButton" runat="server" Text="بازگشت به صفحه قبل" OnClick="UpdateReturnButton_Click" />
                    &nbsp;<br />
                    &nbsp;</div>
            </asp:View>
            <asp:View ID="DeleteConfirmView" runat="server">
                <div class="signupTable">
                    <asp:Label ID="DeleteConfirmLabel" runat="server">فروشگاه با موفقيت حذف شد.</asp:Label>
                    <br />
                    <br />
                    <asp:Button ID="ReturnButton" runat="server" Text="بازگشت به صفحه قبل" OnClick="ReturnButton_Click" />
                    &nbsp;<br />
                    &nbsp;</div>
            </asp:View>
        </asp:MultiView>
        &nbsp;<br />
    </div>
</asp:Content>

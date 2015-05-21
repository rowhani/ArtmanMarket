<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ViewDetail.aspx.cs" Inherits="Page_User_ViewDetail" Title="مشاهده و تغيير مشخصات"
    ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register Assembly="PersianDateControls 2.0" Namespace="PersianDateControls" TagPrefix="pdc" %>
<asp:Content ID="MasterHeadContent" ContentPlaceHolderID="HeadContentPlaceHolder"
    runat="Server">
    <link href="<%= ResolveUrl("~/StyleSheets/PersianCalendarStyles.css") %>" rel="stylesheet"
        type="text/css" />
    <link href="<%= ResolveUrl("~/StyleSheets/AjaxControlStyles.css") %>" rel="stylesheet"
        type="text/css" />
</asp:Content>
<asp:Content ID="ViewDetailContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            مشاهده و تغيير مشخصات</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <asp:MultiView ID="ViewDetailMultiView" runat="server" ActiveViewIndex="0">
            <asp:View ID="ViewDetailFormView" runat="server">
                <asp:FormView ID="ViewDetailBindFormView" EnableViewState="false" runat="server"
                    DataSourceID="ViewDetailSqlDataSource" HorizontalAlign="Right" DataKeyNames="Username"
                    DefaultMode="Edit" OnItemUpdating="ViewDetailBindFormView_ItemUpdating">
                    <EditItemTemplate>
                        <asp:Panel ID="ViewDetailPanel" runat="server" DefaultButton="UpdateButton">
                            <table class="signupTable" cellspacing="2px">
                                <tr>
                                    <td colspan="3">
                                        <b>لطفاً فرم زير را ويرايش کنيد.</b></td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        <i>&nbsp;&nbsp;&nbsp;اطلاعات کاربر</i></td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="UserNameLabel" runat="server" Text="Label" AssociatedControlID="UserNameValueLabel"
                                            ForeColor="green">نام کاربري</asp:Label></td>
                                    <td>
                                        <asp:Label ID="UserNameValueLabel" runat="server" Width="125px" ForeColor="green"
                                            Font-Bold="true" Text='<%# Bind("Username") %>'></asp:Label></td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="PasswordLabel" runat="server" Text="Label" AssociatedControlID="PasswordTextBox">کلمه عبور جديد</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" Width="125px"
                                            Text='<%# Bind("Password") %>'></asp:TextBox>
                                        <ajax:TextBoxWatermarkExtender ID="PasswordTextBoxWatermark" runat="server" TargetControlID="PasswordTextBox"
                                            WatermarkText=" " WatermarkCssClass="passwordWatermarked" />
                                    </td>
                                    <td>
                                        <asp:RegularExpressionValidator ID="PasswordRegularExpressionValidator" runat="server"
                                            ControlToValidate="PasswordTextBox" ErrorMessage="کلمه عبور بايد حداقل 6 کاراکتر باشد."
                                            ValidationExpression=".{6,}" ValidationGroup="ViewDetailPanel"></asp:RegularExpressionValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ConfirmPasswordLabel" runat="server" Text="Label" AssociatedControlID="ConfirmPasswordTextBox">تاييد کلمه عبور</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ConfirmPasswordTextBox" runat="server" TextMode="Password" Width="125px"></asp:TextBox>
                                        <ajax:TextBoxWatermarkExtender ID="ConfirmPasswordTextBoxWatermark" runat="server"
                                            TargetControlID="ConfirmPasswordTextBox" WatermarkText=" " WatermarkCssClass="passwordWatermarked" />
                                    </td>
                                    <td>
                                        <asp:CompareValidator ID="PasswordCompareValidator" runat="server" ControlToCompare="PasswordTextBox"
                                            ControlToValidate="ConfirmPasswordTextBox" ValidationGroup="ViewDetailPanel"
                                            ErrorMessage="کلمه عبور و تاييد آن با هم برابر نيستند."></asp:CompareValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="EmailLabel" runat="server" Text="Label" AssociatedControlID="EmailTextBox">پست الکترونيکي*</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="EmailTextBox" runat="server" Width="125px" Text='<%# Bind("Email") %>'
                                            AutoCompleteType="Email" MaxLength="100"></asp:TextBox></td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="EmailRequiredFieldValidator" runat="server" ControlToValidate="EmailTextBox"
                                            ErrorMessage="*" ValidationGroup="ViewDetailPanel"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="EmailRegularExpressionValidator" runat="server"
                                            ControlToValidate="EmailTextBox" ValidationGroup="ViewDetailPanel" ErrorMessage="ايميل نا معتبر است."
                                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;</td>
                                    <td>
                                        <i>&nbsp;&nbsp;&nbsp;مشخصات کاربر</i></td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="UserTypeLabel" runat="server" Text="Label" AssociatedControlID="UserTypeDropDownList">نوع کاربري*</asp:Label></td>
                                    <td>
                                        <asp:DropDownList ID="UserTypeDropDownList" runat="server" Width="125px" SelectedValue='<%# Bind("UserType") %>'>
                                            <asp:ListItem Selected="True" Value="">لطفا انتخاب کنيد</asp:ListItem>
                                            <asp:ListItem Value="1">عادي (مصرف کننده)</asp:ListItem>
                                            <asp:ListItem Value="2">تجاري (فروشگاه/شرکت)</asp:ListItem>
                                            <asp:ListItem Value="3">علمي/فني</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="UserTypeRequiredFieldValidator" runat="server" ControlToValidate="UserTypeDropDownList"
                                            ErrorMessage="*" ValidationGroup="ViewDetailPanel"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="FirstNameLabel" runat="server" Text="Label" AssociatedControlID="FirstNameTextBox">نام*</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="FirstNameTextBox" MaxLength="100" runat="server" Width="125px" AutoCompleteType="FirstName"
                                            Text='<%# Bind("FirstName") %>'></asp:TextBox></td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="FirstNameRequiredFieldValidator" runat="server" ControlToValidate="FirstNameTextBox"
                                            ErrorMessage="*" ValidationGroup="ViewDetailPanel"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LastNameLabel" runat="server" Text="Label" AssociatedControlID="LastNameTextBox">نام خانوادگي*</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="LastNameTextBox" MaxLength="100" runat="server" Width="125px" AutoCompleteType="LastName"
                                            Text='<%# Bind("LastName") %>'></asp:TextBox></td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="LastNameRequiredFieldValidator" runat="server" ControlToValidate="LastNameTextBox"
                                            ErrorMessage="*" ValidationGroup="ViewDetailPanel"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="GenderLabel" runat="server" Text="Label" AssociatedControlID="GenderDropDownList">جنسيت*</asp:Label></td>
                                    <td>
                                        <asp:DropDownList ID="GenderDropDownList" runat="server" Width="125px" SelectedValue='<%# Bind("Gender") %>'>
                                            <asp:ListItem Selected="True" Value="">لطفا انتخاب کنيد</asp:ListItem>
                                            <asp:ListItem Value="1">مرد</asp:ListItem>
                                            <asp:ListItem Value="2">زن</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="GenderRequiredFieldValidator" runat="server" ControlToValidate="GenderDropDownList"
                                            ErrorMessage="*" ValidationGroup="ViewDetailPanel"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="BirthdayLabel" runat="server" Text="Label" AssociatedControlID="BirthdayPersianDateTextBox">تاريخ تولد (روز/ماه/سال)</asp:Label></td>
                                    <td class="PickerBody">
                                        <pdc:PersianDateTextBox ID="BirthdayPersianDateTextBox" runat="server" IconUrl="~/Images/AjaxControlImages/Calendar.gif"
                                            ShowPickerOnTop="False" Width="125px" DateValue='<%# Bind("Birthday") %>'></pdc:PersianDateTextBox>
                                    </td>
                                    <td>
                                        <pdc:PersianDateValidator ID="BirthdayPersianDateValidator" runat="server" ControlToValidate="BirthdayPersianDateTextBox"
                                            ErrorMessage="تاريخ نامعتبر است." ValidationGroup="ViewDetailPanel"></pdc:PersianDateValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CountryLabel" runat="server" Text="Label" AssociatedControlID="CountryDropDownList">کشور</asp:Label></td>
                                    <td>
                                        <asp:DropDownList ID="CountryDropDownList" runat="server" Width="125px" SelectedValue='<%# Bind("Country") %>'>
                                            <asp:ListItem Selected="True" Value="0">ايران</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ProvinceLabel" runat="server" Text="Label" AssociatedControlID="ProvinceDropDownList">استان (ايران)</asp:Label></td>
                                    <td>
                                        <asp:DropDownList ID="ProvinceDropDownList" runat="server" Width="125px" SelectedValue='<%# Bind("Province") %>'>
                                            <asp:ListItem Value="0">آذربايجان شرقي</asp:ListItem>
                                            <asp:ListItem Value="1">آذربايجان غربي</asp:ListItem>
                                            <asp:ListItem Value="2">اردبيل</asp:ListItem>
                                            <asp:ListItem Value="3">اصفهان</asp:ListItem>
                                            <asp:ListItem Value="4">ايلام</asp:ListItem>
                                            <asp:ListItem Value="5">بوشهر</asp:ListItem>
                                            <asp:ListItem Value="6">تهران</asp:ListItem>
                                            <asp:ListItem Value="7">چهارمحال و بختياري</asp:ListItem>
                                            <asp:ListItem Value="8">خراسان جنوبي</asp:ListItem>
                                            <asp:ListItem Value="9">خراسان رضوي</asp:ListItem>
                                            <asp:ListItem Value="10">خراسان شمالي</asp:ListItem>
                                            <asp:ListItem Value="11">خوزستان</asp:ListItem>
                                            <asp:ListItem Value="12">زنجان</asp:ListItem>
                                            <asp:ListItem Value="13">سمنان</asp:ListItem>
                                            <asp:ListItem Value="14">سيستان و بلوچستان</asp:ListItem>
                                            <asp:ListItem Selected="True" Value="15">فارس</asp:ListItem>
                                            <asp:ListItem Value="16">قزوين</asp:ListItem>
                                            <asp:ListItem Value="17">قم</asp:ListItem>
                                            <asp:ListItem Value="18">کردستان</asp:ListItem>
                                            <asp:ListItem Value="19">کرمان</asp:ListItem>
                                            <asp:ListItem Value="20">کرمانشاه</asp:ListItem>
                                            <asp:ListItem Value="21">کهگيلويه و بويراحمد</asp:ListItem>
                                            <asp:ListItem Value="22">گلستان</asp:ListItem>
                                            <asp:ListItem Value="23">گيلان</asp:ListItem>
                                            <asp:ListItem Value="24">لرستان</asp:ListItem>
                                            <asp:ListItem Value="25">مازندران</asp:ListItem>
                                            <asp:ListItem Value="26">مرکزي</asp:ListItem>
                                            <asp:ListItem Value="27">هرمزگان</asp:ListItem>
                                            <asp:ListItem Value="28">همدان</asp:ListItem>
                                            <asp:ListItem Value="29">يزد</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CityLabel" runat="server" Text="Label" AssociatedControlID="CityTextBox">شهر</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="CityTextBox" MaxLength="100" runat="server" Width="125px" AutoCompleteType="BusinessCity"
                                            Text='<%# Bind("City") %>'></asp:TextBox></td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="AddressLabel" runat="server" Text="Label" AssociatedControlID="AddressTextBox">آدرس</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="AddressTextBox" MaxLength="200" runat="server" Width="125px" TextMode="MultiLine"
                                            Text='<%# Bind("Address") %>' AutoCompleteType="BusinessStreetAddress"></asp:TextBox></td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="ZipCodeLabel" runat="server" Text="Label" AssociatedControlID="ZipCodeTextBox">کد پستي</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ZipCodeTextBox" MaxLength="20" runat="server" Width="125px" AutoCompleteType="BusinessZipCode"
                                            Text='<%# Bind("ZipCode") %>'></asp:TextBox></td>
                                    <td>
                                        <asp:RegularExpressionValidator ValidationGroup="ViewDetailPanel" ID="ZipCodeRegularExpressionValidator"
                                            runat="server" ControlToValidate="ZipCodeTextBox" ErrorMessage="کد پستي نامعتبر است."
                                            ValidationExpression="\d{5}[-]{0,1}\d{5}"></asp:RegularExpressionValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="PhoneLabel" runat="server" Text="Label" AssociatedControlID="PhoneTextBox">تلفن</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="PhoneTextBox" MaxLength="20" runat="server" Width="125px" AutoCompleteType="BusinessPhone"
                                            Text='<%# Bind("Phone") %>'></asp:TextBox></td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="FaxLabel" runat="server" Text="Label" AssociatedControlID="FaxTextBox">فکس</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="FaxTextBox" MaxLength="20" runat="server" Width="125px" AutoCompleteType="BusinessFax"
                                            Text='<%# Bind("Fax") %>'></asp:TextBox></td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="CellularLabel" runat="server" Text="Label" AssociatedControlID="CellularTextBox">تلفن همراه</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="CellularTextBox" MaxLength="20" runat="server" Width="125px" AutoCompleteType="Cellular"
                                            Text='<%# Bind("Cellular") %>'></asp:TextBox></td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="WebsiteLabel" runat="server" Text="Label" AssociatedControlID="WebsiteTextBox">پايگاه اينترنتي</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="WebsiteTextBox" MaxLength="200" runat="server" Width="125px" AutoCompleteType="BusinessUrl"
                                            Text='<%# Bind("Website") %>'></asp:TextBox></td>
                                    <td>
                                        <asp:RegularExpressionValidator ValidationGroup="ViewDetailPanel" ID="WebsiteRegularExpressionValidator"
                                            runat="server" ControlToValidate="WebsiteTextBox" ErrorMessage="پايگاه اينترنتي نامعتبر است."
                                            ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?"></asp:RegularExpressionValidator></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="OfficeLabel" runat="server" Text="Label" AssociatedControlID="OfficeTextBox">نام محل فعاليت شغلي</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="OfficeTextBox" MaxLength="100" runat="server" Width="125px" AutoCompleteType="Office"
                                            Text='<%# Bind("Office") %>'></asp:TextBox></td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="RecommenderLabel" runat="server" Text="Label" AssociatedControlID="RecommenderDropDownList"
                                            Enabled="False">روش آشنايي با اين مارکت</asp:Label></td>
                                    <td>
                                        <asp:DropDownList ID="RecommenderDropDownList" runat="server" Width="125px" Enabled="False"
                                            SelectedValue='<%# Bind("Recommender") %>'>
                                            <asp:ListItem Selected="True" Value="">لطفاً انتخاب کنيد</asp:ListItem>
                                            <asp:ListItem Value="1">تبليغات در سايت‌هاي ديگر</asp:ListItem>
                                            <asp:ListItem Value="2">موتورهاي جستجو</asp:ListItem>
                                            <asp:ListItem Value="3">توصيه دوستان و آشنايان</asp:ListItem>
                                            <asp:ListItem Value="4">تبليغات غيراينترنتي</asp:ListItem>
                                            <asp:ListItem Value="5">گروه بازاريابي اين ‌مارکت</asp:ListItem>
                                            <asp:ListItem Value="6">تبليغات توسط نامه‌هاي ااکترونيکي و PM</asp:ListItem>
                                            <asp:ListItem Value="7">موارد ديگر</asp:ListItem>
                                        </asp:DropDownList>
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
                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="تغيير مشخصات"
                                            OnClick="UpdateButton_Click" ValidationGroup="ViewDetailPanel" />
                                        &nbsp;&nbsp;
                                        <asp:Button ID="DeleteButton" runat="server" Text="حذف" CausesValidation="False"
                                            OnClick="DeleteButton_Click" ValidationGroup="ViewDetailPanel" OnClientClick="javascript: return confirm('آيا واقعا مايل به حذف اين کاربر هستيد؟');" />
                                        &nbsp;&nbsp;
                                        <asp:Button ID="CancelButton" runat="server" UseSubmitBehavior="false" CommandName="Cancel"
                                            Text="انصراف" CausesValidation="False" ValidationGroup="ViewDetailPanel" OnClick="ReturnButton_Click" /></td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </EditItemTemplate>
                </asp:FormView>
                <br />
                <div class="PickerBody">
                    <pdc:PersianDateScriptManager ID="BirthdayPersianDateScriptManager" runat="server"
                        CalendarCSS="PickerCalendarCSS" CalendarDayWidth="25" FooterCSS="PickerFooterCSS"
                        ForbidenCSS="PickerForbidenCSS" FrameCSS="PickerCSS" HeaderCSS="PickerHeaderCSS"
                        SelectedCSS="PickerSelectedCSS" WeekDayCSS="PickerWeekDayCSS" WorkDayCSS="PickerWorkDayCSS"
                        MaxAcceptedYear="1384">
                    </pdc:PersianDateScriptManager>
                </div>
            </asp:View>
            <asp:View ID="ViewDetailConfirmView" runat="server">
                <div class="signupTable">
                    <asp:Label ID="ConfrimViewDetailLabel" runat="server">تغييرات با موفقيت ثبت شد.</asp:Label>
                    <br />
                    <br />
                    <asp:Button ID="ReturnViewButton" runat="server" Text="مشاهده مجدد تغييرات" OnClick="ReturnViewButton_Click" />
                    &nbsp;<br />
                    &nbsp;
                </div>
            </asp:View>
            <asp:View ID="ViewDetailConfirmDeleteView" runat="server">
                <div class="signupTable">
                    <asp:Label ID="ConfrimDeleteViewDetailLabel" runat="server">کاربر مورد نظر با موفقيت حذف شد.</asp:Label>
                    <br />
                    <br />
                    <asp:Button ID="ConfirmDeleteReturnButton" runat="server" Text="بازگشت به صفحه قبل"
                        OnClick="ReturnButton_Click" />
                    &nbsp;<br />
                    &nbsp;
                </div>
            </asp:View>
            <asp:View ID="ViewDetailErrorIDView" runat="server">
                <div class="signupTable">
                    <asp:Label ID="ViewDetailErrorIDLabel" runat="server" Visible='<%# !String.IsNullOrEmpty(Request.QueryString["UserID"]) %>'>هيچ کاربري با نام [<%= Request["UserID"] %>] پيدا نشد.</asp:Label>
                    <asp:Label ID="ViewDetailNoIDLabel" runat="server" Visible='<%# String.IsNullOrEmpty(Request.QueryString["UserID"]) %>'>هيچ کاربري انتخاب نشده است.</asp:Label>
                    <br />
                    <br />
                    <asp:Button ID="ConfirmErrorReturnButton" runat="server" Text="بازگشت به صفحه قبل"
                        OnClick="ReturnButton_Click" />
                    &nbsp;<br />
                    &nbsp;
                </div>
            </asp:View>
        </asp:MultiView>
        <br />
        <asp:SqlDataSource ID="ViewDetailSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
            SelectCommand="SELECT * FROM [Account] WHERE [Username]=@Username" DeleteCommand="DELETE FROM [Account] WHERE [Username] = @Username"
            UpdateCommand="UPDATE [Account] SET [Password]=@Password, [Email] = @Email, [UserType] = @UserType, [FirstName] = @FirstName, [LastName] = @LastName, [Gender] = @Gender, [Birthday] = @Birthday, [Country] = @Country, [Province] = @Province, [City] = @City, [Address] = @Address, [ZipCode] = @ZipCode, [Phone] = @Phone, [Fax] = @Fax, [Cellular] = @Cellular, [Website] = @Website, [Office] = @Office WHERE [Username] = @Username">
            <SelectParameters>
                <asp:QueryStringParameter Name="Username" QueryStringField="UserID" />
            </SelectParameters>
            <DeleteParameters>
                <asp:QueryStringParameter Name="Username" QueryStringField="UserID" />
            </DeleteParameters>
        </asp:SqlDataSource>
        &nbsp;
        <br />
    </div>
</asp:Content>

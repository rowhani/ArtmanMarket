<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Signup.aspx.cs" Inherits="Page_User_Signup" Title="عضويت در اين سايت"
    ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register Assembly="PersianDateControls 2.0" Namespace="PersianDateControls" TagPrefix="pdc" %>
<%@ Register Assembly="MSCaptcha" Namespace="MSCaptcha" TagPrefix="msc" %>
<asp:Content ID="MasterHeadContent" ContentPlaceHolderID="HeadContentPlaceHolder"
    runat="Server">
    <link href="<%= ResolveUrl("~/StyleSheets/PersianCalendarStyles.css") %>" rel="stylesheet"
        type="text/css" />
</asp:Content>
<asp:Content ID="SignupContent" ContentPlaceHolderID="MasterContentPlaceHolder" runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            عضويت در سايت</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <div class="signupTable">
            <asp:MultiView ID="SignupMultiView" runat="server" ActiveViewIndex="0">
                <asp:View ID="SignupFormView" runat="server">
                    <asp:FormView ID="CreateUserBindFormView" runat="server" HorizontalAlign="Right"
                        DefaultMode="Insert" DataSourceID="CreateUserSqlDataSource" OnItemInserting="CreateUserBindFormView_ItemInserting">
                        <InsertItemTemplate>
                            <asp:Panel ID="SignupPanel" runat="server" DefaultButton="CreateUserButton">
                                <table cellspacing="2px">
                                    <tr>
                                        <td colspan="3">
                                            <b>لطفاً براي عضو شدن فرم زير را پر کنيد.</b></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <b>مواردي که با علامت * مشخص شده‌اند را حتماً وارد کنيد.</b></td>
                                    </tr>
                                </table>
                                <br />
                                <asp:Panel ID="CreateUserHeaderPanel" runat="server" Height="30px" Width="540px"
                                    CssClass="collapsePanelHeader">
                                    <div style="padding: 5px; cursor: pointer; vertical-align: middle;">
                                        <div style="float: right;">
                                            ايجاد کاربر جديد
                                        </div>
                                        <div style="float: right; margin-right: 20px;">
                                            <asp:Label ID="CreateUserHeaderLabel" runat="server" Text="Label"></asp:Label>
                                        </div>
                                        <div style="float: left; vertical-align: middle;">
                                            <asp:Image ID="CreateUserHeaderImage" runat="server" />
                                        </div>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="CreateUserPanel" runat="server" CssClass="collapsePanel">
                                    <table cellspacing="2px">
                                        <tr>
                                            <td colspan="3">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="151px">
                                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserNameTextBox">نام کاربري*</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="UserNameTextBox" runat="server" Width="125px" AutoCompleteType="DisplayName"
                                                    Text='<%# Bind("Username") %>' MaxLength="100"></asp:TextBox></td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="UserNameRequiredFieldValidator" runat="server" ControlToValidate="UserNameTextBox"
                                                    ErrorMessage="*" ValidationGroup="SignupPanel"></asp:RequiredFieldValidator>
                                                <asp:CustomValidator ID="UserNameCustomValidator" runat="server" ControlToValidate="UserNameTextBox"
                                                    ErrorMessage="اين نام قبلا اشغال شده است." ValidationGroup="SignupPanel" OnServerValidate="UserNameCustomValidator_ServerValidate"></asp:CustomValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PasswordLabel" runat="server" Text="Label" AssociatedControlID="PasswordTextBox">کلمه عبور*</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" Width="125px"
                                                    Text='<%# Bind("Password") %>'></asp:TextBox></td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="PasswordRequiredFieldValidator" ValidationGroup="SignupPanel"
                                                    runat="server" ControlToValidate="PasswordTextBox" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="PasswordRegularExpressionValidator" runat="server"
                                                    ControlToValidate="PasswordTextBox" ErrorMessage="کلمه عبور بايد حداقل 6 کاراکتر باشد."
                                                    ValidationGroup="SignupPanel" ValidationExpression=".{6,}"></asp:RegularExpressionValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="ConfirmPasswordLabel" runat="server" Text="Label" AssociatedControlID="ConfirmPasswordTextBox">تاييد کلمه عبور*</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="ConfirmPasswordTextBox" runat="server" TextMode="Password" Width="125px"></asp:TextBox></td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequiredFieldValidator" runat="server"
                                                    ControlToValidate="ConfirmPasswordTextBox" ValidationGroup="SignupPanel" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="PasswordCompareValidator" runat="server" ControlToCompare="PasswordTextBox"
                                                    ControlToValidate="ConfirmPasswordTextBox" ValidationGroup="SignupPanel" ErrorMessage="کلمه عبور و تاييد آن با هم برابر نيستند."></asp:CompareValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="EmailLabel" runat="server" Text="Label" AssociatedControlID="EmailTextBox">پست الکترونيکي*</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="EmailTextBox" runat="server" Width="125px" MaxLength="100" AutoCompleteType="Email"
                                                    Text='<%# Bind("Email") %>'></asp:TextBox></td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="EmailRequiredFieldValidator" runat="server" ControlToValidate="EmailTextBox"
                                                    ErrorMessage="*" ValidationGroup="SignupPanel"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="EmailRegularExpressionValidator" runat="server"
                                                    ControlToValidate="EmailTextBox" ValidationGroup="SignupPanel" ErrorMessage="ايميل نا معتبر است."
                                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <ajax:CollapsiblePanelExtender ID="CreateUserCollapsiblePanel" runat="Server" TargetControlID="CreateUserPanel"
                                    CollapsedSize="0" Collapsed="False" ExpandControlID="CreateUserHeaderPanel" CollapseControlID="CreateUserHeaderPanel"
                                    AutoCollapse="False" AutoExpand="False" ScrollContents="False" TextLabelID="CreateUserHeaderLabel"
                                    CollapsedText="(نمايش جزئيات...)" ExpandedText="(مخفي کردن جزئيات)" ImageControlID="CreateUserHeaderImage"
                                    ExpandedImage="~/Images/AjaxControlImages/collapse.jpg" CollapsedImage="~/Images/AjaxControlImages/expand.jpg"
                                    ExpandDirection="Vertical" />
                                <br />
                                <asp:Panel ID="UserProfileHeaderPanel" runat="server" Height="30px" Width="540px"
                                    CssClass="collapsePanelHeader">
                                    <div style="padding: 5px; cursor: pointer; vertical-align: middle;">
                                        <div style="float: right;">
                                            مشخصات کاربر
                                        </div>
                                        <div style="float: right; margin-right: 20px;">
                                            <asp:Label ID="UserProfileHeaderLabel" runat="server" Text="Label"></asp:Label>
                                        </div>
                                        <div style="float: left; vertical-align: middle;">
                                            <asp:Image ID="UserProfileHeaderImage" runat="server" />
                                        </div>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="UserProfilePanel" runat="server" CssClass="collapsePanel">
                                    <table cellspacing="2px">
                                        <tr>
                                            <td colspan="3">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="151px">
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
                                                <asp:RequiredFieldValidator ValidationGroup="SignupPanel" ID="UserTypeRequiredFieldValidator"
                                                    runat="server" ControlToValidate="UserTypeDropDownList" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="FirstNameLabel" runat="server" Text="Label" AssociatedControlID="FirstNameTextBox">نام*</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="FirstNameTextBox" runat="server" MaxLength="100" Width="125px" AutoCompleteType="FirstName"
                                                    Text='<%# Bind("FirstName") %>'></asp:TextBox></td>
                                            <td>
                                                <asp:RequiredFieldValidator ValidationGroup="SignupPanel" ID="FirstNameRequiredFieldValidator"
                                                    runat="server" ControlToValidate="FirstNameTextBox" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="LastNameLabel" runat="server" Text="Label" AssociatedControlID="LastNameTextBox">نام خانوادگي*</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="LastNameTextBox" runat="server" MaxLength="100" Width="125px" AutoCompleteType="LastName"
                                                    Text='<%# Bind("LastName") %>'></asp:TextBox></td>
                                            <td>
                                                <asp:RequiredFieldValidator ValidationGroup="SignupPanel" ID="LastNameRequiredFieldValidator"
                                                    runat="server" ControlToValidate="LastNameTextBox" ErrorMessage="*"></asp:RequiredFieldValidator></td>
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
                                                    ErrorMessage="*" ValidationGroup="SignupPanel"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="BirthdayLabel" runat="server" Text="Label" AssociatedControlID="BirthdayPersianDateTextBox">تاريخ تولد (روز/ماه/سال)</asp:Label></td>
                                            <td class="PickerBody">
                                                <pdc:PersianDateTextBox ID="BirthdayPersianDateTextBox" runat="server" IconUrl="~/Images/AjaxControlImages/Calendar.gif"
                                                    ShowPickerOnTop="False" Width="125px" DateValue='<%# Bind("Birthday") %>'></pdc:PersianDateTextBox>
                                            </td>
                                            <td>
                                                <pdc:PersianDateValidator ValidationGroup="SignupPanel" ID="BirthdayPersianDateValidator"
                                                    runat="server" ControlToValidate="BirthdayPersianDateTextBox" ErrorMessage="تاريخ نامعتبر است."></pdc:PersianDateValidator>
                                            </td>
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
                                                <asp:TextBox ID="CityTextBox" runat="server" Width="125px" MaxLength="100" AutoCompleteType="BusinessCity"
                                                    Text='<%# Bind("City") %>'></asp:TextBox></td>
                                            <td>
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="AddressLabel" runat="server" Text="Label" AssociatedControlID="AddressTextBox">آدرس</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="AddressTextBox" runat="server" MaxLength="200" Width="125px" TextMode="MultiLine"
                                                    AutoCompleteType="BusinessStreetAddress" Text='<%# Bind("Address") %>'></asp:TextBox></td>
                                            <td>
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="ZipCodeLabel" runat="server" Text="Label" AssociatedControlID="ZipCodeTextBox">کد پستي</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="ZipCodeTextBox" runat="server" MaxLength="20" Width="125px" AutoCompleteType="BusinessZipCode"
                                                    Text='<%# Bind("ZipCode") %>'></asp:TextBox></td>
                                            <td>
                                                <asp:RegularExpressionValidator ValidationGroup="SignupPanel" ID="ZipCodeRegularExpressionValidator"
                                                    runat="server" ControlToValidate="ZipCodeTextBox" ErrorMessage="کد پستي نامعتبر است."
                                                    ValidationExpression="\d{5}[-]{0,1}\d{5}"></asp:RegularExpressionValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PhoneLabel" runat="server" Text="Label" AssociatedControlID="PhoneTextBox">تلفن</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="PhoneTextBox" runat="server" MaxLength="20" Width="125px" AutoCompleteType="BusinessPhone"
                                                    Text='<%# Bind("Phone") %>'></asp:TextBox></td>
                                            <td>
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="FaxLabel" runat="server" Text="Label" AssociatedControlID="FaxTextBox">فکس</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="FaxTextBox" runat="server" Width="125px" MaxLength="20" AutoCompleteType="BusinessFax"
                                                    Text='<%# Bind("Fax") %>'></asp:TextBox></td>
                                            <td>
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="CellularLabel" runat="server" Text="Label" AssociatedControlID="CellularTextBox">تلفن همراه</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="CellularTextBox" runat="server" Width="125px" MaxLength="20" AutoCompleteType="Cellular"
                                                    Text='<%# Bind("Cellular") %>'></asp:TextBox></td>
                                            <td>
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="WebsiteLabel" runat="server" Text="Label" AssociatedControlID="WebsiteTextBox">پايگاه اينترنتي</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="WebsiteTextBox" runat="server" Width="125px" MaxLength="200" AutoCompleteType="BusinessUrl"
                                                    Text='<%# Bind("Website") %>'></asp:TextBox></td>
                                            <td>
                                                <asp:RegularExpressionValidator ValidationGroup="SignupPanel" ID="WebsiteRegularExpressionValidator"
                                                    runat="server" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?"
                                                    ControlToValidate="WebsiteTextBox" ErrorMessage="پايگاه اينترنتي نامعتبر است."></asp:RegularExpressionValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="OfficeLabel" runat="server" Text="Label" AssociatedControlID="OfficeTextBox">نام محل فعاليت شغلي</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="OfficeTextBox" runat="server" Width="125px" MaxLength="100" AutoCompleteType="Office"
                                                    Text='<%# Bind("Office") %>'></asp:TextBox></td>
                                            <td>
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="RecommenderLabel" runat="server" Text="Label" AssociatedControlID="RecommenderDropDownList">روش آشنايي با اين مارکت*</asp:Label></td>
                                            <td>
                                                <asp:DropDownList ID="RecommenderDropDownList" runat="server" Width="125px" SelectedValue='<%# Bind("Recommender") %>'>
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
                                                <asp:RequiredFieldValidator ValidationGroup="SignupPanel" ID="RecommenderRequiredFieldValidator"
                                                    runat="server" ControlToValidate="RecommenderDropDownList" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="CaptchaLabel" runat="server" Text="Label" AssociatedControlID="CaptchaTextBox">متن تصوير را وارد نماييد*</asp:Label></td>
                                            <td>
                                                <msc:CaptchaControl ID="SignupCaptchaControl" runat="server" CaptchaChars="ACDEFGHJKLNPQRTUVXYZ2346789"
                                                    CaptchaFont="Tahoma" CaptchaLength="6" CaptchaLineNoise="Medium" FontColor="Navy"
                                                    LineColor="DarkBlue" NoiseColor="Black" CaptchaBackgroundNoise="Medium" CaptchaFontWarping="None"
                                                    CaptchaWidth="125"></msc:CaptchaControl>
                                                <br />
                                                <asp:TextBox ID="CaptchaTextBox" runat="server" MaxLength="6" Width="125px" EnableViewState="false"></asp:TextBox></td>
                                            <td>
                                                <asp:RequiredFieldValidator ValidationGroup="SignupPanel" ID="CaptchaRequiredFieldValidator"
                                                    runat="server" ControlToValidate="CaptchaTextBox" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                <asp:CustomValidator ValidationGroup="SignupPanel" ID="CaptchaCustomValidator" runat="server"
                                                    ControlToValidate="CaptchaTextBox" ErrorMessage="متن تصوير اشتباه وارد شده است."
                                                    OnServerValidate="CaptchaCustomValidator_ServerValidate"></asp:CustomValidator></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </asp:Panel>
                            <ajax:CollapsiblePanelExtender ID="UserProfileCollapsiblePanel" runat="Server" TargetControlID="UserProfilePanel"
                                CollapsedSize="0" Collapsed="False" ExpandControlID="UserProfileHeaderPanel"
                                CollapseControlID="UserProfileHeaderPanel" AutoCollapse="False" AutoExpand="False"
                                ScrollContents="False" TextLabelID="UserProfileHeaderLabel" CollapsedText="(نمايش جزئيات...)"
                                ExpandedText="(مخفي کردن جزئيات)" ImageControlID="UserProfileHeaderImage" ExpandedImage="~/Images/AjaxControlImages/collapse.jpg"
                                CollapsedImage="~/Images/AjaxControlImages/expand.jpg" ExpandDirection="Vertical" />
                            <br />
                            <asp:Button ID="CreateUserButton" runat="server" CommandName="Insert" Text="ساخت کاربر"
                                OnClick="CreateUserButton_Click" ValidationGroup="SignupPanel" />
                        </InsertItemTemplate>
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
                <asp:View ID="SignupConfirmView" runat="server">
                    <div class="signupTable">
                        <asp:Label Font-Size="small" ID="ConfrimSignupLabel" runat="server">حساب کاربري شما با موفقيت ثبت شد.</asp:Label>
                        <br />
                        <br />
                        <asp:Button ID="ReturnSignupButton" runat="server" Text="بازگشت به صفحه قبل" OnClick="ReturnSignupButton_Click" />
                        &nbsp;<br />
                        &nbsp;
                    </div>
                </asp:View>
            </asp:MultiView>
            <asp:SqlDataSource ID="CreateUserSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
                SelectCommand="SELECT * FROM [Account]" InsertCommand="INSERT INTO [Account] ([Username], [Password], [Email], [UserType], [FirstName], [LastName], [Gender], [Birthday], [Country], [Province], [City], [Address], [ZipCode], [Phone], [Fax], [Cellular], [Website], [Office], [Recommender]) VALUES (@Username, @Password, @Email, @UserType, @FirstName, @LastName, @Gender, @Birthday, @Country, @Province, @City, @Address, @ZipCode, @Phone, @Fax, @Cellular, @Website, @Office, @Recommender)">
            </asp:SqlDataSource>
        </div>
        &nbsp;
        <br />
    </div>
</asp:Content>

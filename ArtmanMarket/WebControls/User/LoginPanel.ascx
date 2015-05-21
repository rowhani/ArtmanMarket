<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoginPanel.ascx.cs" Inherits="WebControls_User_LoginPanel" %>
<link href="~/StyleSheets/ControlStyles.css" rel="stylesheet" type="text/css" />
<asp:MultiView ID="LoginMultiView" runat="server" ActiveViewIndex="0">
    <asp:View ID="LoginPanelView" runat="server">
        <asp:Panel ID="LoginPanel" runat="server" Width="200" DefaultButton="LoginButton">
            <asp:Image ID="LoginLogoImage" runat="server" Style="margin-right: 1px" Width="200"
                ImageUrl="~/Images/AccountControlImage/LoginLogo.gif"></asp:Image>
            <table class="loginTable" bgcolor="white">
                <tr align="right">
                    <td style="width: 70px">
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserNameTextBox">نام کاربر&nbsp;&nbsp;</asp:Label></td>
                    <td style="width: 130px">
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserNameTextBox"
                            ErrorMessage="وارد کردن نام کاربر الزامي است." ToolTip=".نام کاربر را وارد نماييد"
                            ValidationGroup='<%# this.ClientID + "LoginPanel" %>'>*</asp:RequiredFieldValidator>
                        <asp:TextBox ID="UserNameTextBox" runat="server" Width="100px" MaxLength="100"></asp:TextBox></td>
                </tr>
                <tr align="right">
                    <td style="width: 70px">
                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="PasswordTextBox">کلمه عبور&nbsp;&nbsp;</asp:Label></td>
                    <td style="width: 130px">
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="PasswordTextBox"
                            ErrorMessage="وارد کردن کلمه عبور الزامي است." ToolTip="کلمه عبور را وارد نماييد"
                            ValidationGroup='<%# this.ClientID + "LoginPanel" %>'>*</asp:RequiredFieldValidator>
                        <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" Width="100px"></asp:TextBox></td>
                </tr>
                <tr align="right">
                    <td colspan="2">
                        <asp:CheckBox ID="RememberMeCheckBox" runat="server" Text="من را به خاطر بسپار" />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2" style="color: red">
                        <asp:CustomValidator ID="LoginCustomValidator" ValidationGroup='<%# this.ClientID + "LoginPanel" %>'
                            runat="server" ErrorMessage="کلمه عبور يا نام کاربر اشتباه است." ControlToValidate="UserNameTextBox"
                            OnServerValidate="LoginCustomValidator_ServerValidate"></asp:CustomValidator></td>
                </tr>
                <tr>
                    <td align="left" colspan="2" style="height: 30px">
                        &nbsp;&nbsp;<asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="ورود"
                            BackColor="#547EB4" ForeColor="#FFFFFF" Width="60px" Font-Bold="False" Font-Names="Tahoma"
                            Height="25px" ValidationGroup='<%# this.ClientID + "LoginPanel" %>' />
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2">
                        <table style="width: 150px">
                            <tr>
                                <td align="right">
                                    <asp:Image ID="SignupLogoImage" runat="server" ImageUrl="~/Images/AccountControlImage/JoinLogo.gif" />
                                </td>
                                <td align="right">
                                    <asp:HyperLink ID="SignupHyperLink" runat="server" Style="vertical-align: middle"
                                        NavigateUrl="~/Page/User/Signup.aspx">عضويت در سايت</asp:HyperLink>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Literal ID="SignoutLiteral" runat="server" Visible="false" EnableViewState="False"><b>شما با موفقيت خارج شديد.</b></asp:Literal></td>
                </tr>
            </table>
        </asp:Panel>
    </asp:View>
    <asp:View ID="LoginViewPanelView" runat="server">
        <asp:Panel ID="LoginViewPanel" runat="server" Direction="RightToLeft" Height="50px"
            HorizontalAlign="Right" Width="200px">
            <asp:Image ID="LoginLogoImage2" runat="server" Style="margin-right: 1px" Width="200"
                ImageUrl="~/Images/AccountControlImage/LoginLogo.gif"></asp:Image>
            <table class="loginTable" bgcolor="white">
                <tr>
                    <td>
                        <center>
                            خوش آمديد
                            <asp:LoginName ID="UserLoginName" runat="server" FormatString="{0}" Font-Bold="true" />
                            [<asp:LoginStatus ID="UserLoginStatus" runat="server" LoginText="ورود" LogoutAction="Redirect"
                                LogoutPageUrl="~/Default.aspx" LogoutText="خروج" OnLoggingOut="UserLoginStatus_LoggingOut" />
                            ]
                        </center>
                        <br />
                        <asp:HyperLink ID="ChangePasswordHyperLink" runat="server" NavigateUrl='<%# Page.ResolveUrl("~/Page/User/ChangePassword.aspx") + "?ReturnUrl=" + Request.Url.PathAndQuery %>'>تغيير کلمه‌ي عبور</asp:HyperLink>
                        <br />
                        <asp:HyperLink ID="UserProfileHyperLink" runat="server" NavigateUrl='<%# Page.ResolveUrl("~/Page/User/UpdateProfile.aspx") + "?ReturnUrl=" + Request.Url.PathAndQuery %>'>تغيير مشخصات</asp:HyperLink>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <br />
        <br />
    </asp:View>
</asp:MultiView>

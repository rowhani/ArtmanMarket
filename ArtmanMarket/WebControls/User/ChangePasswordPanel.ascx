<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChangePasswordPanel.ascx.cs"
    Inherits="WebControls_User_ChangePasswordPanel" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<link href="~/StyleSheets/ControlStyles.css" rel="stylesheet" type="text/css" />
<link href="~/StyleSheets/AjaxControlStyles.css" rel="stylesheet" type="text/css" />
<asp:MultiView ID="ChangePasswordMultiView" runat="server" ActiveViewIndex="0">
    <asp:View ID="ChangePasswordFormView" runat="server">
        <asp:Panel ID="ChangePasswordPanel" runat="server" DefaultButton="ChangePasswordButton">
            <table class="signupTable">
                <tr>
                    <td width="128px">
                        <asp:Label ID="CurrentPasswordLabel" runat="server" Text="Label" AssociatedControlID="CurrentPasswordTextBox">کلمه عبور جاري*</asp:Label></td>
                    <td>
                        <asp:TextBox ID="CurrentPasswordTextBox" runat="server" Width="150px" TextMode="Password"></asp:TextBox></td>
                    <td>
                        <asp:RequiredFieldValidator ID="CurrentPasswordRequiredFieldValidator" runat="server"
                            ControlToValidate="CurrentPasswordTextBox" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="CurrentPasswordCustomValidator" runat="server" ErrorMessage="کلمه عبور اشتباه وارد شده است."
                            OnServerValidate="CurrentPasswordCustomValidator_ServerValidate" ControlToValidate="CurrentPasswordTextBox"></asp:CustomValidator></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="NewPasswordLabel" runat="server" Text="Label" AssociatedControlID="NewPasswordTextBox">کلمه عبور جديد*</asp:Label></td>
                    <td>
                        <asp:TextBox ID="NewPasswordTextBox" runat="server" Width="150px" TextMode="Password"></asp:TextBox></td>
                    <td>
                        <asp:RequiredFieldValidator ID="NewPasswordRequiredFieldValidator" runat="server"
                            ControlToValidate="NewPasswordTextBox" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="NewPasswordRegularExpressionValidator" runat="server"
                            ControlToValidate="NewPasswordTextBox" ErrorMessage="کلمه عبور بايد حداقل 6 کاراکتر باشد"
                            ValidationExpression=".{6,}"></asp:RegularExpressionValidator>
                        <ajax:PasswordStrength ID="NewPasswordStrength" runat="server" TargetControlID="NewPasswordTextBox"
                            DisplayPosition="leftside" StrengthIndicatorType="Text" PreferredPasswordLength="16"
                            PrefixText="قدرت: " TextCssClass="TextIndicator_TextBox1" RequiresUpperAndLowerCaseCharacters="false"
                            TextStrengthDescriptions="خيلي ضعيف;ضعيف;متوسط;قوي;عالي" StrengthStyles="TextIndicator_TextBox1_Strength1;TextIndicator_TextBox1_Strength2;TextIndicator_TextBox1_Strength3;TextIndicator_TextBox1_Strength4;TextIndicator_TextBox1_Strength5"
                            CalculationWeightings="50;15;15;20" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="ConfirmNewPasswordLabel" runat="server" Text="Label" AssociatedControlID="ConfirmNewPasswordTextBox">تاييد کلمه عبور جديد*</asp:Label></td>
                    <td>
                        <asp:TextBox ID="ConfirmNewPasswordTextBox" runat="server" Width="150px" TextMode="Password"></asp:TextBox></td>
                    <td>
                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequiredFieldValidator" runat="server"
                            ControlToValidate="ConfirmNewPasswordTextBox" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="ConfirmNewPasswordCompareValidator" runat="server" ControlToCompare="NewPasswordTextBox"
                            ControlToValidate="ConfirmNewPasswordTextBox" ErrorMessage="کلمه عبور جديد و تاييد آن با هم برابر نيستند."></asp:CompareValidator></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:CompareValidator ID="NewPasswordCompareValidator" runat="server" ControlToCompare="CurrentPasswordTextBox"
                            ControlToValidate="NewPasswordTextBox" ErrorMessage="کلمه عبور جاري و جديد نبايد با هم برابر باشند."
                            Operator="NotEqual"></asp:CompareValidator>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Button ID="ChangePasswordButton" runat="server" CommandName="submit" Text="تغيير کلمه عبور"
                            OnClick="ChangePasswordButton_Click" />&nbsp;
                        <asp:Button ID="CancelButton" runat="server" UseSubmitBehavior="false" CommandName="cancel"
                            Text="انصراف" CausesValidation="False" OnClick="CancelButton_Click" /></td>
                </tr>
            </table>
        </asp:Panel>
    </asp:View>
    <asp:View ID="ChangePasswordConfirmView" runat="server">
        <div class="signupTable">
            <asp:Label ID="ConfrimSignupLabel" runat="server">رمز ورود با موفقيت تغيير يافت.</asp:Label>
            <br />
            <br />
            <asp:Button ID="ReturnChangePasswordButton" runat="server" Text="صفحه قبل" OnClick="ReturnChangePasswordButton_Click" />
            <br />
        </div>
    </asp:View>
</asp:MultiView>
&nbsp; 
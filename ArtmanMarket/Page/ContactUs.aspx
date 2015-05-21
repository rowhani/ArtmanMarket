<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ContactUs.aspx.cs" Inherits="Page_ContactUs" Title="تماس با ما" ErrorPage="~/Page/Errors/Error500.htm" %>

<asp:Content ID="ContactUsContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: gray">
            تماس با ما</h3>
        <hr style="border-top: 1px dashed Gray; font-size: 12pt;" />
        <center>
            <asp:Label ID="InfoLabel" runat="server" Font-Bold="True" Style="text-align: center"></asp:Label>
        </center>
        <br />
        <span style="color: #0000ff; font-family: Tahoma; font-weight: bold; font-size: 12pt;">
            شما مي توانيد از طريق تلفن يا ايميل با مدير سايت تماس برقرار کنيد.</span>
        <br />
        <br />
        <br />
        <strong><span style="font-size: 11pt"><span style="font-family: Tahoma"><span>تلفن تماس
            : 09171888432
            <br />
        </span>آدرس ايميل : artmanmarket@gmail.com</span></span></strong>
        <br />
        <br />
        <br />
        &nbsp;<span style="color: #990099"> <strong>براي ما پيام بفرستيد:</strong>
            <br />
        </span>
        <br />
        <asp:Panel ID="ContactUsPanel" runat="server" DefaultButton="SendButton">
            <table cellspacing="5px" class="signupTable">
                <tr>
                    <td>
                        <asp:Label ID="NameLabel" runat="server" Text="نام شما:" AssociatedControlID="NameTextBox"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="NameTextBox" MaxLength="100" runat="server" Width="250px" AutoCompleteType="DisplayName"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server"
                            ErrorMessage="*" ControlToValidate="NameTextBox"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td width="135px">
                        <asp:Label ID="EmailLabel" runat="server" Text="آدرس ايميل شما:" AssociatedControlID="EmailTextBox"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="EmailTextBox" MaxLength="200" runat="server" Width="250px" AutoCompleteType="email"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="EmailRequiredFieldValidator" runat="server"
                            ErrorMessage="*" ControlToValidate="EmailTextBox"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="EmailRegularExpressionValidator" runat="server"
                            ErrorMessage="آدرس ايميل نامعتبر" ControlToValidate="EmailTextBox" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="SubjectLabel" runat="server" Text="عنوان:" AssociatedControlID="SubjectTextBox"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="SubjectTextBox" MaxLength="300" runat="server" Width="250px"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="SubjectRequiredFieldValidator" runat="server"
                            ErrorMessage="*" ControlToValidate="SubjectTextBox"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="BodyLabel" runat="server" Text="متن:" AssociatedControlID="BodyTextBox"></asp:Label>
                        &nbsp;<asp:RequiredFieldValidator ID="BodyRequiredFieldValidator" runat="server"
                            ErrorMessage="*" ControlToValidate="BodyTextBox"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:TextBox ID="BodyTextBox" runat="server" Width="525px" MaxLength="2000" Rows="10"
                            TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="SendButton" runat="server" Text="ارسال" OnClick="SendButton_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
    </div>
</asp:Content>

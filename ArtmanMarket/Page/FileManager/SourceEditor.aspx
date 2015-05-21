<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SourceEditor.aspx.cs" Inherits="Page_FileManager_SourceEditor"
    ValidateRequest="false" MaintainScrollPositionOnPostback="true" ErrorPage="~/Page/Errors/Error500.htm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ويرايش فايل</title>
</head>
<body background='<%= Page.ResolveUrl("~/Images/Misc/Background2.gif") %>'>
    <form id="form1" runat="server">
        <div style="direction: rtl; text-align: right">
            <h3 class="signupTable" style="color: Gray; font-family: Tahoma; font-size: small">
                ويرايش فايل</h3>
            <hr style="border-top: 1px dashed Gray;" />
            <asp:HyperLink ID="BackToHomeHyperLink" runat="server" NavigateUrl="~/" Style="float: left">برگشت به صفحه اصلي</asp:HyperLink>
            <br />
            <br />
            <center>
                <asp:Panel ID="SourceEditorPanel" runat="server" Font-Names="Tahoma" GroupingText="ويرايش محتوا"
                    Width="100%" Height="100%" DefaultButton="SaveSourceButton">
                    <br />
                    <asp:Panel ID="InfoPanel" runat="server" Visible="false">
                        <asp:Label ID="InfoLabel" runat="server" Style="font-family: Tahoma; font-size: smaller;
                            font-weight: bold; direction: rtl" ForeColor="MediumSeaGreen" Text="تغييرات با موفقيت ذخيره شد."></asp:Label>
                        <br />
                        <br />
                    </asp:Panel>
                    <asp:TextBox ID="SourceEditorTextBox" runat="server" TextMode="multiline" Style="direction: ltr;
                        text-align: left; width: 100%; height: 100%; margin: 0; padding: 0" Font-Names="Courier New"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Button ID="ViewSourceButton" runat="server" Text="مشاهده در حالت قالب بندي شده"
                        Font-Names="Tahoma" OnClick="ViewSourceButton_Click" />
                    <asp:Button ID="SaveSourceButton" runat="server" Text="ذخيره" OnClick="SaveSourceButton_Click"
                        Font-Names="Tahoma" />
                    <br />
                    <br />
                </asp:Panel>
                <asp:Label ID="ErrorLabel" runat="server" Style="font-family: Tahoma; font-size: smaller;
                    font-weight: bold; direction: rtl" Visible="false"></asp:Label>
            </center>
            &nbsp;
        </div>
    </form>
</body>
</html>

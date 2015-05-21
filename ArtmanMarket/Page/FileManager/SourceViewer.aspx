<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SourceViewer.aspx.cs" Inherits="Page_FileManager_SourceViewer"
    ValidateRequest="false" MaintainScrollPositionOnPostback="true" ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Assembly="ActiproSoftware.CodeHighlighter.Net20" Namespace="ActiproSoftware.CodeHighlighter"
    TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>مشاهده فايل</title>
</head>
<body background='<%= Page.ResolveUrl("~/Images/Misc/Background2.gif") %>'>
    <form id="form1" runat="server">
        <div style="direction: rtl; text-align: right">
            <h3 class="signupTable" style="color: Gray; font-family: Tahoma; font-size: small">
                مشاهده فايل</h3>
            <hr style="border-top: 1px dashed Gray;" />
            <asp:HyperLink ID="BackToHomeHyperLink" runat="server" NavigateUrl="~/" Style="float: left">برگشت به صفحه اصلي</asp:HyperLink>
            <br />
            <br />
            <center>
                <asp:Panel ID="SourceEditorPanel" Font-Names="Tahoma" runat="server" GroupingText="مشاهده محتوا"
                    Width="100%" Height="100%" DefaultButton="SaveSourceButton">
                    <br />
                    <asp:Panel ID="InfoPanel" runat="server" Visible="false">
                        <asp:Label ID="InfoLabel" runat="server" Style="font-family: Tahoma; font-size: smaller;
                            font-weight: bold; direction: rtl" ForeColor="MediumSeaGreen" Text="تغييرات با موفقيت ذخيره شد."></asp:Label>
                        <br />
                        <br />
                    </asp:Panel>
                    <div style="direction: ltr; text-align: left; width: 100%; height: 100%; margin: 0;
                        padding: 0; border: groove 1px silver; background-color: White">
                        <pre><cc1:CodeHighlighter ID="SourceViewerCodeHighlighter" runat="server" EnableViewState="true">
                        </cc1:CodeHighlighter></pre>
                    </div>
                    <br />
                    <asp:Button ID="BackToEditorButton" runat="server" Text="برگشت به ويرايشگر" Font-Names="Tahoma"
                        OnClick="BackToEditorButton_Click" />
                    <asp:Button ID="SaveSourceButton" runat="server" Text="ذخيره" Font-Names="Tahoma"
                        OnClick="SaveSourceButton_Click" />
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

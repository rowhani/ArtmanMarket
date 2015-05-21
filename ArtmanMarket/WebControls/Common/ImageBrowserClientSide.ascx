<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ImageBrowserClientSide.ascx.cs"
    Inherits="WebControls_Common_ImageBrowserClientSide" ClassName="ImageBrowserClientSide" %>
<%@ Register Assembly="CKFinder" Namespace="CKFinder" TagPrefix="CKFinder" %>
<link href="~/StyleSheets/ControlStyles.css" rel="stylesheet" type="text/css" />
<center>
    <div class="signupTable">
        <asp:Panel ID="ImageBrowserPopupPanel" runat="server" Style="visibility: hidden">
            <div id="ImageBrowserBackgroundFilter">
            </div>
            <div id="ImageBrowserPanel">
                <div style="text-align: right">
                    <asp:ImageButton ID="CloseHyperLinkImageButton" runat="server" ImageUrl="~/WebControls/ThirdParty/CKFinder/skins/kama/Close.png"
                        AlternateText="بستن" />
                </div>
                <CKFinder:FileBrowser ID="ImageFileBrowser" runat="server" BasePath='<%# Page.ResolveUrl("~/WebControls/ThirdParty/CKFinder") %>'>
                </CKFinder:FileBrowser>
            </div>
        </asp:Panel>
        <table>
            <tr>
                <td>
                    <asp:TextBox ID="SelectedImageTextBox" runat="server" Height="25px" Width="350px"
                        Style="text-align: left; direction: ltr; float: left"></asp:TextBox>
                </td>
                <td>
                    &nbsp;&nbsp;<asp:Button ID="OpenImageBrowserButton" BackColor="#547EB4" ForeColor="#FFFFFF"
                        Font-Bold="True" Font-Size="X-Small" Font-Names="Tahoma" Height="24px" runat="server"
                        Text="انتخاب عکس" />
                </td>
                <td style="height: 25px; width: 25px">
                    &nbsp;&nbsp;<asp:Image ID="ProductImages" runat="server" ToolTip="آخرين تصوير انتخاب شده"
                        Style="max-width: 25px; text-align: center; vertical-align: middle; visibility: hidden" />
                </td>
            </tr>
        </table>
    </div>
</center>

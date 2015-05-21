<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ImageBrowser.ascx.cs"
    Inherits="WebControls_Common_ImageBrowser" ClassName="ImageBrowser" %>
<link href="~/StyleSheets/ControlStyles.css" rel="stylesheet" type="text/css" />
<center>
    <asp:Panel ID="ImageBrowserPanel" runat="server" CssClass="signupTable">
        <table>
            <tr>
                <td>
                    <asp:TextBox ID="SelectedImageTextBox" runat="server" Height="25px" Width="350px"
                        Style="text-align: left; direction: ltr; font-family: Times New Roman"></asp:TextBox>
                </td>
                <td>
                    &nbsp;&nbsp;<asp:Button ID="OpenImageBrowserButton" BackColor="#547EB4" ForeColor="#FFFFFF"
                        Font-Bold="True" Font-Size="X-Small" Font-Names="Tahoma" Height="25px" runat="server"
                        Text="انتخاب عکس" />
                </td>
                <td style="height: 25px; width: 25px">
                    &nbsp;&nbsp;<asp:Image ID="ProductImages" runat="server" ToolTip="آخرين تصوير انتخاب شده"
                        Width="25px" Style="max-width: 25px; text-align: center; vertical-align: middle;
                        visibility: hidden" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</center>

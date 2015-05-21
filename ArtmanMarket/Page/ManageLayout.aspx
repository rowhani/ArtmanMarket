<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ManageLayout.aspx.cs" Inherits="Page_ManageLayout" Title="مديريت طرح بندی"
    ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Src="~/WebControls/Common/WaitPanel.ascx" TagName="WaitPanel" TagPrefix="wtp" %>
<asp:Content ID="ManageLayoutContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            مديريت طرح بندی</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <asp:UpdatePanel ID="ManageLayoutUpdatePanel" runat="server">
            <ContentTemplate>
                <center style="font-weight: bold; color: MediumVioletRed">
                    <b>توجه: تغييرات پس از تازه کردن صفحه مشاهده خواهند شد. </b>
                </center>
                <br />
                <table style="font-family: Tahoma; font-size: small; font-weight: bold; color: Salmon"
                    cellspacing="5px">
                    <tr>
                        <td>
                            نمايش بنر بالاي سايت
                        </td>
                        <td>
                            <asp:Button ID="ActivateUpperBannerButton" runat="server" Text="فعال" Visible='<%# Application["ShowUpperBanner"] != null && Application["ShowUpperBanner"].ToString() == "No" %>'
                                CommandArgument="ShowUpperBanner" OnClick="ActivateButton_Click" />
                            <asp:Button ID="DeactivateUpperBannerButton" runat="server" Text="غير فعال" Visible='<%# Application["ShowUpperBanner"] == null || Application["ShowUpperBanner"].ToString() == "Yes" %>'
                                CommandArgument="ShowUpperBanner" OnClick="DeactivateButton_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            نمايش پانل ابزار
                        </td>
                        <td>
                            <asp:Button ID="ActivateGadgetsButton" runat="server" Text="فعال" Visible='<%# Application["ShowGadgets"] != null && Application["ShowGadgets"].ToString() == "No" %>'
                                CommandArgument="ShowGadgets" OnClick="ActivateButton_Click" />
                            <asp:Button ID="DeactivateGadgetsButton" runat="server" Text="غير فعال" Visible='<%# Application["ShowGadgets"] == null || Application["ShowGadgets"].ToString() == "Yes" %>'
                                CommandArgument="ShowGadgets" OnClick="DeactivateButton_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            نمايش پانل تبليغات
                        </td>
                        <td>
                            <asp:Button ID="ActivateAdsButton" runat="server" Text="فعال" Visible='<%# Application["ShowAds"] != null && Application["ShowAds"].ToString() == "No" %>'
                                CommandArgument="ShowAds" OnClick="ActivateButton_Click" />
                            <asp:Button ID="DeactivateAdsButton" runat="server" Text="غير فعال" Visible='<%# Application["ShowAds"] == null || Application["ShowAds"].ToString() == "Yes" %>'
                                CommandArgument="ShowAds" OnClick="DeactivateButton_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            نمايش آمار سايت
                        </td>
                        <td>
                            <asp:Button ID="ActivateStatisticsButton" runat="server" Text="فعال" Visible='<%# Application["ShowStatistics"] != null && Application["ShowStatistics"].ToString() == "No" %>'
                                CommandArgument="ShowStatistics" OnClick="ActivateButton_Click" />
                            <asp:Button ID="DeactivateStatisticsButton" runat="server" Text="غير فعال" Visible='<%# Application["ShowStatistics"] == null || Application["ShowStatistics"].ToString() == "Yes" %>'
                                CommandArgument="ShowStatistics" OnClick="DeactivateButton_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            نمايش بنر پايين سايت
                        </td>
                        <td>
                            <asp:Button ID="ActivateLowerBannerButton" runat="server" Text="فعال" Visible='<%# Application["ShowLowerBanner"] != null && Application["ShowLowerBanner"].ToString() == "No" %>'
                                CommandArgument="ShowLowerBanner" OnClick="ActivateButton_Click" />
                            <asp:Button ID="DeactivateLowerBannerButton" runat="server" Text="غير فعال" Visible='<%# Application["ShowLowerBanner"] == null || Application["ShowLowerBanner"].ToString() == "Yes" %>'
                                CommandArgument="ShowLowerBanner" OnClick="DeactivateButton_Click" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="ManageLayoutUpdateProgress" runat="server" AssociatedUpdatePanelID="ManageLayoutUpdatePanel">
            <ProgressTemplate>
                <wtp:WaitPanel ID="ManageLayoutWaitPanel" runat="server" />
            </ProgressTemplate>
        </asp:UpdateProgress>
        &nbsp;
        <br />
    </div>
</asp:Content>

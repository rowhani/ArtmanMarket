<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FlashAdPanel.ascx.cs"
    Inherits="WebControls_Master_FlashAdPanel" %>
<%@ Register Assembly="FlashControl" Namespace="Bewise.Web.UI.WebControls" TagPrefix="Bewise" %>
<%@ Register Src="~/WebControls/Common/WaitPanel.ascx" TagName="WaitPanel" TagPrefix="uc1" %>
<link href="~/StyleSheets/ControlStyles.css" rel="stylesheet" type="text/css" />
<div dir="rtl">
    <center>
        <asp:UpdatePanel ID="FlashAdUpdatePanel" runat="server">
            <Triggers>
                <asp:PostBackTrigger ControlID="AdFlashAddImageButton" />
            </Triggers>
            <ContentTemplate>
                <asp:SqlDataSource ID="FlashAdSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
                    SelectCommand="GetFlashAds" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:DataList ID="FlashAdDataList" runat="server" DataSourceID="FlashAdSqlDataSource"
                    RepeatDirection="Vertical" EnableViewState="false" RepeatColumns="1" DataKeyField="ID"
                    HorizontalAlign="center">
                    <ItemTemplate>
                        <div style="position: relative; z-index: 1; height: 200px; width: 200px; border-width: 0px;
                            text-align: center">
                            <asp:HyperLink ID="FlashAdHyperLink" runat="server" Target="_blank" NavigateUrl='<%# Eval("WebsiteUrl").ToString().Trim() %>'>
                                <Bewise:FlashControl ID="FlashAdFlashControl" runat="server" AlternativeImage="~/Images/Product/nologo.gif"
                                    Height="200px" Width="200px" WMode="Opaque" MovieUrl='<%# Eval("AdUrl").ToString().Trim() %>'
                                    Visible='<%# Eval("AdUrl").ToString().Trim().ToLower().EndsWith(".swf") %>' />
                                <asp:Image Style="max-width: 200px; vertical-align: middle;" ImageAlign="Middle"
                                    ID="FlashAdImage" runat="server" ImageUrl='<%# Eval("AdUrl").ToString().Trim() %>'
                                    Visible='<%# !Eval("AdUrl").ToString().Trim().ToLower().EndsWith(".swf") %>' />
                            </asp:HyperLink>
                        </div>
                        <asp:Panel ID="FlashAdControlPanel" runat="server" Visible='<%# ShowAdminPanel && Request.IsAuthenticated && ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()) %>'>
                            <asp:ImageButton ID="DeleteImageButton" runat="server" Width="24px" Height="24px"
                                BorderWidth="0px" Style="right: 113px; position: relative; top: -27px; z-index: 2;"
                                ImageUrl="~/Images/Ads/delete.png" ToolTip="حذف" OnClick="DeleteImageButton_Click"
                                CommandArgument='<%# Eval("ID") + "*" + Eval("AdUrl").ToString().Trim() %>' CausesValidation="false" />
                            <asp:ImageButton ID="MoveUpImageButton" runat="server" Width="24px" Height="24px"
                                Style="right: -87px; position: relative; top: -198px; z-index: 2" ImageUrl="~/Images/Ads/up.png"
                                ToolTip="انتقال به بالا" OnClick="MoveUpImageButton_Click" CommandArgument='<%# Eval("ID") + "," + Eval("Place") + "," + Eval("NumOfAds") %>'
                                CausesValidation="false" OnDataBinding="MoveUpImageButton_DataBinding" />
                            <asp:ImageButton ID="MoveDownImageButton" runat="server" Width="24px" Height="24px"
                                Style="right: -91px; position: relative; top: -198px; z-index: 2" ImageUrl="~/Images/Ads/down.png"
                                ToolTip="انتقال به پايين" OnClick="MoveDownImageButton_Click" CommandArgument='<%# Eval("ID") + "," + Eval("Place") + "," + Eval("NumOfAds") %>'
                                CausesValidation="false" OnDataBinding="MoveDownImageButton_DataBinding" />
                        </asp:Panel>
                    </ItemTemplate>
                </asp:DataList>
                <asp:Panel ID="AdFlashAddPanel" runat="server" Style="text-align: center; font-family: Tahoma;
                    direction: rtl; font-size: small; border-style: outset; border-color: Navy; border-width: 1px"
                    Width="200px" HorizontalAlign="center" DefaultButton="AdFlashAddImageButton"
                    Visible='<%# ShowAdminPanel && Request.IsAuthenticated && ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()) %>'>
                    <br />
                    <span style="color: #0099cc"><strong>اضافه کردن يک تبليغ جديد</strong></span>
                    <br />
                    <table style="margin-top: 5px; padding-right: 1px; padding-left: 1px">
                        <tr>
                            <td>
                                <asp:RequiredFieldValidator ID="AdFlashAddRequiredFieldValidator" runat="server"
                                    ControlToValidate="AdFlashAddFileUpload" ErrorMessage="*" ValidationGroup='<%# this.ClientID + "FlashAdPanel" %>'></asp:RequiredFieldValidator>&nbsp;
                                <asp:FileUpload ID="AdFlashAddFileUpload" runat="server" Width="150px" ToolTip="آدرس فايل تبليغاتي" /></td>
                            <td rowspan="2" valign="middle">
                                <br />
                                <asp:ImageButton ID="AdFlashAddImageButton" runat="server" ImageUrl="~/Images/Product/add.png"
                                    Width="24px" Height="24px" ToolTip="اضافه کردن" OnClick="AdFlashAddImageButton_Click"
                                    ValidationGroup='<%# this.ClientID + "FlashAdPanel" %>' />&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="AdFlashWebsiteLabel" runat="server" Text="وب سايت"
                                    AssociatedControlID="AdFlashWebsiteTextBox"></asp:Label>&nbsp;
                                <asp:TextBox ID="AdFlashWebsiteTextBox" ToolTip="آدرس وب سايت" runat="server" Width="84px"
                                    MaxLength="200"></asp:TextBox></td>
                        </tr>
                    </table>
                    <asp:RegularExpressionValidator ID="AdFlashAddRegularExpressionValidator" runat="server"
                        ValidationExpression=".+\.(((s|S)(w|W)(f|W))|((g|G)(i|I)(f|F)))" ErrorMessage="تبليغ بايد فايلي به فرمت swf يا gif باشد."
                        Style="font-size: x-small; font-weight: bold" ControlToValidate="AdFlashAddFileUpload"
                        ValidationGroup="FlashAdPanel"></asp:RegularExpressionValidator>
                    <br />
                    <asp:RegularExpressionValidator Style="font-size: x-small; font-weight: bold" ControlToValidate="AdFlashWebsiteTextBox"
                        ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?" ID="AdFlashWebsiteRegularExpressionValidator"
                        runat="server" ErrorMessage="آدرس سايت نامعتبر است." ValidationGroup="FlashAdPanel"></asp:RegularExpressionValidator>
                    <br />
                    <br />
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="FlashAdUpdateProgress" runat="server" AssociatedUpdatePanelID="FlashAdUpdatePanel">
            <ProgressTemplate>
                <uc1:WaitPanel ID="FlashAdWaitPanel" runat="server" />
            </ProgressTemplate>
        </asp:UpdateProgress>
    </center>
</div>

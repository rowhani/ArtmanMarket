<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ResourceManager.aspx.cs" Inherits="Page_FileManager_ResourceManager"
    Title="مديريت منابع" MaintainScrollPositionOnPostback="true" ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Src="~/WebControls/ThirdParty/SiteFileManager/SiteFileManagerControl.ascx"
    TagName="SiteFileManagerControl" TagPrefix="uc1" %>
<asp:Content ID="ResourceManagerContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div style="direction: ltr; text-align: left">
        <h3 class="signupTable" style="color: gray">
            مديريت منابع</h3>
        <hr style="border-top: 1px dashed Gray; font-size: 12pt;" />
        <br />
        <center>
            <uc1:SiteFileManagerControl ID="ResourceManagerSiteFileManagerControl" runat="server"
                PanelWidth="540px" EditorUrl="~/Page/FileManager/SourceEditor.aspx"></uc1:SiteFileManagerControl>
        </center>
        &nbsp;<br />
    </div>
</asp:Content>

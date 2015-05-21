<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImageBrowserPopup.aspx.cs"
    Inherits="WebControls_Common_ImageBrowserPopup" %>

<%-- <%@ OutputCache Duration="6000" VaryByParam="None" %> --%>
<%@ Register Assembly="CKFinder" Namespace="CKFinder" TagPrefix="CKFinder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>انتخاب تصوير</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="background-color: White">
            <CKFinder:FileBrowser ID="ImageFileBrowser" runat="server" BasePath='<%# Page.ResolveUrl("~/WebControls/ThirdParty/CKFinder") %>' StartupPath="/Images">
            </CKFinder:FileBrowser>
            <br />
            <br />
            <b>Selected Images:</b> <br />
            <asp:Label ID="SelectedImagesLabel" runat="server" Font-Size="Small"></asp:Label>
        </div>
    </form>
</body>
</html>

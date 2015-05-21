<%@ Page Language="C#" %>
<%@ Register TagPrefix="cc" Namespace="Winthusiasm.HtmlEditor.ImageBrowser" Assembly="Winthusiasm.HtmlEditor" %>

<script language="C#" runat="server">
public void Page_Error(object sender, EventArgs e)
{
    ImageUpload.HandleException(this);
}
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Upload</title>
    <style type="text/css">
        body { background-color: White; color: Black; font-family: Verdana; font-size: 8pt; margin: 5px 10px; }
    </style>
</head>
<body onload="OnLoad()">
    <form id="form1" runat="server" >
        <asp:ScriptManager ID="ScriptManagerControl" runat="server" />
        <cc:ImageUpload ID="ImageUploadControl" runat="server" />
    </form>

<script type="text/javascript">
function OnLoad()
{
    window.setTimeout('$find("ImageUploadControl").OnPageLoad()', 0);
}
</script>

</body>
</html>

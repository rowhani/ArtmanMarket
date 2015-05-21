/// <author> Payman Rowhani </author>
/// <copyright> Copyright© 2004-2011, Artman Systems Inc. </copyright>
/// 
using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class WebControls_Common_ImageBrowserPopup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        DataBind();

        string functionName = "SelectImage";

        string script = "function " + functionName + "(fileUrl, data){" +
            "var virtualFileUrl = '~' + fileUrl.substr(fileUrl.indexOf('/', 1));" +
            "var parDoc = window.opener.document;" +
            "var addr = parDoc.getElementById('" + Request.QueryString["tid"] + "');" +
            "var img = parDoc.getElementById('" + Request.QueryString["mid"] + "');" +
            "var info = document.getElementById('" + SelectedImagesLabel.ClientID + "');" + 
            "img.src = fileUrl;" +
            "img.style.visibility = 'visible';";

        if (Request.QueryString["append"] == "1")
            script += "if(addr.value.indexOf(virtualFileUrl) == -1) {" +
                "addr.value += '|' + virtualFileUrl; " +
                "info.innerHTML += '&nbsp;&nbsp;-&nbsp;' + unescape(fileUrl.substr(fileUrl.lastIndexOf('/') + 1)) + ' <br />'; } } ";
        else
        {
            script += "addr.value = virtualFileUrl;";
            script += "window.close(); }";
        }

        Page.ClientScript.RegisterStartupScript(this.GetType(), "SelectScript", script, true);

        ImageFileBrowser.SelectFunction = functionName;
        ImageFileBrowser.SelectThumbnailFunction = functionName;
    }
}

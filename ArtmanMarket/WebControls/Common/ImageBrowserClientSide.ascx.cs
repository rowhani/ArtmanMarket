/// <author> Payman Rowhani </author>
/// <copyright> Copyright© 2004-2011, Artman Systems Inc. </copyright>

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

public partial class WebControls_Common_ImageBrowserClientSide : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if(!IsPostBack)
        //    DataBind();

        SetClientScript(false);

        CloseHyperLinkImageButton.OnClientClick = "document.getElementById('" + ImageBrowserPopupPanel.ClientID + "').style.visibility ='hidden'; return false;";
        OpenImageBrowserButton.OnClientClick = "document.getElementById('" + ImageBrowserPopupPanel.ClientID + "').style.visibility ='visible'; return false;";
    }

    public TextBox AddressTextBox
    {
        get { return SelectedImageTextBox; }
        set { SelectedImageTextBox = value; }
    }

    public Unit AddressWidth
    {
        get { return SelectedImageTextBox.Width; }
        set { SelectedImageTextBox.Width = value; }
    }

    public string Text
    {
        get { return SelectedImageTextBox.Text; }
        set { SelectedImageTextBox.Text = value; }
    }

    public string ToolTip
    {
        get { return SelectedImageTextBox.ToolTip; }
        set { SelectedImageTextBox.ToolTip = value; }
    }

    public string ImageUrl
    {
        get { return ProductImages.ImageUrl; }
        set { ProductImages.ImageUrl = value; }
    }

    public string ImageVisibility
    {
        get { return ProductImages.Style["visibility"]; }
        set { ProductImages.Style["visibility"] = value; }
    }

    public void SetClientScript(bool appendAddresses)
    {
        string functionName = "SetFileField" + ClientID;

        string script = "function " + functionName + "(fileUrl, data){" +
            "var virtualFileUrl = '~' + fileUrl.substr(fileUrl.indexOf('/', 1));" +
            "var addr = document.getElementById('" + AddressTextBox.ClientID + "');" +
            "var img = document.getElementById('" + ProductImages.ClientID + "');" +
            "img.src = fileUrl;" +
            "img.style.visibility = 'visible';";
        
        if (appendAddresses)
            script += "addr.value += '|' + virtualFileUrl;";
        else
        {
            script += "addr.value = virtualFileUrl; }";
            script += "document.getElementById('" + ImageBrowserPopupPanel.ClientID + "').style.visibility = 'hidden'; }";
        }       

        Page.ClientScript.RegisterStartupScript(this.GetType(), "AddressScript" + ClientID, script, true);

        ImageFileBrowser.SelectFunction = functionName;
        ImageFileBrowser.SelectThumbnailFunction = functionName;
    }
}

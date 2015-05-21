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

public partial class WebControls_Common_ImageBrowser : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        OpenImageBrowserButton.OnClientClick = "window.open('" + Page.ResolveUrl("~/WebControls/Common/ImageBrowserPopup.aspx") +
             "?tid=" + SelectedImageTextBox.ClientID +
             "&mid=" + ProductImages.ClientID +
             "&append=" + (IsAppendable ? "1" : "0") + "', " +
             "'SelectImage', 'scrollbars=yes,resizable=no,width=900,height=550'); return false;";
    }

    private bool _isAppendable = false;

    public bool IsAppendable
    {
        get { return _isAppendable; }
        set
        {
            _isAppendable = value;
            if (_isAppendable)
            {
                SelectedImageTextBox.TextMode = TextBoxMode.MultiLine;
                SelectedImageTextBox.Height = 50;
                SelectedImageTextBox.Font.Size = 8;
            }
        }
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
}

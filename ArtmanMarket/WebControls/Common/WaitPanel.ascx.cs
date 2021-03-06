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

public partial class WebControls_Common_WaitPanel : System.Web.UI.UserControl
{
    private string _loadingTitle = "...درحال بارگذاري";
    private string _loadingImageUrl = "~/Images/AjaxControlImages/LoadingSpiralBlue.gif";

    public string LoadingTitle
    {
        get { return _loadingTitle; }
        set { _loadingTitle = value; }
    }

    public string LoadingImageUrl
    {
        get { return _loadingImageUrl; }
        set { _loadingImageUrl = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadingLabel.Text = LoadingTitle;
        LoadingImage.ImageUrl = LoadingImageUrl;
    }
}

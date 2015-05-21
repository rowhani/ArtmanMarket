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

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if(!IsPostBack)
        //   DataBind();

        Page.Header.Title = "آرتمن مارکت - " + Page.Header.Title;

        Application.Lock();
        MasterTicker.Visible = (Application["ShowUpperBanner"] == null || Application["ShowUpperBanner"].ToString() == "Yes");
        MasterGadgets.Visible = (Application["ShowGadgets"] == null || Application["ShowGadgets"].ToString() == "Yes");
        MasterFlashAdPanel.Visible = (Application["ShowAds"] == null || Application["ShowAds"].ToString() == "Yes");
        MasterStatistics.Visible = (Application["ShowStatistics"] == null || Application["ShowStatistics"].ToString() == "Yes");
        ArtmanFooterLogoPanel.Visible = (Application["ShowLowerBanner"] == null || Application["ShowLowerBanner"].ToString() == "Yes");
        Application.UnLock();
    }
}

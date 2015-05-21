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
using System.Globalization;

public partial class Page_News : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBind();

            do
            {
                NewsListSiteMapDataSource.DataBind();
                NewsListTreeView.DataBind();
            } while (NewsListTreeView.Nodes.Count == 0);

            if (String.IsNullOrEmpty(Request.QueryString["ID"]))
                NewsListTreeView.Nodes[0].Selected = true;
        }
    }

    protected void Page_Error(object sender, EventArgs e)
    {
        Response.Redirect("~/Page/News.aspx");
    }

    protected string GetPersianDate(object date)
    {
        //return DateTime.Parse(date.ToString()).ToString("d MMMM yyyy, h:mm tt");

        try
        {
            DateTime thisDate = DateTime.Parse(date.ToString());
            PersianCalendar jc = new PersianCalendar();

            return String.Format("{3}:{4} {0}/{1}/{2}",
                            jc.GetYear(thisDate),
                            jc.GetMonth(thisDate),
                            jc.GetDayOfMonth(thisDate),
                            jc.GetHour(thisDate),
                            jc.GetMinute(thisDate));
        }
        catch (Exception)
        {
            return "";
        }
    }
}

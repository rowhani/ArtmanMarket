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

public partial class WebControls_Master_CategoryMenu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBind();

            int i = 0;
            do
            {
                CategorySiteMapDataSource.DataBind();
                CategoriesMenu.DataBind();
            } while (i++ < 2 && CategoriesMenu.Items.Count == 0);

            string qs = "";
            foreach (string key in Request.QueryString.AllKeys)
                if (key != "catid")
                    qs += ("&" + key + "=" + Request.QueryString[key]);

            foreach (MenuItem item in CategoriesMenu.Items)
                AddQueryStringToMenu(item, qs);
        }
    }

    protected void AddQueryStringToMenu(MenuItem curItem, string qs)
    {
        if (!curItem.NavigateUrl.Contains(qs))
            curItem.NavigateUrl = Page.ResolveUrl(curItem.NavigateUrl) + qs;

        foreach (MenuItem item in curItem.ChildItems)
        {
            if (!item.NavigateUrl.Contains(qs))
                item.NavigateUrl = Page.ResolveUrl(item.NavigateUrl) + qs;

            if (item.ChildItems.Count != 0)
                AddQueryStringToMenu(item, qs);
        }
    }
}

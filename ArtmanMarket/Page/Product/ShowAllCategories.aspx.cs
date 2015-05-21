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

public partial class Page_Product_ShowAllCategories : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            do
            {
                CategorySiteMapDataSource.DataBind();
                CategoryTreeView.DataBind();
            } while (CategoryTreeView.Nodes.Count == 0);

            string qs = "";
            foreach (string key in Request.QueryString.AllKeys)
                if (key != "catid")
                    qs += ("&" + key + "=" + Request.QueryString[key]);

            foreach (TreeNode node in CategoryTreeView.Nodes)
                AddQueryStringToTree(node, qs);
        }
    }

    protected void AddQueryStringToTree(TreeNode curNode, string qs)
    {
        if (!curNode.NavigateUrl.Contains(qs))
            curNode.NavigateUrl = Page.ResolveUrl(curNode.NavigateUrl) + qs;

        foreach (TreeNode node in curNode.ChildNodes)
        {
            if (!node.NavigateUrl.Contains(qs))
                node.NavigateUrl = Page.ResolveUrl(node.NavigateUrl) + qs;

            if (node.ChildNodes.Count != 0)
                AddQueryStringToTree(node, qs);
        }
    }
}

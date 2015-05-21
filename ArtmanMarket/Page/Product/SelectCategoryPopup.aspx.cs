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

public partial class Page_Product_SelectCategoryPopup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (String.IsNullOrEmpty(Request["AUTH_USER"]) || !ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()))
        //    Response.Redirect("~/Page/Errors/AccessDenied.aspx");

        int i = 0;
        while (i++ < 3 && CategoryTreeView.Nodes.Count == 0)
        {
            CategorySiteMapDataSource.DataBind();
            CategoryTreeView.DataBind();            
        }

        if (CategoryTreeView.Nodes.Count == 0)
            SelectCategoryMultiView.SetActiveView(ErrorView);
        else
            SelectCategoryMultiView.SetActiveView(SelectCategoryView);
    }

    protected void CategoryTreeView_SelectedNodeChanged(object sender, EventArgs e)
    {
        Response.Write("<script language='javascript'> " +
            "var parDoc = window.opener.document;" +
            "parDoc.getElementById('" + Request.QueryString["tid"] + "').value ='" + CategoryTreeView.SelectedNode.Text + "';" +
            "parDoc.getElementById('" + Request.QueryString["vid"] + "').value ='" + CategoryTreeView.SelectedValue + "';" + 
            "window.close();" + 
            "</script>");
    }
}

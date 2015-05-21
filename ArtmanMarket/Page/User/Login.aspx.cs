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

public partial class Page_User_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBind();

            if (Request.IsAuthenticated && (!String.IsNullOrEmpty(Request.QueryString["ReturnUrl"]) && !ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower())))
                Response.Redirect("~/Page/Errors/AccessDenied.aspx");
        }

        UserLoginPanel.FindControl("UserNameTextBox").Focus();
    }
}

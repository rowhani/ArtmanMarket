/// <author> Payman Rowhani </author>
/// <copyright> Copyrightę 2004-2011, Artman Systems Inc. </copyright>

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

public partial class Page_FileManager_ResourceManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!Request.IsAuthenticated || !ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()))
        //    Response.Redirect("~/Page/Errors/AccessDenied.aspx");
    }
}

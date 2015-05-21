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

public partial class WebControls_Master_HeaderPanel : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            DataBind();
    }

    protected void SearchImageButton_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Page/Product/SearchProduct.aspx?q=" + SearchTextBox.Text.Trim());
    }
}

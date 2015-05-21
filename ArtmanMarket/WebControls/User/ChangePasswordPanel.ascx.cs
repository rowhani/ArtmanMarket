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
using System.Data.SqlClient;
using System.Web.Configuration;

public partial class WebControls_User_ChangePasswordPanel : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            ChangePasswordMultiView.SetActiveView(ChangePasswordFormView);
    }

    protected void CurrentPasswordCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();
            SqlCommand com = new SqlCommand("SELECT Password FROM [Account] WHERE Username=@Username", conn);
            com.Parameters.Add(new SqlParameter("Username", Request["AUTH_USER"]));
            SqlDataReader reader = com.ExecuteReader();
            if (reader.Read())
                args.IsValid = (reader["Password"].ToString().Trim() == FormsAuthentication.HashPasswordForStoringInConfigFile(CurrentPasswordTextBox.Text.Trim(), FormsAuthPasswordFormat.MD5.ToString()));
            else
                args.IsValid = true;
            conn.Close();
        }
    }

    protected void ChangePasswordButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            ChangePasswordMultiView.SetActiveView(ChangePasswordConfirmView);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
            {
                conn.Open();
                SqlCommand com = new SqlCommand("UPDATE [Account] SET Password=@Password WHERE Username=@Username", conn);
                com.Parameters.Add(new SqlParameter("Username", Request["AUTH_USER"]));
                com.Parameters.Add(new SqlParameter("Password", FormsAuthentication.HashPasswordForStoringInConfigFile(NewPasswordTextBox.Text.Trim(), FormsAuthPasswordFormat.MD5.ToString())));
                com.ExecuteNonQuery();
                conn.Close();
            }
        }
        else
            ChangePasswordMultiView.SetActiveView(ChangePasswordFormView);
    }

    protected void CancelButton_Click(object sender, EventArgs e)
    {
        string returnUrl = Request["ReturnUrl"];
        if (returnUrl != null)
            Response.Redirect(returnUrl);
        else
            Response.Redirect(Request.Url.PathAndQuery);
    }

    protected void ReturnChangePasswordButton_Click(object sender, EventArgs e)
    {
        string returnUrl = Request["ReturnUrl"];
        if (returnUrl != null)
            Response.Redirect(returnUrl);
        else
            Response.Redirect(Request.Url.PathAndQuery);
    }
}

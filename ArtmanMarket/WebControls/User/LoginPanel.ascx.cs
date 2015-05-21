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
using System.Web.Configuration;
using System.Data.SqlClient;

public partial class WebControls_User_LoginPanel : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            DataBind();

        UserNameTextBox.Attributes["onkeypress"] = "javascript: document.getElementById('" +
            PasswordTextBox.ClientID + "').value = ''";

        if (String.IsNullOrEmpty(Request["AUTH_USER"]))
            LoginMultiView.SetActiveView(LoginPanelView);
        else
            LoginMultiView.SetActiveView(LoginViewPanelView);

        if (Session["Signout"] == null || Session["Signout"].ToString() == "")
            SignoutLiteral.Visible = false;
        else
        {
            SignoutLiteral.Visible = true;
            Session.Remove("Signout");
        }
    }

    /*Configuration webconfig = WebConfigurationManager.OpenWebConfiguration("~/Web.config");
     SystemWebSectionGroup sysweb = (SystemWebSectionGroup)webconfig.GetSectionGroup("system.web");
     AuthenticationSection authSection = sysweb.Authentication;

     FormsAuthenticationUserCollection users = authSection.Forms.Credentials.Users;
     FormsAuthenticationUser user = users["admin"];

     user.Password = FormsAuthentication.HashPasswordForStoringInConfigFile("new", FormsAuthPasswordFormat.MD5.ToString()); ;
     webconfig.Save(); */

    protected void UserLoginStatus_LoggingOut(object sender, LoginCancelEventArgs e)
    {
        if (!Request.IsAuthenticated)
        {
            Response.Redirect(Request.Url.PathAndQuery);
            return;
        }

        OnlineActiveUsers.OnlineUsersInstance.OnlineUsers.SetUserOffline(Session["AUTH_USER"].ToString());

        FormsAuthentication.SignOut();
        Session.Remove("AUTH_USER");
        Session["Signout"] = "True";
    }

    protected void LoginCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (Request.IsAuthenticated)
        {
            Response.Redirect(Request.Url.PathAndQuery);
            return;
        }

        string username = UserNameTextBox.Text.Trim().ToLower();
        string password = PasswordTextBox.Text.Trim();

        bool authenticated = false;

        //if (FormsAuthentication.Authenticate(username, password))
        //    authenticated = true;
        //else
        //{
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();
            SqlCommand com = new SqlCommand("SELECT COUNT(*) FROM [Account] WHERE Username=@Username AND Password=@Password", conn);
            com.Parameters.Add(new SqlParameter("Username", username));
            com.Parameters.Add(new SqlParameter("Password", FormsAuthentication.HashPasswordForStoringInConfigFile(password, FormsAuthPasswordFormat.MD5.ToString())));
            authenticated = ((int)com.ExecuteScalar()) > 0;
            conn.Close();
        }
        //}

        args.IsValid = authenticated;

        if (authenticated)
        {
            OnlineActiveUsers.OnlineUsersInstance.OnlineUsers.SetUserOnline(username);

            Session["AUTH_USER"] = username;

            try
            {
                string returnUrl = Request.QueryString["ReturnUrl"];
                if (!String.IsNullOrEmpty(returnUrl))
                    FormsAuthentication.RedirectFromLoginPage(username, RememberMeCheckBox.Checked);
                else
                {
                    FormsAuthentication.SetAuthCookie(username, RememberMeCheckBox.Checked);
                    Response.Redirect(Request.Url.PathAndQuery);
                }
            }
            catch (Exception)
            {
                FormsAuthentication.SetAuthCookie(username, RememberMeCheckBox.Checked);
            }
        }
    }
}

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
using MSCaptcha;
using System.Data.SqlClient;
using PersianDateControls;

public partial class Page_User_Signup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            SignupMultiView.SetActiveView(SignupFormView);

        CreateUserBindFormView.FindControl("UserNameTextBox").Focus();
        //Master.Page.Form.DefaultFocus = CreateUserBindFormView.FindControl("UserNameTextBox").ClientID;
        Page.Form.DefaultButton = CreateUserBindFormView.FindControl("CreateUserButton").UniqueID;
    }

    protected void CaptchaCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        CaptchaControl SignupCaptchaControl = (CaptchaControl)(Market.GlobalToolkit.FindControl(CreateUserBindFormView, "SignupCaptchaControl"));
        TextBox CaptchaTextBox = (TextBox)(Market.GlobalToolkit.FindControl(CreateUserBindFormView, "CaptchaTextBox"));

        SignupCaptchaControl.ValidateCaptcha(CaptchaTextBox.Text.Trim());
        args.IsValid = SignupCaptchaControl.UserValidated;
    }

    protected void UserNameCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        TextBox UserNameTextBox = (TextBox)(Market.GlobalToolkit.FindControl(CreateUserBindFormView, "UserNameTextBox"));

        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();
            SqlCommand com = new SqlCommand("SELECT COUNT(*) FROM [Account] WHERE Username=@Username", conn);
            com.Parameters.Add(new SqlParameter("Username", UserNameTextBox.Text.Trim()));
            args.IsValid = ((int)com.ExecuteScalar()) == 0;
            conn.Close();
        }
    }

    private void SigninUser(bool redirect)
    {
        TextBox UserNameTextBox = (TextBox)(Market.GlobalToolkit.FindControl(CreateUserBindFormView, "UserNameTextBox"));
        string username = UserNameTextBox.Text.Trim().ToLower();

        Session["AUTH_USER"] = username;

        if (redirect)
            FormsAuthentication.RedirectFromLoginPage(username, false);
        else
            FormsAuthentication.SetAuthCookie(username, false);
    }

    protected void ReturnSignupButton_Click(object sender, EventArgs e)
    {
        SigninUser(true);
    }

    protected void CreateUserButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            SigninUser(false);
            SignupMultiView.SetActiveView(SignupConfirmView);
        }
        else
            SignupMultiView.SetActiveView(SignupFormView);
    }

    protected void CreateUserBindFormView_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["Password"] = FormsAuthentication.HashPasswordForStoringInConfigFile(e.Values["Password"].ToString().Trim(), FormsAuthPasswordFormat.MD5.ToString());

        PersianDateTextBox BirthdayPersianDateTextBox = (PersianDateTextBox)(Market.GlobalToolkit.FindControl(CreateUserBindFormView, "BirthdayPersianDateTextBox"));
        if (BirthdayPersianDateTextBox.Text.Trim() == "")
            e.Values["Birthday"] = "";
    }
}

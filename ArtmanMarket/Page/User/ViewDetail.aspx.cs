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
using PersianDateControls;
using System.Web.Configuration;

public partial class Page_User_ViewDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (String.IsNullOrEmpty(Request["AUTH_USER"]) || !ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()))
        //    Response.Redirect("~/Page/Errors/AccessDenied.aspx");

        if (!IsPostBack)
        {
            DataBind();

            ViewDetailBindFormView.DataBind();

            Label UserNameValueLabel = Market.GlobalToolkit.FindControl(ViewDetailBindFormView, "UserNameValueLabel") as Label;
            if (String.IsNullOrEmpty(Request.QueryString["UserID"]) || UserNameValueLabel == null || UserNameValueLabel.Text.Trim() == "")
                ViewDetailMultiView.SetActiveView(ViewDetailErrorIDView);
            else
            {
                RemoveDeleteButtonForAdmins(UserNameValueLabel.Text.Trim());

                ViewDetailMultiView.SetActiveView(ViewDetailFormView);
                Market.GlobalToolkit.Trim(ViewDetailBindFormView);

                PersianDateTextBox BirthdayPersianDateTextBox = (PersianDateTextBox)(Market.GlobalToolkit.FindControl(ViewDetailBindFormView, "BirthdayPersianDateTextBox"));
                if (BirthdayPersianDateTextBox != null && BirthdayPersianDateTextBox.Text.Trim() == "1278/10/11")
                    BirthdayPersianDateTextBox.Text = "";

                ViewDetailBindFormView.FindControl("EmailTextBox").Focus();
                Page.Form.DefaultButton = ViewDetailBindFormView.FindControl("UpdateButton").UniqueID;
            }
        }
    }

    protected void RemoveDeleteButtonForAdmins(string username)
    {
        if (ConfigurationManager.AppSettings["Administrators"].Contains(username))
        {
            Button DeleteButton = Market.GlobalToolkit.FindControl(ViewDetailBindFormView, "DeleteButton") as Button;
            if (DeleteButton != null)
                DeleteButton.Parent.Controls.Remove(DeleteButton);
        }
    }

    protected void ReturnButton_Click(object sender, EventArgs e)
    {
        string returnUrl = Request["ReturnUrl"];
        if (returnUrl != null)
            Response.Redirect(returnUrl);
        else
            Response.Redirect(Request.Url.PathAndQuery); //Response.Redirect("~");
    }

    protected void ReturnViewButton_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.PathAndQuery);
    }

    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        ViewDetailSqlDataSource.Delete();
        ViewDetailMultiView.SetActiveView(ViewDetailConfirmDeleteView);
    }

    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
            ViewDetailMultiView.SetActiveView(ViewDetailConfirmView);
        else
            ViewDetailMultiView.SetActiveView(ViewDetailFormView);
    }

    protected void ViewDetailBindFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        string password = e.NewValues["Password"].ToString().Trim();
        if (password == "")
            e.NewValues["Password"] = e.OldValues["Password"];
        else
            e.NewValues["Password"] = FormsAuthentication.HashPasswordForStoringInConfigFile(password, FormsAuthPasswordFormat.MD5.ToString());

        PersianDateTextBox BirthdayPersianDateTextBox = (PersianDateTextBox)(Market.GlobalToolkit.FindControl(ViewDetailBindFormView, "BirthdayPersianDateTextBox"));
        if (BirthdayPersianDateTextBox.Text.Trim() == "")
            e.NewValues["Birthday"] = "";
    }
}

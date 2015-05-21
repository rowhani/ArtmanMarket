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

public partial class Page_User_UpdateProfile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            UpdateProfileMultiView.SetActiveView(UpdateProfileFormView);

            UpdateProfileBindFormView.DataBind();
            Market.GlobalToolkit.Trim(UpdateProfileBindFormView);

            PersianDateTextBox BirthdayPersianDateTextBox = (PersianDateTextBox)(Market.GlobalToolkit.FindControl(UpdateProfileBindFormView, "BirthdayPersianDateTextBox"));
            if (BirthdayPersianDateTextBox != null && BirthdayPersianDateTextBox.Text.Trim() == "1278/10/11")
                BirthdayPersianDateTextBox.Text = "";
        }

        UpdateProfileBindFormView.FindControl("EmailTextBox").Focus();
        Page.Form.DefaultButton = UpdateProfileBindFormView.FindControl("UpdateProfileButton").UniqueID;
    }

    protected void ReturnUpdateProfileButton_Click(object sender, EventArgs e)
    {
        string returnUrl = Request["ReturnUrl"];
        if (returnUrl != null)
            Response.Redirect(returnUrl);
        else
            Response.Redirect(Request.Url.PathAndQuery);
    }

    protected void UpdateProfileButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
            UpdateProfileMultiView.SetActiveView(UpdateProfileConfirmView);
        else
            UpdateProfileMultiView.SetActiveView(UpdateProfileFormView);
    }

    protected void UpdateProfileBindFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        PersianDateTextBox BirthdayPersianDateTextBox = (PersianDateTextBox)(Market.GlobalToolkit.FindControl(UpdateProfileBindFormView, "BirthdayPersianDateTextBox"));
        if (BirthdayPersianDateTextBox.Text.Trim() == "")
            e.NewValues["Birthday"] = "";
    }
}

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
using System.Net.Mail;
using System.Drawing;
using System.Text;

public partial class Page_ContactUs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        NameTextBox.Focus();
    }

    protected void SendButton_Click(object sender, EventArgs e)
    {
        try
        {
            System.Configuration.Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);
            System.Net.Configuration.SmtpNetworkElement credentials = ((System.Net.Configuration.MailSettingsSectionGroup)config.GetSectionGroup("system.net/mailSettings")).Smtp.Network;

            MailMessage mm = new MailMessage(EmailTextBox.Text.Trim(), "artmanmarket@gmail.com");
            mm.From = new MailAddress(EmailTextBox.Text.Trim(), NameTextBox.Text.Trim(), Encoding.UTF8);
            mm.ReplyTo = new MailAddress(EmailTextBox.Text.Trim());
            mm.To.Add(new MailAddress("artmanmarket@gmail.com"));
            mm.Subject = SubjectTextBox.Text.Trim();
            mm.SubjectEncoding = Encoding.UTF8;
            mm.Body = "<div dir='rtl' align='right'>" + BodyTextBox.Text.Trim() + "</div>";
            mm.BodyEncoding = Encoding.UTF8;
            mm.IsBodyHtml = true;

            SmtpClient smtp = new SmtpClient();
            smtp.EnableSsl = true;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential(credentials.UserName, credentials.Password);

            smtp.Send(mm);

            InfoLabel.ForeColor = Color.Green;
            InfoLabel.Text = "پيام شما با موفقيت ارسال شد.";
        }
        catch (Exception)
        {
            InfoLabel.ForeColor = Color.Red;
            InfoLabel.Text = "مشکلي در ارسال پيام شما وجود داشت. لطفا بعدا دوباره سعي نماييد.";
        }

        InfoLabel.Visible = true;
    }
}

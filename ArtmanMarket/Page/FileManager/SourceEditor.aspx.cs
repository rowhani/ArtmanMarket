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
using System.IO;
using System.Drawing;

public partial class Page_FileManager_SourceEditor : System.Web.UI.Page
{
    private string fileName;
    private string sessionTextField;

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!Request.IsAuthenticated || !ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()))
        //    Response.Redirect("~/Page/Errors/AccessDenied.aspx");

        fileName = Request.QueryString["file"];
        sessionTextField = "FileManagerSourceText" + fileName;        

        if (!IsPostBack)        
            ReadText();        

        SourceEditorTextBox.Focus();
    }

    private void ReadText()
    {
        if (Session[sessionTextField] != null)
        {            
            SourceEditorTextBox.Text = Session[sessionTextField].ToString();
            Session.Remove(sessionTextField);
        }
        else
            ReadFile();

        SourceEditorTextBox.Rows = Math.Max(3, SourceEditorTextBox.Text.Split('\n').Length);

        if (!String.IsNullOrEmpty(fileName))
            Title = "ويرايش فايل : " + fileName.Substring(fileName.LastIndexOf('\\') + 1);        
    }

    private void ReadFile()
    {
        string fileName = Request.QueryString["file"];
        ErrorLabel.ForeColor = Color.Black;

        if (string.IsNullOrEmpty(fileName))
        {
            SourceEditorPanel.Visible = false;
            ErrorLabel.Text = "هيچ فايلي انتخاب نشده است.";
            ErrorLabel.Visible = true;
        }
        else if (!File.Exists(fileName))
        {
            SourceEditorPanel.Visible = false;
            ErrorLabel.Text = "فايل مبدا وجود ندارد.";
            ErrorLabel.Visible = true;
        }
        else
        {
            try
            {
                SourceEditorPanel.Visible = true;
                ErrorLabel.Visible = false;

                StreamReader reader = File.OpenText(fileName);
                SourceEditorTextBox.Text = reader.ReadToEnd();
                reader.Close();
            }
            catch (Exception)
            {
                SourceEditorPanel.Visible = false;
                ErrorLabel.Text = "مشکلي در باز کردن فايل وجود دارد.";
                ErrorLabel.ForeColor = Color.Red;
                ErrorLabel.Visible = true;
            }
        }
    }

    protected void ViewSourceButton_Click(object sender, EventArgs e)
    {
        Session.Add(sessionTextField, SourceEditorTextBox.Text);        
        Response.Redirect(Page.ResolveUrl("~/Page/FileManager/SourceViewer.aspx") + Request.Url.Query);
    }

    protected void SaveSourceButton_Click(object sender, EventArgs e)
    {
        string fileName = Request.QueryString["file"];

        try
        {
            StreamWriter writer = new StreamWriter(File.Open(fileName, FileMode.Truncate));
            writer.Write(SourceEditorTextBox.Text);
            writer.Flush();
            writer.Close();

            InfoLabel.Text = "تغييرات با موفقيت ذخيره شد.";
            InfoLabel.ForeColor = Color.MediumSeaGreen;
        }
        catch (Exception)
        {
            InfoLabel.Text = "مشکلي در ذخيره کردن فايل پيش آمد.";
            InfoLabel.ForeColor = Color.Red;
        }

        InfoPanel.Visible = true;
    }
}

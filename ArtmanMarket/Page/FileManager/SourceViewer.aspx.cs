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

public partial class Page_FileManager_SourceViewer : System.Web.UI.Page
{
    private string fileName;
    private string sessionTextField;

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!Request.IsAuthenticated || !ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()))
        //    Response.Redirect("~/Page/Errors/AccessDenied.aspx");

        fileName = Request.QueryString["file"];
        sessionTextField = "FileManagerSourceText" + fileName;        

        ReadText();
    }

    private void ReadText()
    {
        if (Session[sessionTextField] != null)
            SourceViewerCodeHighlighter.Text = Session[sessionTextField].ToString();

        else
            ReadFile();

        if (!String.IsNullOrEmpty(fileName))
        {
            Title = "مشاهده فايل : " + fileName.Substring(fileName.LastIndexOf('\\') + 1);
            SourceViewerCodeHighlighter.LanguageKey = GetFormatter();
        }
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
                SourceViewerCodeHighlighter.Text = reader.ReadToEnd();
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

    private string GetFormatter()
    {
        string extension = fileName.Substring(fileName.LastIndexOf(".") + 1).ToLower();

        Hashtable extMap = new Hashtable();
        extMap["cs"] = "C#";
        extMap["vb"] = "VB.NET";
        extMap["asax"] = "HTML";
        extMap["ascx"] = "HTML";
        extMap["aspx"] = "HTML";
        extMap["asmx"] = "HTML";
        extMap["ashx"] = "HTML";
        extMap["master"] = "HTML";
        extMap["htm"] = "HTML";
        extMap["html"] = "HTML";
        extMap["xml"] = "XML";
        extMap["xsl"] = "XML";
        extMap["xsd"] = "XML";
        extMap["resx"] = "XML";
        extMap["rdlc"] = "XML";
        extMap["cd"] = "XML";
        extMap["browser"] = "XML";
        extMap["sitemap"] = "XML";
        extMap["config"] = "XML";
        extMap["wsdl"] = "XML";
        extMap["disco"] = "XML";
        extMap["discomap"] = "XML";
        extMap["css"] = "CSS";
        extMap["js"] = "JScript";
        extMap["vbs"] = "VBScript";
        extMap["ini"] = "INIFile";
        extMap["bat"] = "BatchFile";
        extMap["java"] = "Java";
        extMap["py"] = "Python";
        extMap["perl"] = "Perl";
        extMap["php"] = "PHP";
        extMap["sql"] = "SQL";

        return (extMap[extension] != null ? extMap[extension].ToString() : null);
    }

    protected void BackToEditorButton_Click(object sender, EventArgs e)
    {
        Response.Redirect(Page.ResolveUrl("~/Page/FileManager/SourceEditor.aspx") + Request.Url.Query);
    }

    protected void SaveSourceButton_Click(object sender, EventArgs e)
    {
        string fileName = Request.QueryString["file"];

        try
        {
            StreamWriter writer = new StreamWriter(File.Open(fileName, FileMode.Truncate));
            writer.Write(Session[sessionTextField].ToString());
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

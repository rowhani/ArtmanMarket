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
using System.Threading;
using System.Globalization;
using ASP;
using Winthusiasm.HtmlEditor;

public partial class Page_Product_ShowProduct : System.Web.UI.Page
{
    public string ImageToolTips;
    public string OtherImagesUrl = "~/Images/Product/nologo.gif";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(Request.QueryString["ID"]))
        {
            ErrorLabel.Text = "هيچ محصولي انتخاب نشده است.";
            ErrorPanel.Visible = true;
            return;
        }
        else if (!ShowProductSqlDataSource.Select(DataSourceSelectArguments.Empty).GetEnumerator().MoveNext())
        {
            ErrorLabel.Text = "هيچ محصولي با شماره " + Request.QueryString["ID"] + " يافت نشد.";
            ErrorPanel.Visible = true;
            return;
        }

        ErrorPanel.Visible = false;

        if (!String.IsNullOrEmpty(Request["AUTH_USER"]) && ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()))
        {
            ShowProductFormView.DefaultMode = FormViewMode.Edit;

            ShowProductFormView.FindControl("ProductNameTextBox").Focus();
            Page.Form.DefaultButton = ShowProductFormView.FindControl("UpdateProductButton_Top").UniqueID;

            CaptionLabel.Text = "ويرايش محصول";

            if (!IsPostBack)
                UpdateProductMultiView.SetActiveView(UpdatePanelView);
        }
        else
        {
            UpdateProductMultiView.SetActiveView(UpdatePanelView);

            ShowProductFormView.DefaultMode = FormViewMode.ReadOnly;
            CaptionLabel.Text = "نمايش محصول";

            IncrementProductHits();
        }
    }

    private void IncrementProductHits()
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();

            SqlCommand com = new SqlCommand("dbo.IncrementProductHits", conn);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("ID", Request.QueryString["ID"]);
            com.ExecuteNonQuery();

            conn.Close();
        }
    }

    private void PopulateCategoryDropDownList(DropDownList CategoryDropDownList, TreeNode currentNode)
    {
        string indent = "";
        for (int i = 0; i < currentNode.Depth - 1; i++)
        {
            if (i == currentNode.Depth - 2)
                indent += "|___";
            else
                indent += Server.HtmlDecode("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        }

        CategoryDropDownList.Items.Add(new ListItem(indent + currentNode.Text, currentNode.Value));

        foreach (TreeNode childNode in currentNode.ChildNodes)
            PopulateCategoryDropDownList(CategoryDropDownList, childNode);
    }

    [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
    public static AjaxControlToolkit.Slide[] GetSlides(string contextKey)
    {
        AjaxControlToolkit.Slide[] slides = default(AjaxControlToolkit.Slide[]);

        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();

            SqlCommand com = new SqlCommand("SELECT ImagesUrl FROM [Product] WHERE ID=@ID", conn);
            com.Parameters.AddWithValue("ID", contextKey);

            SqlDataReader reader = com.ExecuteReader();
            if (reader.Read())
            {
                string imagesUrl = reader["ImagesUrl"].ToString().Trim();
                string[] urlTtip = imagesUrl.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);

                slides = new AjaxControlToolkit.Slide[urlTtip.Length];
                for (int i = 0; i < urlTtip.Length; i++)
                {
                    string[] parts = urlTtip[i].Split(new string[] { "*****" }, StringSplitOptions.RemoveEmptyEntries);

                    slides[i] = new AjaxControlToolkit.Slide();
                    slides[i].ImagePath = VirtualPathUtility.ToAbsolute(parts[0]);
                    if (parts.Length > 1)
                        slides[i].Name = slides[i].Description = parts[1];
                }
            }

            reader.Close();
            conn.Close();
        }

        if (slides.Length == 1 && String.IsNullOrEmpty(slides[0].Name))
            slides[0].Name = slides[0].Description = "نمای کلی";

        return slides;
    }

    protected string GetHLinksForTags(object tags)
    {
        string[] tagsList = tags.ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
        string hlink = "";

        foreach (string tag in tagsList)
        {
            if (tag.Trim() != "")
                hlink += "<a taget=_blank href='" +
                    Page.ResolveUrl("~/Page/Product/SearchProduct.aspx?t=tag&q=") +
                    tag.Trim() + "' >" + tag.Trim() + "</a>&nbsp;&nbsp;&nbsp;";
        }

        return hlink;
    }

    protected string GetPersianDate(object date)
    {
        DateTime thisDate = DateTime.Parse(date.ToString());
        PersianCalendar jc = new PersianCalendar();

        return String.Format("{1}/{2}/{3} {4}:{5}:{6}",
                        jc.GetDayOfWeek(thisDate),
                        jc.GetYear(thisDate),
                        jc.GetMonth(thisDate),
                        jc.GetDayOfMonth(thisDate),
                        jc.GetHour(thisDate),
                        jc.GetMinute(thisDate),
                        jc.GetSecond(thisDate));
    }

    protected void CategoryDropDownList_DataBinding(object sender, EventArgs e)
    {
        do
        {
            CategorySiteMapDataSource.DataBind();
            CategoryTreeView.DataBind();
        } while (CategoryTreeView.Nodes.Count == 0);

        DropDownList CategoryDropDownList = sender as DropDownList;
        CategoryDropDownList.Items.Clear();
        if (CategoryTreeView.Nodes.Count != 0)
        {
            PopulateCategoryDropDownList(CategoryDropDownList, CategoryTreeView.Nodes[0]);
            CategoryDropDownList.Items.RemoveAt(0);
        }
        else
            CategoryDropDownList.SelectedValue = null;
    }

    protected string GetOtherImagesUrl(object urlTtip)
    {
        string[] parts = urlTtip.ToString().Split('|');
        string urls = "";

        for (int i = 0; i < parts.Length; i++)
        {
            if (parts[i] != "")
            {
                string[] ut = parts[i].Split(new string[] { "*****" }, StringSplitOptions.RemoveEmptyEntries);
                if (ut.Length > 0)
                {
                    urls += ut[0];
                    if (ut.Length > 1)
                        ImageToolTips += ut[1];

                    if (i != parts.Length - 1)
                    {
                        urls += "|";
                        ImageToolTips += "|";
                    }
                    else
                        OtherImagesUrl = ut[0];
                }
            }
        }

        return urls;
    }

    private string GetMergedImagesUrlAndTooltip(string imgUrls, string imgTtips)
    {
        string[] imagesUrl = imgUrls.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
        string[] tooltips = imgTtips.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
        string mergedImageUrlAndTooltips = "";

        for (int i = 0; i < imagesUrl.Length; i++)
        {
            string url = imagesUrl[i].Trim();
            if (url != "")
            {
                mergedImageUrlAndTooltips += url;
                if (tooltips.Length >= i + 1)
                {
                    string ttip = tooltips[i].Trim();
                    if (ttip != "")
                        mergedImageUrlAndTooltips += "*****" + ttip;
                }
                if (i != imagesUrl.Length - 1)
                    mergedImageUrlAndTooltips += "|";
            }
        }

        return mergedImageUrlAndTooltips;
    }

    protected void ShowProductFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        TextBox TooltipTextBox = Market.GlobalToolkit.FindControl(ShowProductFormView, "TooltipTextBox") as TextBox;
        ImageBrowser OtherImagesBrowser = Market.GlobalToolkit.FindControl(ShowProductFormView, "OtherImagesBrowser") as ImageBrowser;
        HtmlEditor DetailsHtmlEditor = Market.GlobalToolkit.FindControl(ShowProductFormView, "DetailsHtmlEditor") as HtmlEditor;

        if (TooltipTextBox != null && OtherImagesBrowser != null)
            e.NewValues["ImagesUrl"] = GetMergedImagesUrlAndTooltip(OtherImagesBrowser.Text.Trim(), TooltipTextBox.Text.Trim());

        if (DetailsHtmlEditor != null)
            e.NewValues["Details"] = DetailsHtmlEditor.Text;

        e.NewValues["ModifiedDate"] = DateTime.Now.ToString();
    }

    protected FormViewMode GetCommentFormMode()
    {
        try
        {
            return String.IsNullOrEmpty(Request["AUTH_USER"]) ? FormViewMode.ReadOnly : UserCommentSqlDataSource.Select(DataSourceSelectArguments.Empty).GetEnumerator().MoveNext() ? FormViewMode.Edit : FormViewMode.Insert;
        }
        catch (Exception)
        {
            return FormViewMode.ReadOnly;
        }
    }

    protected void CommentFormView_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();

            SqlCommand com = new SqlCommand("dbo.UpdateProductRate", conn);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("ID", Request.QueryString["ID"]);
            com.ExecuteNonQuery();

            conn.Close();
        }

        FormView CommentFormView = sender as FormView;
        CommentFormView.DefaultMode = FormViewMode.Edit;
        CommentFormView.DataBind();
    }

    protected void CommentFormView_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();

            SqlCommand com = new SqlCommand("dbo.UpdateProductRate", conn);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("ID", Request.QueryString["ID"]);
            com.ExecuteNonQuery();

            conn.Close();
        }
    }

    protected void UpdateProductButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
            UpdateProductMultiView.SetActiveView(UpdatePromptView);
    }

    protected void UpdateBackButton_Click(object sender, EventArgs e)
    {
        UpdateProductMultiView.SetActiveView(UpdatePanelView);
        Response.Redirect(Request.Url.PathAndQuery);
    }

    protected void DeleteProductButton_Click(object sender, EventArgs e)
    {
        UpdateProductMultiView.SetActiveView(DeletePromptView);
    }

    protected void CancelBackButton_Click(object sender, EventArgs e)
    {
        UpdateProductMultiView.SetActiveView(UpdatePanelView);

        string returnUrl = Request["ReturnUrl"];
        if (returnUrl != null)
            Response.Redirect(returnUrl);
        else
            Response.Redirect("~");

        //Response.Write("<script language='javascript'> { self.close() }</script>");
    }

    protected string GetModifiedDuration(object date)
    {
        TimeSpan diff = DateTime.Now - (DateTime)date;

        if (diff.TotalDays >= 1)
            return Math.Round(diff.TotalDays) + " روز پيش";
        else if (diff.TotalHours >= 1)
            return Math.Round(diff.TotalHours) + " ساعت پيش";
        else if (diff.TotalMinutes >= 1)
            return Math.Ceiling(diff.TotalMinutes) + " دقيقه پيش";
        else if (diff.TotalSeconds >= 1)
            return Math.Ceiling(diff.TotalSeconds) + " ثانيه پيش";
        else
            return "هم اکنون";
    }
}

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
using System.IO;

public partial class Page_Shop_Seller : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            ShopMultiView.SetActiveView(ShopManageView);

        if (!String.IsNullOrEmpty(Request["AUTH_USER"]) && ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()))
        {
            if (!String.IsNullOrEmpty(Request.QueryString["ShopID"]))
            {
                ShopFormView.DefaultMode = FormViewMode.Edit;
                CaptionLabel.Text = "ويرايش فروشگاه";
                if (!IsPostBack)
                {
                    ShopFormView.DataBind();
                    Market.GlobalToolkit.Trim(ShopFormView);
                }
                DisplayError();

                ShopFormView.FindControl("ShopNameTextBox").Focus();
                Page.Form.DefaultButton = ShopFormView.FindControl("UpdateShopButton").UniqueID;
            }
            else
            {
                ShopFormView.DefaultMode = FormViewMode.Insert;
                CaptionLabel.Text = "ساخت فروشگاه";

                ShopFormView.FindControl("ShopNameTextBox").Focus();
                Page.Form.DefaultButton = ShopFormView.FindControl("CreateShopButton").UniqueID;
            }
        }
        else
        {
            ShopFormView.DefaultMode = FormViewMode.ReadOnly;
            CaptionLabel.Text = "نمايش فروشگاه";
            if (!IsPostBack)
                ShopFormView.DataBind();
            DisplayError();
        }
    }

    protected void DisplayError()
    {
        if (String.IsNullOrEmpty(Request.QueryString["ShopID"]))
        {
            ErrorLabel.Text = "هيچ فروشگاهي انتخاب نشده است.";
            ErrorPanel.Visible = true;
        }
        else if (!ShopSqlDataSource.Select(DataSourceSelectArguments.Empty).GetEnumerator().MoveNext())
        {
            ErrorLabel.Text = "هيچ فروشگاهي با شماره " + Request.QueryString["ShopID"] + " يافت نشد.";
            ErrorPanel.Visible = true;
            return;
        }
        else
            ErrorPanel.Visible = false;
    }

    protected void UpdateShopButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
            ShopMultiView.SetActiveView(UpdateConfirmView);
        else
            ShopMultiView.SetActiveView(ShopManageView);
    }

    protected void DeleteShopButton_Click(object sender, EventArgs e)
    {
        ShopMultiView.SetActiveView(DeleteConfirmView);
    }

    protected void ReturnButton_Click(object sender, EventArgs e)
    {
        ShopMultiView.SetActiveView(ShopManageView);

        string returnUrl = Request["ReturnUrl"];
        if (returnUrl != null)
            Response.Redirect(returnUrl);
        else
            Response.Redirect(Request.Url.PathAndQuery);
    }

    protected void UpdateReturnButton_Click(object sender, EventArgs e)
    {
        ShopMultiView.SetActiveView(ShopManageView);
        Response.Redirect(Request.Url.PathAndQuery);
    }

    protected void CreateShopButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string shopID = "";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
            {
                conn.Open();

                SqlCommand com = new SqlCommand("SELECT MAX(ID) AS ShopID FROM Shop", conn);

                SqlDataReader reader = com.ExecuteReader();
                if (reader.Read())
                    shopID = reader["ShopID"].ToString();

                conn.Close();
            }

            CreateProductLinkButton.PostBackUrl = "~/Page/Product/AddProduct.aspx?ShopID=" + shopID;
            SelectProductByCategoryLinkButton.PostBackUrl = "~/Page/Product/ShowAllCategories.aspx?adshid=" + shopID;
            SelectProductBySearchLinkButton.PostBackUrl = "~/Page/Product/SearchProduct.aspx?adshid=" + shopID;

            ShopMultiView.SetActiveView(CreateConfirmView);
        }
        else
            ShopMultiView.SetActiveView(ShopManageView);
    }

    protected void ShopFormView_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        if (Request.Files.Count != 0 && Request.Files[0].FileName.Trim() != "")
        {
            string logoName = Request.Files[0].FileName;
            string logoPath = "~/Images/Shop/" + logoName;

            string newLogoPath = logoPath;
            int cnt = 1;
            while (File.Exists(Server.MapPath(newLogoPath)))
                newLogoPath = logoPath.Substring(0, logoPath.LastIndexOf(".")) + (cnt++).ToString() + logoPath.Substring(logoPath.LastIndexOf("."));

            Request.Files[0].SaveAs(Server.MapPath(newLogoPath));
            e.Values["Logo"] = newLogoPath;
        }
        else
            e.Values["Logo"] = null;
    }

    protected void ShopFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        if (Request.Files.Count != 0 && Request.Files[0].FileName.Trim() != "")
        {
            string oldLogoPath = Server.MapPath(e.OldValues["Logo"].ToString().Trim());
            if (File.Exists(oldLogoPath))
                File.Delete(oldLogoPath);

            string logoName = Request.Files[0].FileName;
            string logoPath = "~/Images/Shop/" + logoName;

            string newLogoPath = logoPath;
            int cnt = 1;
            while (File.Exists(Server.MapPath(newLogoPath)))
                newLogoPath = logoPath.Substring(0, logoPath.LastIndexOf(".")) + (cnt++).ToString() + logoPath.Substring(logoPath.LastIndexOf("."));

            Request.Files[0].SaveAs(Server.MapPath(newLogoPath));
            e.NewValues["Logo"] = newLogoPath;
        }
        else
            e.NewValues["Logo"] = e.OldValues["Logo"];
    }

    protected void ShopFormView_ItemDeleting(object sender, FormViewDeleteEventArgs e)
    {
        string logoPath = Server.MapPath(e.Values["Logo"].ToString().Trim());
        if (File.Exists(logoPath))
            File.Delete(logoPath);
    }
}

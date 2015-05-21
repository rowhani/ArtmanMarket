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

public partial class Page_Product_AddProduct : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (String.IsNullOrEmpty(Request["AUTH_USER"]) || !ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()))
        //    Response.Redirect("~/Page/Errors/AccessDenied.aspx");

        if (!IsPostBack)
        {
            if (SetShopName(Request.QueryString["ShopID"]) != null)
            {
                ShopNameLabel.Visible = true;
                ShopNameTextBox.Visible = true;
                WarrantyLabel.Visible = true;
                WarrantyTextBox.Visible = true;
                WarrantyDurationLabel.Visible = true;
                WarrantyDurationTextBox.Visible = true;
                VendorDescriptionLabel.Visible = true;
                VendorDescriptionTextBox.Visible = true;
            }
            else
            {
                ShopNameLabel.Visible = false;
                ShopNameTextBox.Visible = false;
                WarrantyLabel.Visible = false;
                WarrantyTextBox.Visible = false;
                WarrantyDurationLabel.Visible = false;
                WarrantyDurationTextBox.Visible = false;
                VendorDescriptionLabel.Visible = false;
                VendorDescriptionTextBox.Visible = false;
            }

            /*Page.ClientScript.RegisterStartupScript(this.GetType(), "SelectCategory", 
                "function OpenCategoryPopup() { window.open('" + 
                Page.ResolveUrl("~/Page/Product/SelectCategoryPopup.aspx") +
                "?tid=" + CategoryTextBox.ClientID + 
                "&vid=" + CategoryHiddenField.ClientID + "'" +
                ", 'انتخاب زيرشاخه', 'scrollbars=yes,resizable=yes,width=400,height=600');" + 
                " return false; }", true); */            
        }

        CategoryTextBox.Attributes.Add("readonly", "readonly"); //ReadOnly="true" not used to save ViewState
        
        if (AddProductWizard.ActiveStepIndex == 0)
            ProductNameTextBox.Focus();
        else if (AddProductWizard.ActiveStepIndex == 1)
            OverviewTextBox.Focus();
    }

    private string SetShopName(string id)
    {
        if (!String.IsNullOrEmpty(id))
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
            {
                conn.Open();

                SqlCommand com = new SqlCommand("SELECT Name FROM [Shop] WHERE ID=@ID", conn);
                com.Parameters.AddWithValue("ID", id);

                SqlDataReader reader = com.ExecuteReader();
                if (reader.Read())
                    ShopNameTextBox.Text = reader["Name"].ToString().Trim();

                conn.Close();
            }

            return ShopNameTextBox.Text;
        }
        else
            return null;
    }

    private string GetImagesUrlAndTooltip()
    {
        string[] imagesUrl = OtherImagesBrowser.Text.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
        string[] tooltips = TooltipTextBox.Text.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
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

    protected void AddProductWizard_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (ProductNameTextBox.Text.Trim() != "")
        {
            AddProductSqlDataSource.InsertParameters.Add("Name", TypeCode.String, ProductNameTextBox.Text);
            AddProductSqlDataSource.InsertParameters.Add("LogoImageUrl", TypeCode.String, LogoImageBrowser.Text);
            AddProductSqlDataSource.InsertParameters.Add("BrandImageUrl", TypeCode.String, BrandImageBrowser.Text);
            AddProductSqlDataSource.InsertParameters.Add("ImagesUrl", TypeCode.String, GetImagesUrlAndTooltip());
            AddProductSqlDataSource.InsertParameters.Add("MinPrice", TypeCode.Decimal, PriceTextBox.Text.Trim());
            AddProductSqlDataSource.InsertParameters.Add("MaxPrice", TypeCode.Decimal, PriceTextBox.Text.Trim());
            AddProductSqlDataSource.InsertParameters.Add("Overview", TypeCode.String, OverviewTextBox.Text);
            AddProductSqlDataSource.InsertParameters.Add("Details", TypeCode.String, DetailsHtmlEditor.Text);
            AddProductSqlDataSource.InsertParameters.Add("Tags", TypeCode.String, TagsTextBox.Text);
            AddProductSqlDataSource.InsertParameters.Add("Category_ID", TypeCode.Int32, CategoryHiddenField.Value);
            AddProductSqlDataSource.InsertParameters.Add("Rate", TypeCode.Int32, ProductRatingControl.CurrentRating.ToString());

            try
            {
                AddProductSqlDataSource.Insert();
                AddProductToShop();
                AddProductInvalidMessageLabel.Visible = false;
                AddProductMultiView.ActiveViewIndex = 1;
            }
            catch (Exception)
            {
                AddProductInvalidMessageLabel.Visible = true;
                AddProductWizard.ActiveStepIndex = 0;
                e.Cancel = true;
            }
        }
        else
        {
            AddProductInvalidMessageLabel.Visible = true;
            AddProductWizard.ActiveStepIndex = 0;
            e.Cancel = true;
        }
    }

    protected void AddProductToShop()
    {
        if (!String.IsNullOrEmpty(ShopNameTextBox.Text))
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
            {
                conn.Open();

                SqlCommand com = new SqlCommand("SELECT MAX(ID) AS ProductID FROM Product", conn);
                SqlDataReader reader = com.ExecuteReader();

                string productID = "";
                if (reader.Read())
                    productID = reader["ProductID"].ToString();

                com = new SqlCommand("INSERT INTO [Product_Shop] (Product_ID, Shop_ID, Price, Warranty, WarrantyDuration, Description) VALUES (@Product_ID, @Shop_ID, @Price, @Warranty, @WarrantyDuration, @Description)", conn);
                com.Parameters.AddWithValue("Product_ID", productID);
                com.Parameters.AddWithValue("Shop_ID", Request.QueryString["ShopID"]);
                com.Parameters.AddWithValue("Price", PriceTextBox.Text.Trim());
                com.Parameters.AddWithValue("Warranty", WarrantyTextBox.Text.Trim());
                com.Parameters.AddWithValue("WarrantyDuration", WarrantyDurationTextBox.Text.Trim());
                com.Parameters.AddWithValue("Description", VendorDescriptionTextBox.Text.Trim());
                com.ExecuteNonQuery();

                conn.Close();
            }
        }
    }

    protected void AddProductWizard_ActiveStepChanged(object sender, EventArgs e)
    {
        AddProductInvalidMessageLabel.Visible = false;

        if (AddProductWizard.FindControl("StartNavigationTemplateContainerID$StartNextButton") != null)
            Page.Form.DefaultButton = AddProductWizard.FindControl("StartNavigationTemplateContainerID$StartNextButton").UniqueID;
        else if (AddProductWizard.FindControl("StepNavigationTemplateContainerID$StepNextButton") != null)
            Page.Form.DefaultButton = AddProductWizard.FindControl("StepNavigationTemplateContainerID$StepNextButton").UniqueID;
        else if (AddProductWizard.FindControl("FinishNavigationTemplateContainerID$FinishButton") != null)
            Page.Form.DefaultButton = AddProductWizard.FindControl("FinishNavigationTemplateContainerID$FinishButton").UniqueID;
    }

    protected void BackButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Page/Product/AddProduct.aspx");
    }
}

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

public partial class Page_Product_SearchProduct : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(Request["q"]))
        {
            SearchProductOverviewPanel.Visible = false;
            NotFoundLabel.Visible = false;
            NameTextBox.Focus();
            return;
        }

        string name = Request["q"].Trim(); //!String.IsNullOrEmpty(Request["q"]) ? Request["q"].Trim() : "";
        decimal minPrice;
        decimal maxPrice;

        SearchProductOverviewPanel.SqlSelectQuery = "SELECT Product.ID, Name, LogoImageUrl, BrandImageUrl, ImagesUrl, ModifiedDate, MinPrice, MaxPrice, Overview, Details, Tags, Rate, Hits, Category_ID, CreatedDate, Category.ID as CatID, Title FROM Product INNER JOIN Category ON Product.Category_ID=Category.ID" +
            " WHERE (Product.Name LIKE N'%" + name + "%' OR Category.Title LIKE N'%" + name + "%') " +
            (!String.IsNullOrEmpty(Request["tag"]) ? " AND Product.Tags LIKE N'%" + Request["tag"].Trim() + "%' " : "") +
            (!String.IsNullOrEmpty(Request["min"]) ? (Decimal.TryParse(Request["min"].Trim(), out minPrice) ? " AND Product.MinPrice >= " + minPrice : "") : "") +
            (!String.IsNullOrEmpty(Request["max"]) ? (Decimal.TryParse(Request["max"].Trim(), out maxPrice) ? " AND Product.MaxPrice <= " + maxPrice : "") : "") +
            " ORDER BY ModifiedDate DESC, Name ASC";
        SearchProductOverviewPanel.SqlRecordCountQuery = null;

        if (!IsPostBack)
            DataBind();

        NameTextBox.Focus();
    }

    protected void SearchButton_Click(object sender, EventArgs e)
    {
        string url = "~/Page/Product/SearchProduct.aspx?" +
            "q=" + NameTextBox.Text.Trim() +
            "&tag=" + TagTextBox.Text.Trim() +
            "&max=" + MaxPriceTextBox.Text.Trim() +
            "&min=" + MinPriceTextBox.Text.Trim();

        foreach (string key in Request.QueryString.Keys)
            if (key != "q" && key != "tag" && key != "max" & key != "min")
                url += "&" + key + "=" + Request.QueryString[key];

        Response.Redirect(url);
    }
}

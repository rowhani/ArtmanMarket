/// <author> Payman Rowhani </author>
/// <copyright> Copyright© 2004-2011, Artman Systems Inc. </copyright>
/// 
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

public partial class WebControls_Product_ProductList : System.Web.UI.UserControl
{
    private string _sqlSelectQuery = "SELECT ID, Name, LogoImageUrl, BrandImageUrl, ImagesUrl, ModifiedDate, MinPrice, MaxPrice, Overview, Details, Tags, Rate, Hits, Category_ID, CreatedDate FROM Product";
    private int _maxNumOfRecords = Int32.MaxValue;
    private int _numOfItemsPerPage = 6;
    private string _titleText = "";
    private string _titleLogoUrl = "";
    private bool _productCountLabelVisible = true;

    public string SqlSelectQuery
    {
        get { return _sqlSelectQuery; }
        set { _sqlSelectQuery = value; }
    }

    public int NumOfRecords
    {
        get
        {
            UpdatedProductOverviewPanel.SqlSelectQuery = SqlSelectQuery + " ORDER BY ModifiedDate DESC";
            return UpdatedProductOverviewPanel.NumOfRecords;
        }
    }

    public int MaxNumOfRecords
    {
        get { return _maxNumOfRecords; }
        set { _maxNumOfRecords = value; }
    }

    public int NumOfItemsPerPage
    {
        get { return _numOfItemsPerPage; }
        set { _numOfItemsPerPage = value; }
    }

    public string TitleText
    {
        get { return _titleText; }
        set { _titleText = value; }
    }

    public string TitleLogoUrl
    {
        get { return _titleLogoUrl; }
        set { _titleLogoUrl = value; }
    }

    public bool ProductCountLabelVisible
    {
        get { return _productCountLabelVisible; }
        set { _productCountLabelVisible = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            HeaderPanel.DataBind();

        UpdatedProductOverviewPanel.MaxNumOfRecords = MaxNumOfRecords;
        MostRatedProductOverviewPanel.MaxNumOfRecords = MaxNumOfRecords;
        MostViewedProductOverviewPane.MaxNumOfRecords = MaxNumOfRecords;
        NewestProductOverviewPanel.MaxNumOfRecords = MaxNumOfRecords;

        UpdatedProductOverviewPanel.NumOfItemsPerPage = NumOfItemsPerPage;
        MostRatedProductOverviewPanel.NumOfItemsPerPage = NumOfItemsPerPage;
        MostViewedProductOverviewPane.NumOfItemsPerPage = NumOfItemsPerPage;
        NewestProductOverviewPanel.NumOfItemsPerPage = NumOfItemsPerPage;

        UpdatedProductOverviewPanel.ProductCountLabelVisible = ProductCountLabelVisible;
        MostRatedProductOverviewPanel.ProductCountLabelVisible = ProductCountLabelVisible;
        MostViewedProductOverviewPane.ProductCountLabelVisible = ProductCountLabelVisible;
        NewestProductOverviewPanel.ProductCountLabelVisible = ProductCountLabelVisible;

        UpdatedProductOverviewPanel.SqlSelectQuery = SqlSelectQuery + " ORDER BY ModifiedDate DESC";
        MostRatedProductOverviewPanel.SqlSelectQuery = SqlSelectQuery + " ORDER BY Hits DESC";
        MostViewedProductOverviewPane.SqlSelectQuery = SqlSelectQuery + " ORDER BY Rate DESC";
        NewestProductOverviewPanel.SqlSelectQuery = SqlSelectQuery + " ORDER BY ID DESC"; //ORDER BY CreatedDate DESC 

        if (NumOfRecords == 0)
            ProductListPanel.Visible = false;
    }
}

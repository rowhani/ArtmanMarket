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
using Wuqi.Webdiyer;

public partial class WebControls_Product_ProductOverviewPanel : System.Web.UI.UserControl
{
    private ArrayList _checkBoxControls = new ArrayList();

    private string _tableName = "Product";
    private string _sqlSelectQuery = "SELECT * FROM [Product]";
    private string _sqlRecordCountQuery = null;
    private string _titleText = "عنوان";
    private string _titleLogoUrl = "";
    private int _maxNumOfRecords = Int32.MaxValue;
    private int _numOfItemsPerPage = 6;
    private bool _productCountLabelVisible = true;
    private bool? _isShopValid = null;
    private string _shopName = null;

    public string TableName
    {
        get { return _tableName; }
        set { _tableName = value; }
    }

    public string SqlSelectQuery
    {
        get { return _sqlSelectQuery; }
        set { _sqlSelectQuery = value; }
    }

    public string SqlRecordCountQuery
    {
        get { return _sqlRecordCountQuery; }
        set { _sqlRecordCountQuery = value; }
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

    public int MaxNumOfRecords
    {
        get { return _maxNumOfRecords; }
        set { _maxNumOfRecords = value; }
    }

    public int NumOfItemsPerPage
    {
        get { return _numOfItemsPerPage; }

        set
        {
            if (value <= 0)
                value = 3;
            else if (value % 3 == 1)
                value -= 1;
            else if (value % 3 == 2)
                value += 1;
            if (value > 18)
                value = 18;

            _numOfItemsPerPage = value;
        }
    }

    public bool ProductCountLabelVisible
    {
        get { return _productCountLabelVisible; }
        set { _productCountLabelVisible = value; }
    }

    public bool IsShopValid
    {
        get
        {
            CheckForValidShop();
            return (bool)_isShopValid;
        }
        set { _isShopValid = value; }
    }

    public string ShopName
    {
        get { return _shopName; }
        set { _shopName = value; }
    }

    public int NumOfRecords
    {
        get
        {
            SetSqlRecordCountQuery();
            int result;

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
            {
                conn.Open();
                SqlCommand com = new SqlCommand(SqlRecordCountQuery, conn);
                result = Math.Min((int)com.ExecuteScalar(), MaxNumOfRecords);
                conn.Close();
            }

            return result;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            SetRecordCount();
    }

    private void SetRecordCount()
    {
        SetSqlRecordCountQuery();
        CalculateRecordCount();
    }

    private void SetSqlRecordCountQuery()
    {
        if (SqlRecordCountQuery == null)
        {
            string whereClause = "";
            if (SqlSelectQuery.IndexOf("WHERE", StringComparison.CurrentCultureIgnoreCase) != -1)
            {
                whereClause = SqlSelectQuery.Substring(SqlSelectQuery.IndexOf(" FROM ", StringComparison.CurrentCultureIgnoreCase));
                if (whereClause.IndexOf("ORDER", StringComparison.CurrentCultureIgnoreCase) != -1)
                    whereClause = whereClause.Substring(0, whereClause.IndexOf("ORDER", StringComparison.CurrentCultureIgnoreCase));
            }
            else
                whereClause = " FROM " + TableName;

            SqlRecordCountQuery = "SELECT COUNT (*) " + whereClause;
        }
    }

    private void CalculateRecordCount()
    {
        NumOfItemsPanel.Visible = true;

        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();
            SqlCommand com = new SqlCommand(SqlRecordCountQuery, conn);

            ProductPager.RecordCount = Math.Min((int)com.ExecuteScalar(), MaxNumOfRecords);
            if (ProductPager.RecordCount == 0)
            {
                this.Visible = false;
                return;
            }
            else if (ProductPager.RecordCount <= 3)
                NumOfItemsPanel.Visible = false;

            ProductPager.PageSize = NumOfItemsPerPage;
            //ProductPager.AlwaysShow = true;
            conn.Close();
        }

        DataBind();
    }

    public override void DataBind()
    {
        base.DataBind();

        _checkBoxControls.Clear();

        SqlDataAdapter dataAdapter = new SqlDataAdapter(SqlSelectQuery, ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString);
        DataSet dataSet = new DataSet();
        dataAdapter.Fill(dataSet, ProductPager.PageSize * (ProductPager.CurrentPageIndex - 1), ProductPager.PageSize, TableName);

        ProductDataList.DataSource = dataSet.Tables[TableName];
        ProductDataList.DataBind();
    }

    protected void ProductPager_PageChanging(object sender, PageChangingEventArgs e)
    {
        ProductPager.CurrentPageIndex = e.NewPageIndex;
        NumOfItemsPerPage = ProductPager.PageSize;
        DataBind();
    }

    protected string GetTrimmedImageUrl(object url, string type)
    {
        string imgUrl = url as string;
        if (imgUrl != null)
            imgUrl = imgUrl.Trim();

        if (!String.IsNullOrEmpty(imgUrl))
            return imgUrl;
        else
        {
            if (type == "brand")
                return "~/Images/Product/nobrand.gif";
            else if (type == "logo")
                return "~/Images/Product/nologo.gif";
            else
                return "";
        }
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

    protected bool ShouldDisplayNewIcon(object date)
    {
        TimeSpan diff = DateTime.Now - (DateTime)date;
        return (diff.TotalDays <= 1);
    }

    protected void CheckForValidShop()
    {
        if (_isShopValid != null)
            return;

        string shopID = Request.QueryString["adshid"];

        if (!String.IsNullOrEmpty(shopID))
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
            {
                conn.Open();

                SqlCommand com = new SqlCommand("SELECT * FROM Shop WHERE ID=" + shopID, conn);
                SqlDataReader reader = com.ExecuteReader();

                if ((IsShopValid = reader.Read()))
                    ShopName = reader["Name"].ToString().Trim();

                conn.Close();
            }
        }
        else
            IsShopValid = false;
    }

    protected bool IsAdministrator()
    {
        return !(String.IsNullOrEmpty(Request["AUTH_USER"]) || !ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()));
    }

    protected bool ShouldDisplayDeleteOrAddAllButton()
    {
        return (ProductPager.RecordCount != 0) && IsAdministrator();
    }

    protected string GetClientDeleteOrAddFunction(string type)
    {
        return "javascript: return CheckForSelectedProducts(" + ProductDataList.ClientID + "_CheckBoxIDs" + ", '" + type + "');";
    }

    protected void DeleteCheckBox_Load(object sender, EventArgs e)
    {
        _checkBoxControls.Add(sender);
        Page.ClientScript.RegisterArrayDeclaration(ProductDataList.ClientID + "_CheckBoxIDs", String.Format("'{0}'", ((CheckBox)sender).ClientID));
    }

    protected void DeleteProduct(string id, SqlConnection connection)
    {
        try
        {
            SqlConnection conn = connection;
            if (connection == null)
            {
                conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString);
                conn.Open();
            }

            SqlCommand com = new SqlCommand("DELETE FROM " + TableName + " WHERE ID=" + id, conn);
            com.ExecuteNonQuery();

            if (connection == null)
                conn.Close();
        }
        catch (Exception)
        {
        }
    }

    protected void DeleteImageButton_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton DeleteImageButton = (ImageButton)sender;
        DeleteProduct(DeleteImageButton.CommandArgument, null);

        NumOfItemsPerPage = ProductPager.PageSize;
        CalculateRecordCount();
    }

    protected void DeleteAllButton_Click(object sender, EventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();
            foreach (CheckBox chk in _checkBoxControls)
            {
                if (chk.Checked)
                    DeleteProduct(chk.Attributes["value"], conn);
            }
            conn.Close();
        }

        NumOfItemsPerPage = ProductPager.PageSize;
        CalculateRecordCount();
    }

    protected void AddToShopImageButton_DataBinding(object sender, EventArgs e)
    {
        ImageButton AddToShopImageButton = (ImageButton)sender;

        if (IsProductExistingInShop(AddToShopImageButton.CommandArgument, Request.QueryString["adshid"], null))
        {
            AddToShopImageButton.Enabled = false;
            AddToShopImageButton.Attributes["disabled"] = "disabled";
            AddToShopImageButton.CssClass = "disabledImageButton";
            AddToShopImageButton.ToolTip = "اين محصول در فروشگاه موجود است";
        }
    }

    protected bool IsProductExistingInShop(string productID, string shopID, SqlConnection connection)
    {
        if (String.IsNullOrEmpty(productID) || String.IsNullOrEmpty(shopID))
            return false;

        SqlConnection conn = connection;
        if (connection == null)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString);
            conn.Open();
        }

        SqlCommand com = new SqlCommand("SELECT COUNT(*) FROM Product_Shop WHERE Product_ID=" + productID + " AND Shop_ID=" + shopID, conn);
        bool result = (((int)com.ExecuteScalar()) > 0);

        if (connection == null)
            conn.Close();

        return result;
    }

    protected void AddProductToShop(string productID, string shopID, SqlConnection connection)
    {
        SqlConnection conn = connection;
        if (connection == null)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString);
            conn.Open();
        }

        if (!IsProductExistingInShop(productID, shopID, conn))
        {
            SqlCommand com = new SqlCommand("INSERT INTO Product_Shop (Product_ID, Shop_ID, Price, Warranty, WarrantyDuration, Description) VALUES (@Product_ID, @Shop_ID, @Price, @Warranty, @WarrantyDuration, @Description)", conn);
            com.Parameters.AddWithValue("Product_ID", productID);
            com.Parameters.AddWithValue("Shop_ID", shopID);

            foreach (DataListItem item in ProductDataList.Items)
            {
                string key = ProductDataList.DataKeys[item.ItemIndex].ToString();

                if (key == productID)
                {
                    com.Parameters.AddWithValue("Price", (item.FindControl("PriceTextBox") as TextBox).Text);
                    com.Parameters.AddWithValue("Warranty", (item.FindControl("WarrantyTextBox") as TextBox).Text);
                    com.Parameters.AddWithValue("WarrantyDuration", (item.FindControl("WarrantyDurationTextBox") as TextBox).Text);
                    com.Parameters.AddWithValue("Description", (item.FindControl("VendorDescriptionTextBox") as TextBox).Text);

                    break;
                }
            }

            try
            {
                com.ExecuteNonQuery();

                com = new SqlCommand("dbo.UpdateProductPrice", conn);
                com.Parameters.AddWithValue("ID", productID);
                com.CommandType = CommandType.StoredProcedure;
                com.ExecuteNonQuery();
            }
            catch (Exception)
            {
            }
        }

        if (connection == null)
            conn.Close();
    }

    protected void AddToShopImageButton_Click(object sender, EventArgs e)
    {
        ImageButton AddToShopImageButton = (ImageButton)sender;
        AddProductToShop(AddToShopImageButton.CommandArgument, Request.QueryString["adshid"], null);

        NumOfItemsPerPage = ProductPager.PageSize;
        DataBind();
    }

    protected void AddAllToShopButton_Click(object sender, EventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();
            foreach (CheckBox chk in _checkBoxControls)
            {
                if (chk.Checked)
                    AddProductToShop(chk.Attributes["value"], Request.QueryString["adshid"], conn);
            }
            conn.Close();
        }

        NumOfItemsPerPage = ProductPager.PageSize;
        DataBind();
    }

    protected void NumOfItemsDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList NumOfItemsDropDownList = sender as DropDownList;
        if (NumOfItemsDropDownList.SelectedValue != null)
        {
            NumOfItemsPerPage = Int32.Parse(NumOfItemsDropDownList.SelectedValue.Trim());
            ProductPager.PageSize = NumOfItemsPerPage;
            ProductPager.CurrentPageIndex = 1;
            DataBind();
        }
    }
}

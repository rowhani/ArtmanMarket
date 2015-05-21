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

public partial class Page_Product_ShowCategory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string catID = !String.IsNullOrEmpty(Request["catid"]) ? Request["catid"].Trim() : "";

        if (catID == "")
        {
            NotFoundLabel.Text = "هيچ زيرشاخه اي انتخاب نشده است.";
            NotFoundLabel.Visible = true;
            ShowCategoryProductList.Visible = false;
            SubCategoryListPanel.Visible = false;
            return;
        }

        if (!IsPostBack)
            DataBind();

        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();

            SqlCommand com = new SqlCommand("SELECT * FROM [Category] WHERE ID=@ID", conn);
            com.Parameters.AddWithValue("ID", catID);
            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                string catTitle = reader["Title"].ToString().Trim();
                reader.Close();
                ShowCategoryProductList.TitleText = "زيرشاخه " + catTitle;

                ShowCategoryProductList.SqlSelectQuery = "SELECT ID, Name, LogoImageUrl, BrandImageUrl, ImagesUrl, ModifiedDate, MinPrice, MaxPrice, Overview, Details, Tags, Rate, Hits, Category_ID, CreatedDate FROM Product WHERE Category_ID=" + catID; //"SELECT Product.ID, Name, LogoImageUrl, BrandImageUrl, ImagesUrl, ModifiedDate, MinPrice, MaxPrice, Overview, Details, Tags, Rate, Hits, Category_ID, CreatedDate FROM Product INNER JOIN Category ON Product.Category_ID=Category.ID WHERE Category.ID=" + catID;
                //ShowCategoryProductList.SqlRecordCountQuery = null;

                if (ShowCategoryProductList.NumOfRecords == 0)
                {
                    com = new SqlCommand("SELECT * FROM [Category] WHERE Parent_ID=@Parent_ID", conn);
                    com.Parameters.AddWithValue("Parent_ID", catID);
                    reader = com.ExecuteReader();

                    if (reader.Read())
                    {
                        SubCategoryListPanel.Visible = true;
                        SubCategoryListTitleLabel.Text = "ليست زيرشاخه هاي " + catTitle;

                        string qs = "";
                        foreach (string key in Request.QueryString.AllKeys)
                            if (key != "catid")
                                qs += ("&" + key + "=" + Request.QueryString[key]);

                        do
                        {
                            ListItem subCat = new ListItem();
                            subCat.Text = reader["Title"].ToString();
                            subCat.Value = Page.ResolveUrl("~/Page/Product/ShowCategory.aspx") + "?catid=" + reader["ID"].ToString() + qs;

                            SubCategoryBulletedList.Items.Add(subCat);
                        } while (reader.Read());

                        reader.Close();
                    }
                    else
                        SubCategoryListPanel.Visible = false;
                }
            }
            else
            {
                NotFoundLabel.Text = "هيچ زيرشاخه اي با شماره [" + catID + "] وجود ندارد.";
                NotFoundLabel.Visible = true;
                ShowCategoryProductList.Visible = false;
                SubCategoryListPanel.Visible = false;
            }

            conn.Close();
        }
    }
}

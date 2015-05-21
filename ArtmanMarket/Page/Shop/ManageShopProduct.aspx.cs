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

public partial class Page_Shop_ManageShopProduct : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!Request.IsAuthenticated || !ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()))
        //    Response.Redirect("~/Page/Errors/AccessDenied.aspx");

        if (!IsPostBack)
        {
            string shopID = !String.IsNullOrEmpty(Request.QueryString["ShopID"]) ? Request.QueryString["ShopID"].Trim() : "";

            if (shopID == "")
            {
                ErrorLabel.Text = "هيچ فروشگاهي انتخاب نشده است.";
                ErrorLabel.Visible = true;
                ManageShopProductUpdatePanel.Visible = false;
                return;
            }
            else
            {
                DataBind();

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
                {
                    conn.Open();

                    SqlCommand com = new SqlCommand("SELECT * FROM Shop WHERE ID=@ID", conn);
                    com.Parameters.AddWithValue("ID", shopID);
                    SqlDataReader reader = com.ExecuteReader();

                    if (reader.Read())
                    {
                        ShopHyperLink.NavigateUrl = "~/Page/Shop/Seller.aspx?ShopID=" + shopID;
                        ShopHyperLink.Text = ShopImage.ToolTip = "فروشگاه " + reader["Name"].ToString().Trim();
                        string logo = reader["Logo"].ToString().Trim();
                        if (logo != "")
                            ShopImage.ImageUrl = logo;

                        ManageShopProductSqlDataSource.DataBind();
                        if (!ManageShopProductSqlDataSource.Select(DataSourceSelectArguments.Empty).GetEnumerator().MoveNext())
                        {
                            ErrorLabel.Text = "هيچ کالايي در اين فروشگاه وجود ندارد.";
                            ErrorLabel.Visible = true;
                            //ManageShopProductUpdatePanel.Visible = false;
                        }
                    }
                    else
                    {
                        ErrorLabel.Text = "هيچ فروشگاهي با شماره [" + shopID + "] وجود ندارد.";
                        ErrorLabel.Visible = true;
                        //ManageShopProductUpdatePanel.Visible = false;
                    }

                    reader.Close();

                    conn.Close();
                }
            }
        }
    }

    protected void ManageShopProductGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        e.NewValues["ModifiedDate"] = DateTime.Now.ToString();
    }

    protected void ManageShopProductGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();

            SqlCommand com = new SqlCommand("dbo.UpdateProductPrice", conn);
            com.Parameters.AddWithValue("ID", e.Keys["Product_ID"].ToString());
            com.CommandType = CommandType.StoredProcedure;
            com.ExecuteNonQuery();

            conn.Close();
        }
    }

    protected void ManageShopProductGridView_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();

            SqlCommand com = new SqlCommand("dbo.UpdateProductPrice", conn);
            com.Parameters.AddWithValue("ID", e.Keys["Product_ID"].ToString());
            com.CommandType = CommandType.StoredProcedure;
            com.ExecuteNonQuery();

            conn.Close();
        }
    }
}

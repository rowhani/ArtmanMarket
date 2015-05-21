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

public partial class Page_Shop_ShowShopProduct : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string shopID = !String.IsNullOrEmpty(Request.QueryString["ShopID"]) ? Request.QueryString["ShopID"].Trim() : "";

            if (shopID == "")
            {
                ErrorLabel.Text = "هيچ فروشگاهي انتخاب نشده است.";
                ErrorLabel.Visible = true;
                ShowShopProductUpdatePanel.Visible = false;
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

                        ShowShopProductSqlDataSource.DataBind();
                        if (!ShowShopProductSqlDataSource.Select(DataSourceSelectArguments.Empty).GetEnumerator().MoveNext())
                        {
                            ErrorLabel.Text = "هيچ کالايي در اين فروشگاه وجود ندارد.";
                            ErrorLabel.Visible = true;
                            ShowShopProductUpdatePanel.Visible = false;
                        }
                    }
                    else
                    {
                        ErrorLabel.Text = "هيچ فروشگاهي با شماره [" + shopID + "] وجود ندارد.";
                        ErrorLabel.Visible = true;
                        ShowShopProductUpdatePanel.Visible = false;
                    }

                    reader.Close();

                    conn.Close();
                }
            }
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
            return Math.Round(diff.TotalMinutes) + " دقيقه پيش";
        else if (diff.TotalSeconds >= 1)
            return Math.Round(diff.TotalSeconds) + " ثانيه پيش";
        else
            return "هم اکنون";
    }
}

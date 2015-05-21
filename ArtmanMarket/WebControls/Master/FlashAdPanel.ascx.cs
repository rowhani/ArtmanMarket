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

public partial class WebControls_Master_FlashAdPanel : System.Web.UI.UserControl
{
    private bool _showAdminPanel = true;

    public bool ShowAdminPanel
    {
        get { return _showAdminPanel; }
        set { _showAdminPanel = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            DataBind();
    }

    protected void MoveUpImageButton_DataBinding(object sender, EventArgs e)
    {
        ImageButton MoveUpImageButton = (ImageButton)sender;
        string[] data = MoveUpImageButton.CommandArgument.Split(',');

        if (data[1] == "1")
        {
            MoveUpImageButton.Enabled = false;
            MoveUpImageButton.Attributes["disabled"] = "disabled";
            MoveUpImageButton.CssClass = "disabledImageButton";
            MoveUpImageButton.ToolTip = "غير فعال";
        }
    }

    protected void MoveDownImageButton_DataBinding(object sender, EventArgs e)
    {
        ImageButton MoveDownImageButton = (ImageButton)sender;
        string[] data = MoveDownImageButton.CommandArgument.Split(',');

        if (data[1] == data[2])
        {
            MoveDownImageButton.Enabled = false;
            MoveDownImageButton.Attributes["disabled"] = "disabled";
            MoveDownImageButton.CssClass = "disabledImageButton";
            MoveDownImageButton.ToolTip = "غير فعال";
        }
    }

    protected void MoveUpImageButton_Click(object sender, ImageClickEventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            ImageButton MoveUpImageButton = sender as ImageButton;
            string[] data = MoveUpImageButton.CommandArgument.Split(',');

            conn.Open();

            SqlCommand com = new SqlCommand("dbo.MoveUpAd", conn);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("ID", data[0]);
            com.ExecuteNonQuery();

            conn.Close();
        }

        FlashAdDataList.DataBind();
    }

    protected void MoveDownImageButton_Click(object sender, ImageClickEventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            ImageButton MoveDownImageButton = sender as ImageButton;
            string[] data = MoveDownImageButton.CommandArgument.Split(',');

            conn.Open();

            SqlCommand com = new SqlCommand("dbo.MoveDownAd", conn);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("ID", data[0]);
            com.ExecuteNonQuery();

            conn.Close();
        }

        FlashAdDataList.DataBind();
    }

    protected void DeleteImageButton_Click(object sender, ImageClickEventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            ImageButton DeleteImageButton = sender as ImageButton;
            string[] data = DeleteImageButton.CommandArgument.Split('*');

            conn.Open();

            SqlCommand com = new SqlCommand("dbo.DeleteFlashAd", conn);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("ID", data[0]);
            com.ExecuteNonQuery();

            conn.Close();

            string flashAdPath = Server.MapPath(data[1].ToString().Trim());
            if (File.Exists(flashAdPath))
                File.Delete(flashAdPath);
        }

        FlashAdDataList.DataBind();
    }

    protected void AdFlashAddImageButton_Click(object sender, EventArgs e)
    {
        if (AdFlashAddFileUpload.HasFile)
        {
            string adPath = "~/Images/Ads/Com/" + AdFlashAddFileUpload.FileName;

            string newAdPath = adPath;
            int cnt = 1;
            while (File.Exists(Server.MapPath(newAdPath)))
                newAdPath = adPath.Substring(0, adPath.LastIndexOf(".")) + (cnt++).ToString() + adPath.Substring(adPath.LastIndexOf("."));

            AdFlashAddFileUpload.SaveAs(Server.MapPath(newAdPath));

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
            {
                conn.Open();

                SqlCommand com = new SqlCommand("dbo.AddFlashAd", conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("AdUrl", newAdPath);
                com.Parameters.AddWithValue("WebsiteUrl", AdFlashWebsiteTextBox.Text.Trim());
                com.ExecuteNonQuery();

                conn.Close();
            }

            Response.Redirect(Request.Url.PathAndQuery); //Prevent resending of data on refresh
        }
    }
}

/// <author> Payman Rowhani </author>
/// <copyright> Copyright© 2004-2011, Artman Systems Inc. </copyright>

using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Specialized;

public class NewsProvider : StaticSiteMapProvider
{
    private readonly object siteMapLock = new object();
    private SiteMapNode root = null;

    public override SiteMapNode RootNode
    {
        get { return root; }
    }

    protected override SiteMapNode GetRootNodeCore()
    {
        if (RootNode != null)
            return RootNode;
        else
            return BuildSiteMap();
    }

    public override SiteMapNode BuildSiteMap()
    {
        lock (siteMapLock)
        {
            base.Clear();
            Clear();

            root = new SiteMapNode(this, "", "", "");
            AddNode(root);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
            {
                conn.Open();
                SqlCommand com = new SqlCommand("SELECT * FROM [NewsFeed] ORDER BY ID", conn);
                SqlDataReader reader = com.ExecuteReader();

                while (reader.Read())
                {
                    string key = reader["ID"].ToString();
                    string url = "~/Page/News.aspx?ID=" + key;
                    string title = ":: " + reader["Title"].ToString().Trim();

                    SiteMapNode node = new SiteMapNode(this, key, url, title);
                    AddNode(node, root);
                }

                conn.Close();
            }

            return root;
        }
    }
}
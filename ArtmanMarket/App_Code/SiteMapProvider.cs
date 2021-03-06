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

public class SiteMapProvider : StaticSiteMapProvider
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

            Hashtable nodeMap = new Hashtable();

            root = new SiteMapNode(this, "0", "", "شاخه اصلي");
            nodeMap["0"] = root;
            AddNode(root);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
            {
                conn.Open();
                SqlCommand com = new SqlCommand("SELECT * FROM [Category] ORDER BY ID", conn);
                SqlDataReader reader = com.ExecuteReader();

                while (reader.Read())
                {
                    string id = reader["ID"].ToString();
                    string parent = reader["Parent_ID"].ToString();
                    string title = reader["Title"].ToString().Trim();
                    string url = reader["URL"].ToString().Trim();

                    if (url == "")
                        url = "~/Page/Product/ShowCategory.aspx?catid=" + id;

                    nodeMap[id] = new SiteMapNode(this, id, url, title);
                    AddNode(nodeMap[id] as SiteMapNode, nodeMap[parent] as SiteMapNode);
                }

                conn.Close();
            }

            return root;
        }
    }
}

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
using System.IO;

public class FileManagerProvider : StaticSiteMapProvider
{
    private readonly object siteMapLock = new object();
    private SiteMapNode root = null;
    string rootDirectory = System.Web.Hosting.HostingEnvironment.MapPath("~");

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

            root = new SiteMapNode(this,
                "",
                ResolveUrl("~/Page/FileManager/ResourceManager.aspx"),
                "Root");
            AddNode(root);

            root = new SiteMapNode(this,
                rootDirectory,
                ResolveUrl("~/Page/FileManager/ResourceManager.aspx") + "?folder=" + UrlEncode(rootDirectory),
                "Root");
            AddNode(root);

            BuildSiteMap(rootDirectory, root);

            return root;
        }
    }

    public void BuildSiteMap(string curDir, SiteMapNode parent)
    {
        try
        {
            foreach (string directory in Directory.GetDirectories(curDir))
            {
                DirectoryInfo dirInfo = new DirectoryInfo(directory);
                string dirName = dirInfo.Name;
                string dirPath = Path.Combine(parent.Key, dirName);
                string dirUrl = ResolveUrl("~/Page/FileManager/ResourceManager.aspx") + "?folder=" + UrlEncode(dirPath);

                SiteMapNode node = new SiteMapNode(this, dirPath, dirUrl, dirName);
                AddNode(node, parent);

                if (dirInfo.GetDirectories().Length != 0)
                    BuildSiteMap(dirPath, node);
            }
        }
        catch (UnauthorizedAccessException)
        {

        }
    }

    private string UrlEncode(string url)
    {
        string encUrl = url;

        encUrl = encUrl.Replace("%", "%24");
        encUrl = encUrl.Replace(" ", "%20");
        encUrl = encUrl.Replace("!", "%21");
        encUrl = encUrl.Replace("#", "%22");
        encUrl = encUrl.Replace("$", "%23");
        encUrl = encUrl.Replace("&", "%25");
        encUrl = encUrl.Replace("'", "%26");
        encUrl = encUrl.Replace(":", "%3A");
        encUrl = encUrl.Replace(";", "%3B");
        encUrl = encUrl.Replace("<", "%3C");
        encUrl = encUrl.Replace("=", "%3D");
        encUrl = encUrl.Replace(">", "%3E");
        encUrl = encUrl.Replace("?", "%3F");
        encUrl = encUrl.Replace("\\", "%5C");

        return encUrl;
    }

    private string ResolveUrl(string url)
    {
        string[] pathSections = rootDirectory.Split('\\');
        string baseDir = pathSections[pathSections.Length - 1] != "" ? pathSections[pathSections.Length - 1] : pathSections[pathSections.Length - 2];
        return url.Replace("~", "/" + baseDir);
    }
}

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

public partial class Page_Product_ManageCategory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (String.IsNullOrEmpty(Request["AUTH_USER"]) || !ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()))
        //    Response.Redirect("~/Page/Errors/AccessDenied.aspx");

        if (!IsPostBack)
        {
            DataBind();

            do
            {
                CategorySiteMapDataSource.DataBind();
                CategoryTreeView.DataBind();
            } while (CategoryTreeView.Nodes.Count == 0);

            if (Session["AddedCatNode"] != null)
                Session.Remove("AddedCatNode");

            if (Session["MovedCatNode"] != null)
                Session.Remove("MovedCatNode");

            UpdateView();
        }
        else if (Session["AddedCatNode"] != null)
        {
            TreeNode selectedNode = CategoryTreeView.FindNode(Session["AddedCatNode"].ToString());
            if (selectedNode != null)
                selectedNode.Select();
        }

        NameTextBox.Focus();
    }

    private void UpdateView()
    {
        string ntEvent = "return clickButton(event,'" + UpdateNameButton.ClientID + "')";
        string stEvent = "return clickButton(event,'" + AddButton.ClientID + "')";

        NameTextBox.Attributes.Add("onkeypress", ntEvent);
        NameTextBox.Attributes.Add("onfocus", ntEvent);
        NameTextBox.Attributes.Add("onchange", ntEvent);

        SubCategoryNameTextBox.Attributes.Add("onkeypress", stEvent);
        SubCategoryNameTextBox.Attributes.Add("onfocus", stEvent);
        SubCategoryNameTextBox.Attributes.Add("onchange", stEvent);

        if (CategoryTreeView.Nodes.Count != 0)
            CategoryTreeView.Nodes[0].ShowCheckBox = false;

        NameTextBox.Text = "";
        NameTextBox.Enabled = false;
        UpdateNameButton.Enabled = false;

        SubCategoryNameTextBox.Text = "";
        SubCategoryNameTextBox.Enabled = false;
        AddButton.Enabled = false;

        DeleteButton.Enabled = false;
        MoveButton.Enabled = false;

        if (CategoryTreeView.SelectedNode != null)
        {
            SubCategoryNameTextBox.Text = "شاخه جديد";
            SubCategoryNameTextBox.Enabled = true;
            AddButton.Enabled = true;

            if (CategoryTreeView.SelectedValue.Trim() != "0")
            {
                NameTextBox.Text = CategoryTreeView.SelectedNode.Text.Trim();
                NameTextBox.Enabled = true;
                UpdateNameButton.Enabled = true;

                DeleteButton.Enabled = true;
                MoveButton.Enabled = true;
            }

            //CategoryTreeView.SelectedNode.Expand();
        }

        if (Session["MovedCatNode"] == null)
            MovedItemName.Visible = false;
    }

    protected void CategoryTreeView_SelectedNodeChanged(object sender, EventArgs e)
    {
        if (Session["AddedCatNode"] != null)
            Session.Remove("AddedCatNode");

        if (Session["MovedCatNode"] != null)
        {
            MoveNode(Session["MovedCatNode"].ToString(), CategoryTreeView.SelectedValue);
            Session.Remove("MovedCatNode");
        }

        UpdateView();
    }

    private void DeleteAll(string parentID)
    {
        if (Session["MovedCatNode"] != null)
            Session.Remove("MovedCatNode");

        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();

            SqlCommand com = new SqlCommand("SELECT ID FROM [Category] WHERE Parent_ID=@Parent_ID", conn);
            com.Parameters.AddWithValue("Parent_ID", parentID);

            SqlDataReader reader = com.ExecuteReader();
            while (reader.Read())
                DeleteAll(reader["ID"].ToString());
            reader.Close();

            com = new SqlCommand("DELETE FROM [Category] WHERE Parent_ID=@Parent_ID OR ID=@Parent_ID", conn);
            com.Parameters.AddWithValue("Parent_ID", parentID);
            com.ExecuteNonQuery();

            conn.Close();
        }
    }

    protected void DeleteAllButton_Click(object sender, EventArgs e)
    {
        foreach (TreeNode node in CategoryTreeView.CheckedNodes)
            DeleteAll(node.Value);

        CategoryTreeView.DataBind();
        UpdateView();
    }

    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        DeleteAll(CategoryTreeView.SelectedValue);

        CategoryTreeView.DataBind();
        UpdateView();
    }

    private void MoveNode(string id, string newParentID)
    {
        if (id.Trim() != newParentID.Trim())
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
            {
                conn.Open();

                SqlCommand com = new SqlCommand("UPDATE [Category] SET Parent_ID=@Parent_ID WHERE ID=@ID", conn);
                com.Parameters.AddWithValue("Parent_ID", newParentID);
                com.Parameters.AddWithValue("ID", id);
                com.ExecuteNonQuery();

                conn.Close();
            }
            CategoryTreeView.DataBind();
        }
    }

    protected void MoveButton_Click(object sender, EventArgs e)
    {
        Session["MovedCatNode"] = CategoryTreeView.SelectedValue;
        MovedItemName.Text = "انتقال شاخه '" + CategoryTreeView.SelectedNode.Text + "' به ...";
        MovedItemName.Visible = true;
    }

    protected void UpdateNameButton_Click(object sender, EventArgs e)
    {
        if (Session["MovedCatNode"] != null)
            Session.Remove("MovedCatNode");

        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();

            SqlCommand com = new SqlCommand("UPDATE [Category] SET Title=@Title WHERE ID=@ID", conn);
            com.Parameters.AddWithValue("Title", NameTextBox.Text.Trim());
            com.Parameters.AddWithValue("ID", CategoryTreeView.SelectedValue.Trim());
            com.ExecuteNonQuery();

            conn.Close();
        }

        string selectedValuePath = CategoryTreeView.SelectedNode.ValuePath.Trim();
        CategoryTreeView.DataBind();

        TreeNode selectedNode = CategoryTreeView.FindNode(selectedValuePath);
        if (selectedNode != null)
            selectedNode.Select();

        UpdateView();
    }

    protected void AddButton_Click(object sender, EventArgs e)
    {
        if (Session["MovedCatNode"] != null)
            Session.Remove("MovedCatNode");

        string newNodeID = null;

        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();

            SqlCommand com = new SqlCommand("INSERT INTO [Category] (Title, Parent_ID) VALUES (@Title, @Parent_ID)", conn);
            com.Parameters.AddWithValue("Title", SubCategoryNameTextBox.Text.Trim());
            com.Parameters.AddWithValue("Parent_ID", CategoryTreeView.SelectedValue.Trim());
            com.ExecuteNonQuery();

            com = new SqlCommand("SELECT MAX(ID) as ID FROM [Category]", conn);
            SqlDataReader reader = com.ExecuteReader();
            while (reader.Read())
                newNodeID = reader["ID"].ToString();

            conn.Close();
        }

        string selectedValuePath = CategoryTreeView.SelectedNode.ValuePath.Trim();
        CategoryTreeView.DataBind();

        if (newNodeID != null)
        {
            TreeNode selectedNode = CategoryTreeView.FindNode(selectedValuePath + CategoryTreeView.PathSeparator.ToString() + newNodeID);
            if (selectedNode != null)
            {
                selectedNode.Select();
                Session["AddedCatNode"] = selectedNode.ValuePath;
            }
        }

        UpdateView();
    }
}

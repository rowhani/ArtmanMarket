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
using System.Drawing;

public partial class Page_ManageDatabase : System.Web.UI.Page
{
    string backupDirectory = "~/App_Data/Backup";

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!Request.IsAuthenticated || !ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()))
        //    Response.Redirect("~/Page/Errors/AccessDenied.aspx");

        backupDirectory = Server.MapPath(backupDirectory);

        if (!IsPostBack)
            PopulateDatabaseTablesAndFiles();

        DBTableListBox.Focus();
    }

    private void PopulateDatabaseTablesAndFiles()
    {
        btnBackup.Enabled = true;
        btnRestore.Enabled = true;

        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
        {
            conn.Open();
            using (DataTable table = new DataTable())
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter("SELECT *, name AS table_name FROM sys.tables WHERE Type = 'U' ORDER BY table_name", conn))
                {
                    adapter.Fill(table);
                }

                DBTableListBox.DataSource = table;
                DBTableListBox.DataBind();
            }
            conn.Close();
        }

        if (DBTableListBox.Items.Count == 0)
        {
            btnBackup.Enabled = false;
            DBTableListBox.Width = 120;
        }
        else
        {
            DBFileListBox.Items.Clear();
            foreach (ListItem item in DBTableListBox.Items)
            {
                string tableFileName = Path.Combine(backupDirectory, item.Value + ".xml");
                if (File.Exists(tableFileName))
                    DBFileListBox.Items.Add(new ListItem(item.Value, tableFileName));
            }
        }

        if (DBFileListBox.Items.Count == 0)
        {
            btnRestore.Enabled = false;
            DBFileListBox.Width = 120;
        }
    }

    protected void BackUpNow(object sender, EventArgs e)
    {
        if (DBTableListBox.SelectedIndex == -1)
        {
            lblMessage.Text = "No table is selected to create backup!";
            return;
        }

        try
        {
            if (!Directory.Exists(backupDirectory))
                Directory.CreateDirectory(backupDirectory);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
            {
                conn.Open();
                using (DataSet dataset = new DataSet())
                {
                    foreach (ListItem item in DBTableListBox.Items)
                    {
                        if (item.Selected)
                        {
                            string tableName = item.Value;
                            string tableFileName = Path.Combine(backupDirectory, tableName + ".xml");

                            using (SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM " + tableName, conn))
                            {
                                dataset.Clear();
                                adapter.Fill(dataset, tableName);
                                dataset.WriteXml(tableFileName, XmlWriteMode.WriteSchema);
                            }
                        }
                    }
                }
                conn.Close();
            }

            lblMessage.Text = "Backup for the selected table(s) created successfully!";
        }
        catch (Exception)
        {
            lblMessage.Text = "An error ocurred while creating backup!";
            lblMessage.ForeColor = Color.Red;
        }

        PopulateDatabaseTablesAndFiles();
    }

    protected void RestoreNow(object sender, EventArgs e)
    {
        if (DBFileListBox.SelectedIndex == -1)
        {
            lblMessage.Text = "No file is selected to restore!";
            return;
        }

        try
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MarketConnectionString"].ConnectionString))
            {
                conn.Open();
                using (DataSet dataset = new DataSet())
                {
                    foreach (ListItem item in DBFileListBox.Items)
                    {
                        if (item.Selected)
                        {
                            string tableName = item.Text;
                            string tableFileName = item.Value;

                            using (SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM " + tableName, conn))
                            {
                                SqlCommandBuilder cmd = new SqlCommandBuilder(adapter);

                                dataset.Clear();
                                adapter.Fill(dataset, tableName);
                                foreach (DataRow row in dataset.Tables[tableName].Rows)
                                    row.Delete();

                                using (DataSet fileReaderDataset = new DataSet())
                                {
                                    fileReaderDataset.ReadXml(tableFileName, XmlReadMode.ReadSchema);
                                    foreach (DataRow row in fileReaderDataset.Tables[0].Rows)
                                        dataset.Tables[tableName].Rows.Add(row.ItemArray);
                                }

                                adapter.Update(dataset, tableName);
                            }
                        }
                    }
                }
                conn.Close();
            }

            lblMessage.Text = "The selected table(s) restored successfully!";
        }
        catch (Exception ex)
        {
            lblMessage.Text = "An error ocurred while restoring! Backup files might be corrupted." + ex.Message;
            lblMessage.ForeColor = Color.Red;
        }
    }
}

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

public partial class Page_User_ManageAccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (String.IsNullOrEmpty(Request["AUTH_USER"]) || !ConfigurationManager.AppSettings["Administrators"].Contains(Request["AUTH_USER"].ToLower()))
        //    Response.Redirect("~/Page/Errors/AccessDenied.aspx");
    }

    protected void ManageGridView_DataBound(object sender, EventArgs e)
    {
        CheckBox hearderCheckBox = (CheckBox)(ManageGridView.HeaderRow.FindControl("HeaderLevelCheckBox"));
        hearderCheckBox.Attributes["onclick"] = "ToggleSelectAll(this.checked);";

        foreach (GridViewRow row in ManageGridView.Rows)
        {
            CheckBox rowCheckBox = row.FindControl("RowLevelCheckBox") as CheckBox;
            if (rowCheckBox != null)
            {
                string username = ManageGridView.DataKeys[row.RowIndex][0].ToString().Trim();
                if (ConfigurationManager.AppSettings["Administrators"].Contains(username))
                    rowCheckBox.Parent.Controls.Remove(rowCheckBox);
                else
                {
                    rowCheckBox.Attributes["onclick"] = String.Format("HighlightSelected(this,'{0}');", row.RowState.ToString());

                    ClientScript.RegisterArrayDeclaration("CheckBoxIDs", String.Format("'{0}'", rowCheckBox.ClientID));
                    ClientScript.RegisterArrayDeclaration("CheckBoxStates", String.Format("'{0}'", row.RowState.ToString()));
                }
            }
        }
    }

    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in ManageGridView.Rows)
        {
            CheckBox cb = row.FindControl("RowLevelCheckBox") as CheckBox;
            if (cb != null && cb.Checked)
            {
                string username = ManageGridView.DataKeys[row.RowIndex][0].ToString().Trim();
                ManageSqlDataSource.DeleteParameters["Username"] = new Parameter("Username", TypeCode.String, username);
                ManageSqlDataSource.Delete();
            }
        }

        ManageGridView.DataBind();
    }
}

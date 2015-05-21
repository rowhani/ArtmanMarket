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

namespace Market
{
    public class GlobalToolkit
    {
        public static void Trim(Control root)
        {
            foreach (Control c in root.Controls)
            {
                if (c is TextBox)
                    ((TextBox)c).Text = ((TextBox)c).Text.Trim();
                else if (c is Label)
                    ((Label)c).Text = ((Label)c).Text.Trim();
                else if (c is Image)
                    ((Image)c).ImageUrl = ((Image)c).ImageUrl.Trim();
                else if (c is DropDownList)
                    ((DropDownList)c).SelectedValue = ((DropDownList)c).SelectedValue.Trim();
                else
                    Trim(c);
            }
        }

        public static Control FindControl(Control root, string id)
        {
            if (root.ID == id)
                return root;

            Control foundControl = null;

            foreach (Control c in root.Controls)
            {
                foundControl = FindControl(c, id);
                if (foundControl != null)
                    break;
            }

            return foundControl;
        }
    }
}

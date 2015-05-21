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
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Xml;
using com.artman;

public partial class WebControls_User_Statistics : System.Web.UI.UserControl
{
    /*Font drawFont;
    int fontSize = 10;
    float drawFontHeight;

    SolidBrush drawBrush = new SolidBrush(Color.Blue);

    StringFormat farsiDrawStringFormat = new StringFormat(StringFormatFlags.DirectionRightToLeft);
    float offset;

    int width = 200;
    int height = 120;

    protected void Page_Load(object sender, EventArgs e)
    {
        string imageUrl = "~/Images/AccountControlImage/Stat.gif";

        try
        {
            Bitmap pic = new Bitmap(width, height, PixelFormat.Format24bppRgb);
            Graphics g = Graphics.FromImage(pic);

            System.Drawing.Image bg = System.Drawing.Image.FromFile(Server.MapPath("~/WebServices/StatBG.gif"));
            g.DrawImage(bg, new Rectangle(0, 0, width, height), new Rectangle(0, 0, bg.Width, bg.Height), GraphicsUnit.Pixel);

            Font titleFont = new Font("Tahoma", 8, FontStyle.Bold);
            string title = "آمار سايت";
            float titleCenterPos = (width - g.MeasureString(title, titleFont).Width) / 2;
            SolidBrush titleBrush = new SolidBrush(Color.Black);
            g.DrawString(title, titleFont, titleBrush, new PointF(titleCenterPos, 16));

            offset = titleFont.GetHeight() + 19;

            drawFont = new Font("Tahoma", fontSize);
            drawFontHeight = drawFont.GetHeight();

            DrawStat(g, "تعداد کل بازديدها", Application["HitCounter"].ToString());
            DrawStat(g, "تعداد کاربران آنلاين", OnlineActiveUsers.OnlineUsersInstance.OnlineUsers.UsersCount.ToString());
            DrawStat(g, "تعداد مهمانهاي آنلاين", OnlineActiveUsers.OnlineUsersInstance.OnlineUsers.GuestUsersCount.ToString());
            DrawStat(g, "تعداد اعضاي آنلاين", OnlineActiveUsers.OnlineUsersInstance.OnlineUsers.RegistredUsersCount.ToString());

            pic.Save(Server.MapPath(imageUrl), ImageFormat.Gif);
        }
        catch (Exception)
        {
        }

        StatImage.ImageUrl = imageUrl;
    }

    private void DrawStat(Graphics g, string text, string number)
    {
        g.DrawString(text, drawFont, drawBrush, new PointF(width - 10, offset), farsiDrawStringFormat);
        g.DrawString(number, drawFont, drawBrush, new PointF(10, offset));
        offset += (drawFontHeight + fontSize / 3);
    }*/

    protected void Page_Load(object sender, EventArgs e)
    {
        string imageUrl = "~/Images/AccountControlImage/Stat.gif";

        try
        {
            UserStatistics us = new UserStatistics(ImageFormat.Gif);
            string xmlImage = us.GetUserStatisticsXMLImage();

            XmlDocument xDoc = new XmlDocument();
            xDoc.LoadXml(xmlImage);

            ImageFormat imageType = null;
            System.Drawing.Image image = null;
            foreach (XmlNode x in xDoc.GetElementsByTagName("Statistics").Item(0).ChildNodes)
            {
                if (x.Name.Equals("ImageString", StringComparison.InvariantCultureIgnoreCase))
                    image = Base64ToImage(x.InnerText);
                else if (x.Name.Equals("ImageType", StringComparison.InvariantCultureIgnoreCase))
                    imageType = new ImageFormat(new Guid(x.InnerText));
            }

            image.Save(Server.MapPath(imageUrl), imageType);
        }
        catch (Exception)
        {
            StatPanel.Visible = false;
        }

        StatImage.ImageUrl = imageUrl;
    }

    private System.Drawing.Image Base64ToImage(string base64String)
    {
        // Convert Base64 String to byte[]
        byte[] imageBytes = Convert.FromBase64String(base64String);
        MemoryStream ms = new MemoryStream(imageBytes, 0, imageBytes.Length);

        // Convert byte[] to Image
        ms.Write(imageBytes, 0, imageBytes.Length);
        System.Drawing.Image image = System.Drawing.Image.FromStream(ms, true);
        return image;
    }
}

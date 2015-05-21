/// <author> Payman Rowhani </author>
/// <copyright> Copyright© 2004-2011, Artman Systems Inc. </copyright>

using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class UserStatistics : System.Web.Services.WebService
{
    Font drawFont;
    int fontSize = 10;
    float drawFontHeight;

    SolidBrush drawBrush = new SolidBrush(Color.Blue);

    StringFormat farsiDrawStringFormat = new StringFormat(StringFormatFlags.DirectionRightToLeft);
    float offset;

    int width = 200;
    int height = 120;

    private ImageFormat _imageType = ImageFormat.Gif;

    public ImageFormat ImageType
    {
        get { return _imageType; }
        set { _imageType = value; }
    }

    public UserStatistics()
    {

    }

    public UserStatistics(ImageFormat imageType)
    {
        ImageType = imageType;
    }

    /// <summary>
    /// Creates and returns an image encoded in an XML string    
    /// </summary>  
    /// 
    /// <returns>
    /// XML string representation of the statistics image in this format:
    /// <!-- 
    /// <Statistics>
    ///     <ImageString>Base64 string representation of image</ImageString>
    ///     <ImageType>Guid string representation of image format</ImageType>
    /// </Statistics> 
    /// -->
    /// </returns>

    [WebMethod]
    public string GetUserStatisticsXMLImage()
    {
        Bitmap image = new Bitmap(width, height, PixelFormat.Format24bppRgb);
        Graphics g = Graphics.FromImage(image);
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

        return GetXMLString(image);
    }

    private void DrawStat(Graphics g, string text, string number)
    {
        g.DrawString(text, drawFont, drawBrush, new PointF(width - 10, offset), farsiDrawStringFormat);
        g.DrawString(number, drawFont, drawBrush, new PointF(10, offset));
        offset += (drawFontHeight + fontSize / 3);
    }

    private string ImageToBase64(System.Drawing.Image image, ImageFormat format)
    {
        using (MemoryStream ms = new MemoryStream())
        {
            // Convert Image to byte[]
            image.Save(ms, format);
            byte[] imageBytes = ms.ToArray();

            // Convert byte[] to Base64 String
            string base64String = Convert.ToBase64String(imageBytes);
            return base64String;
        }
    }

    private string GetXMLString(System.Drawing.Image image)
    {
        string imageString = ImageToBase64(image, ImageType);
        string xml_String = "<Statistics><ImageString>" + imageString + "</ImageString><ImageType>" + ImageType.Guid.ToString() + "</ImageType></Statistics>";
        return xml_String;
    }
}

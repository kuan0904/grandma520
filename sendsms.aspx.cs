using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;
using System.Text;
using unity;
public partial class sendsms : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
     
 
        Response.Write (  classlib.SendsmtpMail("leo.kuan@funuv.com", "test","test", "gmail"));

        Encoding encoding = Encoding.GetEncoding(950);
        string phone = "0930909522";
        string msg = "訂單中文測試";
    //    Response.Write(SendInTime("kuan0904", "2iiiuiii", phone, msg));
    }
    private string SendInTime(string userid, string pwd, string dstanumber, string smsbody)
    {
        Encoding myenc = Encoding.GetEncoding("big5");
        string smsurl =
            string.Format(@"http://202.39.48.216/kotsmsapi-1.php?username={0}&password={1}&dstaddr={2}&smbody={3}"
            , userid, pwd, dstanumber, HttpUtility.UrlEncode(smsbody, myenc));
        HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create(smsurl);
        req.Method = "GET";
        using (WebResponse wr = req.GetResponse())
        {
            using (StreamReader sr = new StreamReader(wr.GetResponseStream(), myenc))
            {
                return sr.ReadToEnd();
            }
        }
    }


}
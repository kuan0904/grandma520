using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using unity;
public partial class pay_step02 : System.Web.UI.Page
{
    public string ord_code = "";
    public string email = "";
    public string password = "";
    public string zip = "";
    public string address = "";
    public string cityid = "";
    public string countyid = "";
    public string price = "";
    public string username = "";
    public string phone = "";
    public string mobile = "";
    public string paymode = "";
    public string ordstatus = "";
    public string coupon = "";
    public string DeliveryPrice = "";
    public string TotalPrice = "";
    public string SubPrice = "";
    public string DiscountPrice = "";
    public string receivetime = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["memberid"] != null && Session["memberid"].ToString() != "" && Session["ord_code"]!=null && Session["ord_code"].ToString () !="")
        {
            ord_code = Session["ord_code"].ToString ();
            using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
            {
                string strsql = "";
                OleDbCommand cmd = new OleDbCommand();
                OleDbDataReader rs;

                conn.Open();
                strsql = @"SELECT *,OrderData.status as ordstatus
                FROM OrderData    where  memberid=@memberid and OrderData.ord_code =@ord_code ";
                cmd = new OleDbCommand(strsql, conn);
                cmd.Parameters.AddWithValue("@memberid", Session["memberid"].ToString());
                cmd.Parameters.AddWithValue("@ord_code", ord_code);
                rs = cmd.ExecuteReader();
                if (rs.Read())
                {
                    email = rs["email"].ToString();
                    ordstatus = rs["ordstatus"].ToString();
                    address = rs["ordaddress"].ToString();
                    username = rs["ordname"].ToString();
                    phone = rs["ordphone"].ToString();
                    mobile = rs["mobile"].ToString();
                    DeliveryPrice = rs["DeliveryPrice"].ToString();
                    DiscountPrice = rs["DiscountPrice"].ToString();
                    SubPrice = rs["SubPrice"].ToString();
                    TotalPrice = rs["TotalPrice"].ToString();
                    receivetime = rs["receivetime"].ToString();
                    paymode = rs["paymode"].ToString();

                }
                switch (receivetime)
                {
                    case "1":
                        receivetime = "不指定";
                        break;
                    case "2":
                        receivetime = "12時以前";
                        break;
                    case "3":
                        receivetime = "12~17時";
                        break;
                    case "4":
                        receivetime = "17時以後";
                        break;
                }

                cmd.Dispose();
                rs.Close();
                string AUTHCODE = "";
                if (paymode == "1")
                {
                    strsql = @"SELECT *        FROM CardAUTHINFO    where  ord_code =@ord_code ";
                    cmd = new OleDbCommand(strsql, conn);               
                    cmd.Parameters.AddWithValue("@ord_code", ord_code);
                    rs = cmd.ExecuteReader();
                    if (rs.Read())
                    {

                        AUTHCODE = rs["AUTHCODE"].ToString();

                    }
                    rs.Close();
                    cmd.Dispose();
                    if (AUTHCODE == "")
                    {
                        paymode = "信用卡/授權失敗";
                        Response.Write("<script>alert('此筆信用卡授權失敗,請檢查你的信用卡號,並重新下單');</script>");
                    }
                }

                strsql = @"SELECT *, OrderDetail.price as sellprice
                FROM productdata INNER JOIN OrderDetail ON  productdata.p_id = OrderDetail.p_id
                where OrderDetail.status=1   and OrderDetail.ord_code =@ord_code ";
                cmd = new OleDbCommand(strsql, conn);
                cmd.Parameters.AddWithValue("@ord_code", ord_code);
                rs = cmd.ExecuteReader();
                Repeater1.DataSource = rs;
                Repeater1.DataBind();
                cmd.Dispose();
                rs.Close();
                strsql = @"SELECT * from paymode where id=@id ";
                cmd = new OleDbCommand(strsql, conn);
                cmd.Parameters.AddWithValue("id", paymode);
                rs = cmd.ExecuteReader();
                if (rs.Read())
                {
                    paymode = rs["name"].ToString();
                }
                rs.Close();
                cmd.Dispose();

                strsql = @"SELECT * from paystatus where id=@id ";
                cmd = new OleDbCommand(strsql, conn);
                cmd.Parameters.AddWithValue("id", ordstatus);
                rs = cmd.ExecuteReader();
                if (rs.Read())
                {
                    ordstatus = rs["name"].ToString();
                }
                rs.Close();
                cmd.Dispose();

                DataTable dt = new DataTable();
                dt = classlib.Get_promo("7");

                string msg = dt.Rows[0]["contents"].ToString(); //"外婆滴雞精收到你的訂單,訂單編號:" + ord_code + ",金額:" + TotalPrice ;
                msg = msg.Replace("@ord_code@", ord_code);
                msg = msg.Replace("@TotalPrice@", TotalPrice.ToString());
                msg = msg.Replace("<p>", "").Replace("</p>", "");
                string kmsgid = classlib.Sendsms(mobile, msg);

                dt = classlib.Get_promo("4");
                string subject = dt.Rows[0]["ps_name"].ToString();
                string mailbody = dt.Rows[0]["contents"].ToString();
                string atmno = classlib.Get_ck_atmno();

                dt.Dispose();
                if (paymode != "2") atmno = "";
                mailbody = mailbody.Replace("@atmno@", atmno);
                mailbody = mailbody.Replace("@ord_code@", ord_code);
                mailbody = mailbody.Replace("@TotalPrice@", TotalPrice.ToString());
                msg = classlib.SendsmtpMail(email, subject, mailbody, "gmail");
                msg = classlib.SendsmtpMail("sandy.hsu0630@gmail.com", subject, mailbody, "gmail");
            


                conn.Close();
                Session["ord_code"] = "";
                Session["ShoppingList"] = null;
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using unity;
public partial class order_info : System.Web.UI.Page
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
      ord_code = Request.QueryString["ord_code"];
        if (Session["memberid"] != null && Session["memberid"].ToString() != "")
        {
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
                    DeliveryPrice =   rs["DeliveryPrice"].ToString();
                    DiscountPrice = rs["DiscountPrice"].ToString();
                    SubPrice = rs["SubPrice"].ToString();
                    TotalPrice =  rs["TotalPrice"].ToString();
                    receivetime = rs["receivetime"].ToString();
                    paymode = rs["paymode"].ToString();
                }
                switch (receivetime)
                { 
                    case "1":
                        receivetime = "不指定";
                        break;
                    case "2":
                        receivetime = " 13時前";
                        break;
                    case "3":
                        receivetime = "14-18時";
                        break;
                }

                cmd.Dispose();
                rs.Close();

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

                conn.Close();
            }
        }
    }
}
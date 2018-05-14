<%@ WebHandler Language="C#" Class="add_order" %>
using System;
using System.Web;

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.SessionState;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using unity;

public class add_order : IHttpHandler,IRequiresSessionState  {
    public void ProcessRequest (HttpContext context) {
        string p_ACTION = context.Request["p_ACTION"];
        string email = context.Request["email"];
        string PASSWD = context.Request["password"];
        string username = context.Request["username"];
        string countyid = context.Request["countyid"];
        string cityid = context.Request["cityid"];
        string zip = context.Request["zip"];
        string address = context.Request["address"];
        string phone = context.Request["phone"];
        string mobile = context.Request["mobile"];
        string Rusername = context.Request["Rusername"];
        string birthday = context.Request["birthday"];
        string self = context.Request["self"];
        string Rmobile = context.Request["Rmobile"];
        string invoice = context.Request["invoice"];
        string receivetime =  context.Request["receivetime"];
        string companyno = context.Request["companyno"];
        string title = context.Request["title"];
        string status = "1";
        string receiveTime = context.Request["receivetime"];
        string paymode = context.Request["paymode"];
        string contents = context.Request["contents"];
        string strsql= "";
        string p_id = context.Request["p_id"];
        string numstr = context.Request["num"];
        string discount_no = context.Request["discount_no"];
        string atmcode = context.Request["atmcode"];
        string promo = context.Request["promo"];
        if (contents == null) contents = "";
        int DiscountPrice = 0;
        if (context.Session["memberid"] == null || context.Session["memberid"].ToString() == "")
        {
            using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
            {

                OleDbCommand cmd = new OleDbCommand();
                OleDbDataReader rs;

                conn.Open();
                strsql = @"SELECT     * FROM MemberData  WHERE   email=@email";
                cmd = new OleDbCommand(strsql, conn);
                cmd.Parameters.AddWithValue("@email", email);
                rs = cmd.ExecuteReader();
                if (rs.Read())
                    status = "-1";
                rs.Close();
                cmd.Dispose();
                if (status != "-1")
                {
                    strsql = @"insert into  MemberData (email, username, mobile, phone, address,
                        [password], countyid, cityid, zip, crtdat, lastlogin,birthday) values 
                        (@email, @username, @mobile, @phone, @address, @password, @countyid,
                        @cityid, @zip, now(), now(),@birthday) ";
                    cmd = new OleDbCommand(strsql, conn);
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@mobile", mobile);
                    cmd.Parameters.AddWithValue("@phone", phone);
                    cmd.Parameters.AddWithValue("@address", address);
                    cmd.Parameters.AddWithValue("@password", PASSWD);
                    cmd.Parameters.AddWithValue("@countyid", countyid);
                    cmd.Parameters.AddWithValue("@cityid", cityid);
                    cmd.Parameters.AddWithValue("@zip", zip);
                    cmd.Parameters.AddWithValue("@birthday", birthday);
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                    strsql = @"select max(memberid) from   MemberData  ";
                    cmd = new OleDbCommand(strsql, conn);
                    rs = cmd.ExecuteReader();
                    if (rs.Read()) context.Session["memberid"] = rs[0].ToString();
                    rs.Close();
                    cmd.Dispose();

                    DataTable dt = classlib.Get_promo("5");
                    string subject = dt.Rows[0]["ps_name"].ToString();
                    string mailbody = dt.Rows[0]["contents"].ToString();
                    mailbody = mailbody.Replace("@password@", PASSWD);
                    mailbody = mailbody.Replace("@email@", email);
                    string msg = classlib.SendsmtpMail(email, subject, mailbody, "gmail");
                    dt.Dispose();
                    classlib.SendsmtpMail(email, "【外婆滴雞精】會員註冊通知", mailbody, "");

                }

                conn.Close();
            }
        }

        if (status != "-1")
        {
            address = zip + classlib.Get_countyName(countyid) + classlib.Get_cityName(cityid) + address ;

            List<orderData> orderData = new List<orderData>();
            orderData.Add(new orderData
            {
                ordname = username,
                ordemail = email,
                password = PASSWD,
                ordphone = phone,
                ordcountyid = countyid,
                ordcityid = cityid,
                ordzip = zip,
                ordaddress = address,
                ordmobile = mobile,
                shipname = Rusername,
                shipcountyid = countyid,
                shipcityid = cityid,
                shipzip = zip,

                shipaddress = address,
                shipmobile = Rmobile,
                invoice = invoice,
                paymode = paymode,
                contents = contents,
                companyno = companyno,
                title = title,
                receiveTime = receiveTime

            });
            status = "1";

            string ord_code = classlib.Get_ord_code(DateTime.Today.ToString ());
            context.Session["ord_code"] = ord_code;
            using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
            {
                OleDbCommand cmd = new OleDbCommand();
                OleDbDataReader rs;
                conn.Open();

                strsql = @"insert into orderData 
                (ord_code,memberid,paymode,invoice,receivetime,contents,
                    SubPrice,DeliveryPrice,DiscountPrice,TotalPrice,crtdat,status,
                   ordname,ordphone,ordaddress,shipname,shipphone,shipaddress,companyno,
                    title,mobile,email,countryid,cityid,zip,coupon_no,atmcode) values 
                (@ord_code,@memberid,@paymode,@invoice,@receivetime,@contents,
                    @SubPrice,@DeliveryPrice,@DiscountPrice,@TotalPrice,now(),2
                  ,@ordname,@ordphone,@ordaddress,@shipname,@shipphone,@shipaddress,@companyno
                    ,@title,@mobile,@email,@countryid,@cityid,@zip,@coupon_no,@atmcode) ";
                //context.Response.Write(strsql);
                //context.Response.End();
                cmd = new OleDbCommand(strsql, conn);
                cmd.Parameters.AddWithValue("@ord_code",ord_code);
                cmd.Parameters.AddWithValue("@memberid" ,context.Session["memberid"]);
                cmd.Parameters.AddWithValue("@paymode",paymode);
                cmd.Parameters.AddWithValue("@invoice",invoice);
                cmd.Parameters.AddWithValue("@receivetime",receivetime);
                cmd.Parameters.AddWithValue("@contents",contents);
                cmd.Parameters.AddWithValue("@SubPrice",0);
                cmd.Parameters.AddWithValue("@DeliveryPrice",0);
                cmd.Parameters.AddWithValue("@DiscountPrice",0);
                cmd.Parameters.AddWithValue("@TotalPrice",0);
                cmd.Parameters.AddWithValue("@ordname", username);
                cmd.Parameters.AddWithValue("@ordphone", phone);
                cmd.Parameters.AddWithValue("@ordaddress",address);
                cmd.Parameters.AddWithValue("@shipname",Rusername);
                cmd.Parameters.AddWithValue("@shipphone",Rmobile);
                cmd.Parameters.AddWithValue("@shipaddress",address);
                cmd.Parameters.AddWithValue("@companyno",companyno);
                cmd.Parameters.AddWithValue("@title",title);
                cmd.Parameters.AddWithValue("@mobile",mobile);
                cmd.Parameters.AddWithValue("@email",email);
                cmd.Parameters.AddWithValue("@countryid", countyid);
                cmd.Parameters.AddWithValue("@cityid", cityid);
                cmd.Parameters.AddWithValue("@zip", zip);
                cmd.Parameters.AddWithValue("@coupon_no",  discount_no );
                cmd.Parameters.AddWithValue("@atmcode",  atmcode );
                cmd.ExecuteNonQuery();
                cmd.Dispose();

                strsql = @"select max(ord_id) + 1 from orderData ";
                cmd = new OleDbCommand(strsql, conn);
                rs = cmd.ExecuteReader();
                string ord_id = "";
                if (rs.Read()) ord_id = rs[0].ToString();
                rs.Close();
                cmd.Dispose();

                string[] p_idary= p_id.Split (';');
                string[] numary= numstr.Split (';');
                int i = 0;
                int price = 0;
                int num = 0;
                int DeliveryPrice = 0;
                int SubPrice = 0;
                int TotalPrice = 0;
                int totalnum = 0;

                for (i = 0; i < p_idary.Length ; i++)
                {
                    if (p_idary[i] != null && p_idary[i] != "")
                    {
                        num = int.Parse(numary[i]);
                        strsql = @"SELECT     * FROM productdata  WHERE   p_id=@p_id";
                        cmd = new OleDbCommand(strsql, conn);
                        cmd.Parameters.AddWithValue("@p_id", p_idary[i]);
                        rs = cmd.ExecuteReader();
                        if (rs.Read())
                        {
                            totalnum += num;
                            price = (int)rs["price"];
                            SubPrice += num * price;
                        }
                        rs.Close();
                        cmd.Dispose();

                        strsql = @"insert into orderdetail (ord_code,p_id,num,price, amount,status,ord_id) values 
                        (@ord_ccde, @p_id, @num, @price, @amount, 1,@ord_id) ";
                        cmd = new OleDbCommand(strsql, conn);
                        cmd.Parameters.AddWithValue("@ord_code", ord_code);
                        cmd.Parameters.AddWithValue("@p_id", p_idary[i]);
                        cmd.Parameters.AddWithValue("@num", num);
                        cmd.Parameters.AddWithValue("@price", price);
                        cmd.Parameters.AddWithValue("@amount", price * num);
                        cmd.Parameters.AddWithValue("@ord_id", ord_id );
                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                    }
                }

                DeliveryPrice = 150;
                if (int.Parse(countyid) > 22)  DeliveryPrice = 260;
                if ( SubPrice >=5000) DeliveryPrice = 0;
                if (promo == "1") DeliveryPrice = 0;
                if (paymode == "5") DeliveryPrice = 0;
                if (paymode == "4") DeliveryPrice += 60;
                if (self != "") {
                    DeliveryPrice = 0;
                  
                };
                TotalPrice = SubPrice + DeliveryPrice ;
                DiscountPrice = int.Parse ( classlib. Get_coupon_no ( context.Session ["memberid"].ToString (),discount_no,SubPrice.ToString ()));
                TotalPrice = TotalPrice - DiscountPrice;
                strsql = @"update orderdata set 
                SubPrice=@SubPrice,DeliveryPrice=@DeliveryPrice
                ,DiscountPrice=@DiscountPrice,TotalPrice=@TotalPrice 
                where ord_code =@ord_code ";

                cmd = new OleDbCommand(strsql, conn);
                cmd.Parameters.AddWithValue("@SubPrice",SubPrice);
                cmd.Parameters.AddWithValue("@DeliveryPrice", DeliveryPrice );
                cmd.Parameters.AddWithValue("@DiscountPrice", DiscountPrice );
                cmd.Parameters.AddWithValue("@TotalPrice",TotalPrice );
                cmd.Parameters.AddWithValue("@ord_code",ord_code);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                //    DataTable dt =new DataTable ();
                //    dt = classlib.Get_promo("7");

                //    string msg =  dt.Rows[0]["contents"].ToString(); //"外婆滴雞精收到你的訂單,訂單編號:" + ord_code + ",金額:" + TotalPrice ;
                //    msg =    msg.Replace("@ord_code@", ord_code);
                //    msg =    msg.Replace("@TotalPrice@", TotalPrice.ToString ());
                //    msg = msg.Replace("<p>", "").Replace("</p>", "");
                //    string kmsgid =  classlib.Sendsms ( mobile, msg);

                //    dt = classlib.Get_promo("4");
                //    string subject = dt.Rows[0]["ps_name"].ToString();
                //    string mailbody = dt.Rows[0]["contents"].ToString();
                //    string atmno = classlib.Get_ck_atmno();

                //    dt.Dispose();
                //    if (paymode != "2") atmno = "";
                //    mailbody = mailbody.Replace("@atmno@", atmno);
                //    mailbody =     mailbody.Replace("@ord_code@", ord_code);
                //    mailbody=    mailbody.Replace("@TotalPrice@", TotalPrice.ToString ());
                //    msg = classlib.SendsmtpMail(email, subject, mailbody, "gmail");
                //    msg = classlib.SendsmtpMail("sandy.hsu0630@gmail.com", subject, mailbody, "gmail");
            }
        }



        context.Response.Write(status);
        context.Response.End();

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
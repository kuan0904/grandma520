<%@ WebHandler Language="C#" Class="member_handle" %>

using System;
using System.Web;
using System.Linq;
using System.Data;
using System.Data.OleDb;
using unity;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.SessionState;

public class member_handle : IHttpHandler,IRequiresSessionState {
    public void ProcessRequest(HttpContext context)
    {
        string p_ACTION = context.Request["p_ACTION"];
        string email = context.Request["email"];
        string PASSWD = context.Request["password"];
        string username = context.Request["username"];
        string countyid= context.Request["countyid"];
        string cityid= context.Request["cityid"];
        string zip = context.Request["zip"];
        string address = context.Request["address"];
        string phone = context.Request["phone"];
        string mobile= context.Request["mobile"];
        string birthday= context.Request["birthday"];
        string status = "0";
        string strsql;
     
        //安全性,上線要加
        string check = context.Request["_"];

        if (unity.classlib.IsNumeric(check) == false)
        {
            context.Response.Write(status);
            context.Response.End();

        }


        if (p_ACTION == "Register")
        {
            using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
            {

                OleDbCommand cmd = new OleDbCommand();
                OleDbDataReader rs;

                conn.Open();
                strsql = @"SELECT     * FROM MemberData  WHERE   email=@email" ;
                cmd = new OleDbCommand(strsql, conn);
                cmd.Parameters.AddWithValue ("@email", email) ;
                rs = cmd.ExecuteReader();
                if (rs.Read())     status = "-1";
                rs.Close();
                cmd.Dispose();
                if (status != "-1")
                {
                    strsql = @"insert into  MemberData (email, username, mobile, phone, address, password, 
countyid, cityid, zip, crtdat, lastlogin) values 
                        (@email, @username, @mobile, @phone, @address, @password, 
@countyid, @cityid, @zip, now(), now()) ";
                    cmd = new OleDbCommand(strsql, conn);
                    cmd.Parameters.AddWithValue ("@email", email) ;
                    cmd.Parameters.AddWithValue ("@username",  username)  ;
                    cmd.Parameters.AddWithValue ("@mobile",  mobile);
                    cmd.Parameters.AddWithValue ("@phone",  phone)  ;
                    cmd.Parameters.AddWithValue ("@address",address);
                    cmd.Parameters.AddWithValue ("@password", PASSWD) ;
                    cmd.Parameters.AddWithValue ("@cityid", cityid);
                    cmd.Parameters.AddWithValue ("@countyid",  countyid);
                    cmd.Parameters.AddWithValue ("@zip",  zip);
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                    status = "1";
                }
                strsql = @"select max(memberid) from   MemberData  ";
                cmd = new OleDbCommand(strsql, conn);
                rs = cmd.ExecuteReader();
                if (rs.Read()) context.Session["memberid"] = rs[0].ToString();
                rs.Close();
                cmd.Dispose();
                conn.Close();



                DataTable dt =classlib . Get_promo("5");
                string subject = dt.Rows[0]["ps_name"].ToString();
                string mailbody = dt.Rows[0]["contents"].ToString();
                mailbody  = mailbody .Replace ("@password@", PASSWD  );
                mailbody  = mailbody .Replace ("@email@", email );
                string msg = classlib.SendsmtpMail(email, subject, mailbody, "gmail");
                dt.Dispose();
                classlib.SendsmtpMail(email, "【外婆滴雞精】會員註冊通知", mailbody, "");

            }

            context.Response.Write(status);
            context.Response.End();
        }
        if (p_ACTION == "Checkemail")
        {
            status = "1";
            using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
            {
                OleDbDataReader rs;
                OleDbCommand cmd = new OleDbCommand();
                conn.Open();
                strsql = @"select * from   MemberData    WHERE  email=@email" ;
                cmd = new OleDbCommand(strsql, conn);
                cmd.Parameters.AddWithValue ("@email", email);
                rs = cmd.ExecuteReader () ;
                if  (rs.Read () ) status ="-1";
                cmd.Dispose();
                rs.Close();
                conn.Close();
            }
            context.Response.Write(status);
            context.Response.End();
        }
        if (p_ACTION == "CheckLogin")
        {

        }
        if (p_ACTION == "Update")
        {

            using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
            {

                conn.Open();
                strsql = @"update  MemberData set username=@username,mobile=@mobile,
                phone=@phone,zip=@zip,cityid=@cityid,countyid=@countyid,address=@address,
                [password]=@password ,birthday=@birthday  WHERE  memberid=@memberid" ;
                OleDbCommand cmd = new OleDbCommand();
                cmd = new OleDbCommand(strsql, conn);
                cmd.Parameters.AddWithValue ("@username",  username ) ;
                cmd.Parameters.AddWithValue ("@mobile",  mobile);
                cmd.Parameters.AddWithValue("@phone",  phone);
                cmd.Parameters.AddWithValue ("@zip", zip);
                cmd.Parameters.AddWithValue ("@cityid", cityid);
                cmd.Parameters.AddWithValue ("@countyid",countyid);
                cmd.Parameters.AddWithValue ("@address", address);
                cmd.Parameters.AddWithValue ("@password", PASSWD) ;
                cmd.Parameters.AddWithValue ("@birthday", birthday) ;
                cmd.Parameters.AddWithValue ("@memberid", context.Session ["memberid"].ToString ());
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                status = "1";

                conn.Close();

            }
            context.Response.Write(status);
            context.Response.End();
        }
        if (p_ACTION == "get_discount")
        {
            string discount_no = context.Request  ["discount_no"];
            string memberid= (context.Session["memberid"] == null)? "" : context.Session["memberid"].ToString();
            string price = context.Request  ["price"];

            string  cc_money = classlib. Get_coupon_no (memberid,discount_no,price);
            context.Response.Write(cc_money .ToString ());
            context.Response.End();

        }
    }



    public bool IsReusable {
        get {
            return false;
        }
    }

}
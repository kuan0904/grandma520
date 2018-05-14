<%@ WebHandler Language="C#" Class="cardpay" %>

using System;
using System.Web;
using unity;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.SessionState;
using System.Collections.Generic;
using System.Data.OleDb;

public class cardpay : IHttpHandler,IRequiresSessionState {
    public static string dbConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
  
    public void ProcessRequest (HttpContext context) {
        //(STOREID+ORDERNUMBER+AMOUNT+CUBKEY)
        //【特店代號】：020270291
        //【CUBKEY】："1e54c24cbe8ee60a29186d4bda0c7c30
  
    using (OleDbConnection conn = new OleDbConnection(dbConnectionString))
            {
                conn.Open();
                OleDbCommand cmd = new OleDbCommand();
                OleDbDataReader rs;               
          
            string CAVALUE = "";
            string STOREID = "020270291";
            string ORDERNUMBER = "";
            string AMOUNT = "";
            string CUBKEY = "1e54c24cbe8ee60a29186d4bda0c7c30";
            string strsql = @"select * from  orderdata  where ord_code =@ord_code  ";
            cmd = new OleDbCommand(strsql, conn);
            cmd.Parameters.Add("@ord_code",  OleDbType.VarChar  ).Value = context.Session["ord_code"].ToString ();

            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                ORDERNUMBER  = rs["ord_code"].ToString();
                AMOUNT =  rs["TotalPrice"].ToString();
//AMOUNT = "1";//測試刷卡

            }
            cmd.Dispose();
            rs.Close();
            conn.Close();
            CAVALUE = STOREID + ORDERNUMBER + AMOUNT + CUBKEY;
            CAVALUE = classlib.GetMD5(CAVALUE);
            string xml = @"<?xml version='1.0' encoding='UTF-8'?>" +
            "<MERCHANTXML>" +
            "<CAVALUE>" + CAVALUE +"</CAVALUE>" +
            "<ORDERINFO>" +
            "<STOREID>" + STOREID + "</STOREID>" +
            "<ORDERNUMBER>" +  ORDERNUMBER  + "</ORDERNUMBER>" +
            "<AMOUNT>" + AMOUNT +"</AMOUNT>" +
            "</ORDERINFO>" +
            "</MERCHANTXML>";     
            //https://sslpayment.uwccb.com.tw/EPOSService/Payment/OrderInitial.aspx
            string html="<html><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">" +
                             "<body onload=\"document.main.submit();\">資料傳送中...\r\n"  +
                                "<form name=\"main\" action=\"https://sslpayment.uwccb.com.tw/EPOSService/Payment/OrderInitial.aspx\" method=\"post\">" +
                                "<input type=hidden name=\"strRqXML\" value=\"" + xml + "\">" +
                                "</form></body></html>";

            context.Response.Write(html);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
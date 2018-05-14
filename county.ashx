<%@ WebHandler Language="C#" Class="county" %>

using System;
using System.Web;

using System.Data.OleDb;

public class county : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
                  context.Response.Write("<option value=\"\">請選擇</option>");
              
               using (OleDbConnection conn = new OleDbConnection(unity.classlib.dbConnectionString))
            {
                OleDbCommand cmd = new OleDbCommand();
                OleDbDataReader rs;
                conn.Open();
                string strsql = "SELECT  * from county ";
                cmd = new OleDbCommand(strsql, conn);
                
                rs = cmd.ExecuteReader();
                while (rs.Read())
                {
                    context.Response.Write("<option value=\"" + rs["countyid"].ToString () +  "\">" + rs["countyname"].ToString () + "</option>");
                }
                rs.Close();
                cmd.Dispose();               
                conn.Close();




            }
     
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}
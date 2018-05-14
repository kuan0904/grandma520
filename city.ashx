<%@ WebHandler Language="C#" Class="city" %>

using System;
using System.Web;

using System.Data;
using System.Data.OleDb;

public class city : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string check = context.Request["_"];
        if (unity.classlib.IsNumeric( check ) == false || context.Request["p_COUNTYID"] =="")
        {
            context.Response.End();

        }
        int p_COUNTYID= int.Parse ( context.Request["p_COUNTYID"]);

        using (OleDbConnection conn = new OleDbConnection(unity.classlib.dbConnectionString))
        {
            OleDbCommand cmd = new OleDbCommand();
            OleDbDataReader rs;
            conn.Open();
            string strsql = "SELECT  * from city where countyid =@countyid ";
             context.Response.Write("<option value=\"\">請選擇</option>");
            cmd = new OleDbCommand(strsql, conn);
            cmd.Parameters.Add("countyid", SqlDbType.Int ).Value = p_COUNTYID ;
            rs = cmd.ExecuteReader();
            while (rs.Read())
            {
                context.Response.Write("<option value=\"" + rs["cityid"].ToString () + "-" + rs["zip"].ToString () +  "\">" + rs["cityname"].ToString () + "</option>");
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
<%@ WebHandler Language="C#" Class="Handler" %>
using System;
using System.Web;

using System.Data;
using System.Data.OleDb;


public class Handler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string check = context.Request["_"];
        if (unity.classlib.IsNumeric( check ) == false || context.Request["p_COUNTYID"] =="")
        {
            context.Response.End();

        }
        string email=   context.Request["email"] ;

        using (OleDbConnection conn = new OleDbConnection(unity.classlib.dbConnectionString))
        {
            OleDbCommand cmd = new OleDbCommand();
            OleDbDataReader rs;
            conn.Open();
            string strsql = "SELECT  * from memberdata  where email =@email ";
            cmd = new OleDbCommand(strsql, conn);
            cmd.Parameters.AddWithValue ("email", SqlDbType.NVarChar ).Value = email ;
            rs = cmd.ExecuteReader();
            while (rs.Read())
            {
                context.Response.Write("Y");
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
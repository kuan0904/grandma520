using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Data.OleDb;
using unity;

public partial class product : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
        using (OleDbConnection conn = new OleDbConnection(unity.classlib.dbConnectionString))
        {
            string strsql = @"select * from  category  where status='Y'  order by priority   ";
            string c_id = Request.QueryString["c_id"];
            OleDbCommand cmd = new OleDbCommand();
            OleDbDataReader rs;
            conn.Open();
            cmd = new OleDbCommand(strsql, conn);
            rs = cmd.ExecuteReader();
            Repeater2.DataSource = rs;
            Repeater2.DataBind();
            cmd.Dispose();
            rs.Close();
      
            strsql = @"select * from  productdata where status='Y'  ORDER BY sort  ";
            if (  c_id !="" && c_id != null  ) strsql =  @"select * from  productdata where status='Y'  and c_id=@c_id ORDER BY sort  ";
            cmd = new OleDbCommand(strsql, conn);
            if (c_id != "" && c_id != null ) cmd.Parameters.Add("@d_id", OleDbType.Integer).Value = c_id; 
            rs = cmd.ExecuteReader();
            Repeater1.DataSource = rs;
            Repeater1.DataBind();
            cmd.Dispose();
            rs.Close();

            conn.Close();

        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;

public partial class kitchen : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strsql = @"select * from  diary where status='Y'  ORDER BY  d_id desc  ";
        using (OleDbConnection conn = new OleDbConnection(unity.classlib.dbConnectionString))
        {

            OleDbCommand cmd = new OleDbCommand();
            OleDbDataReader rs;
            conn.Open();

            cmd = new OleDbCommand(strsql, conn);
            rs = cmd.ExecuteReader();
            Repeater1.DataSource = rs;
            Repeater1.DataBind();
            cmd.Dispose();
            rs.Close();

            conn.Close();

        }
      
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using System.Text.RegularExpressions;
public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strsql = @"select * from  diary where status='Y' and hot  <>'0'   ORDER BY hot   ";
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

            strsql = @"select top 2 * from news where status='Y'     ORDER BY newsid desc    ";
            cmd = new OleDbCommand(strsql, conn);
            rs = cmd.ExecuteReader();
            Repeater2.DataSource = rs;
            Repeater2.DataBind();
            cmd.Dispose();
            rs.Close();
            conn.Close();

        }
    }

    public static string htmlreplace(string T )
    {
        T = Regex.Replace(T, "</p>", "\r\n");
        T = Regex.Replace(T, "<[^>]*>", "", RegexOptions.IgnoreCase);
        //以防有不正常結尾-->EX:"文字 <a styl"
        T = Regex.Replace(T, "<[^>]*", "", RegexOptions.IgnoreCase);
        T = Regex.Replace(T,  "\r\n","<br>");
        return  T;
    }
}
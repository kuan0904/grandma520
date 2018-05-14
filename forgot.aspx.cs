using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using unity;
public partial class forgot : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
  
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
        {
            string strsql = "";
            OleDbCommand cmd = new OleDbCommand();
            OleDbDataReader rs;

            conn.Open();
            strsql = @"SELECT     * FROM MemberData  WHERE   email=@email";
            cmd = new OleDbCommand(strsql, conn);
            cmd.Parameters.AddWithValue ("@email", SqlDbType.VarChar).Value = email.Text;
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                DataTable dt = classlib.Get_promo("6");
                string subject = dt.Rows[0]["ps_name"].ToString();
                string mailbody = dt.Rows[0]["contents"].ToString();
                mailbody = mailbody.Replace("@password@", rs["password"].ToString());
                string msg = classlib.SendsmtpMail(email.Text, subject, mailbody, "gmail");
                dt.Dispose();
                Response.Write("<script>alert('Email已寄出');</script>");
            
            }
            else
            {
                Response.Write("<script>alert('Email非會員');</script>");
            }

            rs.Close();
            cmd.Dispose();
            conn.Close();
        }
    }
}
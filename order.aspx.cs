using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using unity;
public partial class order : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["memberid"] == null || Session["memberid"].ToString () == "")
        {
            Response.Write("<script>alert('請先登入');location.href='login?page=order';</script>");
            Response.End();
        }else
        {
            using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
            {
                string strsql = "";
                OleDbCommand cmd = new OleDbCommand();
               OleDbDataReader rs;
                conn.Open();     
                strsql = @" SELECT *    FROM    OrderData INNER JOIN payStatus ON OrderData.status = payStatus.id  where OrderData.memberid=@memberid order by ord_id desc ";
                cmd = new OleDbCommand(strsql, conn);
                cmd.Parameters.AddWithValue ("@memberid", SqlDbType.Int).Value = Session["memberid"].ToString();
                rs = cmd.ExecuteReader();
                Repeater1.DataSource = rs;
                Repeater1.DataBind();
                rs.Close();
                cmd.Dispose();
                conn.Close();
            }

        }

    }
}
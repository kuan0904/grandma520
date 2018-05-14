using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using unity;
public partial class member : System.Web.UI.Page
{
    public string email = "";
    public string password = "";
    public string zip = "";
    public string address = "";
    public string cityid = "";
    public string countyid = "";
    public string mobile= "";
    public string username = "";
    public string phone = "";
    public string birthday = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["memberid"] == null)
        {
            Response.Redirect("login.aspx?page=member");
        }
        else
        {
            using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
            {
                string strsql = "";
                OleDbCommand cmd = new OleDbCommand();
                OleDbDataReader rs;

                conn.Open();
                strsql = @"SELECT     * FROM MemberData  WHERE  memberid=@memberid ";
                cmd = new OleDbCommand(strsql, conn);
                cmd.Parameters.AddWithValue("@memberid", Session["memberid"].ToString());
                rs = cmd.ExecuteReader();
                if (rs.Read())
                {
                    email = rs["email"].ToString();
                    username = rs["username"].ToString();
                    password = rs["password"].ToString();
                    phone = rs["phone"].ToString();
                    zip = rs["zip"].ToString();
                    address = rs["address"].ToString();
                    cityid = rs["cityid"].ToString();
                    countyid = rs["countyid"].ToString();                 
                    mobile = rs["mobile"].ToString();
                    birthday = rs["birthday"].ToString();
                }
                cmd.Dispose();
                rs.Close();
                conn.Close();
            }
        }
    }

    protected void logout_Click(object sender, EventArgs e)
    {
        Session["memberid"] = null;
        Response.Redirect("index");
    }
}
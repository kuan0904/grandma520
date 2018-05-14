using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using unity;
public partial class pay : System.Web.UI.Page
{
    public string email = "";
    public string password = "";
    public string zip = "";
    public string address = "";
    public string cityid = "";
    public string countyid = "";
    public string price = "";
    public string username = "";
    public string phone = "";
    public string mobile = "";
    public string memberid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ShoppingList"] == null)
        {
            Response.Write("<script>alert('購物車無資料!');location.href='index';</script>");
            Response.End();
        }
        if (Session["memberid"] != null && Session["memberid"].ToString() != "")
        {
            MultiView1.ActiveViewIndex = 1;
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
                    memberid = rs["memberid"].ToString();
                    email = rs["email"].ToString();
                    username = rs["username"].ToString();
                    password = rs["password"].ToString();
                    phone = rs["phone"].ToString();
                    zip = rs["zip"].ToString();
                    address = rs["address"].ToString();
                    cityid = rs["cityid"].ToString();
                    countyid = rs["countyid"].ToString();
                    mobile = rs["mobile"].ToString();
                }
                cmd.Dispose();
                rs.Close();
                conn.Close();
            }
        }else
        {

            MultiView1.ActiveViewIndex = 0;
        }
        if (Session["ShoppingList"] != null)
        {

            List<ShoppingList> Shoppinglist = new List<ShoppingList>();
            Shoppinglist = Session["ShoppingList"] as List<ShoppingList>;
            Repeater1.DataSource = Shoppinglist;
            Repeater1.DataBind();

        }
          
    }
    public string get_storage(string p_id, int num)
    {
        int storage = 10;
        string msg = "";
        using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
        {
            conn.Open();
            OleDbCommand cmd = new OleDbCommand();
            OleDbDataReader rs;

            string strsql = "select * from productData where p_id = @p_id";
            cmd = new OleDbCommand(strsql, conn);
            cmd.Parameters.AddWithValue ("p_id", SqlDbType.Int).Value = p_id;
            rs = cmd.ExecuteReader();

            if (rs.Read())
            {
                storage = (int)rs["storage"];
                price = rs["price"].ToString ();
            }
            cmd.Dispose();
            rs.Close();
            conn.Close();
        }
        if (storage > 10) storage = 10;
        if (storage == 0) msg += "<option value = \"0\" selected \">銷售完畢</option>";
        for (int i = 1; i <= storage; i++)
        {
            msg += "<option value = \"" + i + "\"";
            if (num == i) msg += " selected ";
            msg += ">" + i + "</option>";

        }
        return msg;
    }
}

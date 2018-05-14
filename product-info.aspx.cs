using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using unity;
using System.Web.UI.HtmlControls;
public partial class product_info : System.Web.UI.Page
{
    public string productname = "";
    public string price = "";
    public string crtdat = "";
    public string memos = "";
    public string description = "";
    public string pic = "";
    public string p_id = "";  
    public string logo = "";
    public string banner = "";
    public int storage = 0; 
    public string memo = "";  
    public string buy_num_option = "";
    public string Pricing = "";
    public string Savetxt = "";
    public string sell_text = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        using (OleDbConnection conn = new OleDbConnection(unity.classlib.dbConnectionString))
        {
            int id = int.Parse(Request.QueryString["p_id"]);
      
            string strsql = @"select * from productdata  where status='Y'  and p_id=@p_id   ";
            string p_id = Request.QueryString["p_id"];
            OleDbCommand cmd = new OleDbCommand();
            OleDbDataReader rs;
            conn.Open();
            cmd = new OleDbCommand(strsql, conn);
            cmd.Parameters.AddWithValue("@p_id", p_id);           
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                productname = rs["productname"].ToString();
                price = rs["price"].ToString();
                memos = rs["memos"].ToString();
                crtdat = rs["crtdat"].ToString();
                description = rs["description"].ToString();
                pic = rs["pic1"].ToString();
                Pricing = rs["pricing"].ToString();
                storage = (int)rs["storage"];
                Page.Title = string.Format("{0}|外婆滴雞精", productname);
                HtmlMeta ma1 = (HtmlMeta)this.Master.Page.Header.Controls[5];
                ma1.Content = classlib.RemoveHTMLTag(description);
            }
            cmd.Dispose();
            rs.Close();
            strsql = "update productData  set viewcount = viewcount +1  where p_id=@id";
            cmd = new OleDbCommand(strsql, conn);
            cmd.Parameters.Add("@id", OleDbType.Integer).Value = p_id;
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            if (storage > 20) storage = 20;
            buy_num_option = "";
            if (storage <= 0)
            {
                buy_num_option = " <option value=\"0\">已售完</option>";
            }
            for (int i = 1; i <= storage; i++)
            {
                buy_num_option += "<option value =\"" + i.ToString() + "\">" + i.ToString() + "</option>";
            }

            conn.Close();

        }
    }
}
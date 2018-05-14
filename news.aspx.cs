using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
public partial class news : System.Web.UI.Page
{
    public string subject = "";
    public string subtitle = "";
    public string contents = "";
    public string pic = "";
    public string lasidx = "";
    public string ntxidx = "";
    public string strdat = "";
    public string enddat = "";
    public string itemlist = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string  newsid =Request.QueryString["newsid"];
        string strsql = @"select  top 5 * from  news  where status='Y'  ORDER BY  newsid  desc  ";
        using (OleDbConnection conn = new OleDbConnection(unity.classlib.dbConnectionString))
        {
            conn.Open();
            OleDbCommand cmd = new OleDbCommand(strsql, conn);
            OleDbDataAdapter adapter = new OleDbDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);          
            int i = 0;
            itemlist = "";
            for (i = 0; i < dt.Rows.Count; i++)
            {
                itemlist += "<a href = \"news?newsid=" + dt.Rows[i]["newsid"].ToString() + "\" class=\"";
                if (dt.Rows[i]["newsid"].ToString() == newsid || (newsid == null  && i==0))
                    itemlist += "list-group-item active";
                else
                    itemlist += "list-group-item";

                itemlist += "\">" + dt.Rows[i]["subject"].ToString() + "</a>";
    
                if (dt.Rows[i]["newsid"].ToString() == newsid ||  i==0 )
                {
                    pic = dt.Rows[i]["pic"].ToString();
                    subject = dt.Rows[i]["subject"].ToString();
                    strdat =    DateTime.Parse ( dt.Rows[i]["strdat"].ToString()).ToString ("yyyy-MM-dd");
                    enddat = DateTime.Parse(dt.Rows[i]["enddat"].ToString()).ToString("yyyy-MM-dd");
                    contents = dt.Rows[i]["contents"].ToString().Replace ("\r\n","<BR>");
                    if (pic != "") contents = "<img src =\"upload/" + pic + "\" width=533><br>" + contents;


                    if (i == 0) { lasidx = dt.Rows[dt.Rows.Count - 1]["newsid"].ToString(); }
                    else { lasidx = dt.Rows[i - 1]["newsid"].ToString(); }
                    if (i == dt.Rows.Count - 1) { ntxidx = dt.Rows[0]["newsid"].ToString(); }
                    else { ntxidx = dt.Rows[i + 1]["newsid"].ToString(); }
                }
            }

            dt.Dispose();
            adapter.Dispose();
            conn.Close();
        }
    }
}
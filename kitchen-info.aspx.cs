using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;

public partial class kitchen_info : System.Web.UI.Page
{
    public string subject = "";
    public string subtitle = "";
    public string contents = "";
    public string pic = "";
    public string lasidx = "";
    public string ntxidx = "";
    protected void Page_Load(object sender, EventArgs e)
    {
  

        int d_id =int.Parse ( Request.QueryString["d_id"]);
        string strsql = @"select * from  diary where status='Y'  order by d_id desc";// and d_id=@d_id  ";
        using (OleDbConnection conn = new OleDbConnection(unity.classlib.dbConnectionString))
        {
            conn.Open();
            OleDbCommand cmd = new OleDbCommand(strsql ,conn );
            OleDbDataAdapter adapter = new OleDbDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);


            int i = 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {
             
                if ( dt.Rows[i] ["d_id"].ToString() == d_id.ToString())
                {
                    subject = dt.Rows[i]["subject"].ToString();
                    subtitle = dt.Rows[i]["subtitle"].ToString();
                    contents = dt.Rows[i]["contents"].ToString();
                    pic = dt.Rows[i]["pic"].ToString();
                    if (i == 0) { lasidx = dt.Rows[dt.Rows.Count -1]["d_id"].ToString(); }
                    else { lasidx = dt.Rows[i-1]["d_id"].ToString(); }
                    if (i == dt.Rows.Count -1) { ntxidx  = dt.Rows[0]["d_id"].ToString(); }
                    else { ntxidx = dt.Rows[i + 1]["d_id"].ToString(); }
                }
            }

         //   ds.Dispose();
            dt.Dispose();
            adapter.Dispose();
            conn.Close();

        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using unity;

public partial class spadmin_admin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (Session["userid"] == null)
            {
                Response.Redirect("login.aspx?ReturnUrl=" + Request.RawUrl.ToString());
                Response.End();
            }

        if (!IsPostBack)
        {

            Label_user.Text = Session["username"].ToString();

            if (!IsPostBack)
            {

                //------第一層------
                string strsql = "";
                strsql = "SELECT * FROM  UnitData  where  adminpage is  not null  and unitdata.upperid = 0  and adminpage <> ''  order by sort ";                   

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

    }

    protected void R1_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
    {

        if (e.Item.ItemType != ListItemType.Footer && e.Item.ItemType != ListItemType.Header)
        {
           
            Repeater Repeater2 = (Repeater)e.Item.FindControl("Repeater2");
            HiddenField Hidden_id = (HiddenField)e.Item.FindControl("Hidden_id");
            System.Data.Common.DbDataRecord row = (System.Data.Common.DbDataRecord)e.Item.DataItem;

            //  DataRowView row = (DataRowView)e.Item.DataItem;
            string unitid = row["unitid"].ToString();
            string strsql = null;

                //不分權限
                strsql = "SELECT * FROM UnitData ";
                strsql += " where  unitdata.upperid=" + unitid + " and  adminpage is not null  and adminpage <> '' ";
                strsql += "and status<>'D'  order by sort ";
            using (OleDbConnection conn = new OleDbConnection(unity.classlib.dbConnectionString))
            {

                OleDbCommand cmd = new OleDbCommand();
                OleDbDataReader rs;
                conn.Open();

                cmd = new OleDbCommand(strsql, conn);
                rs = cmd.ExecuteReader();
                Repeater2.DataSource = rs;
                Repeater2.DataBind();

                cmd.Dispose();
                rs.Close();

                conn.Close();

            }





        }
    }

    protected void ImageButton_SignOut_Click(object sender, EventArgs e)
    {
        Response.Redirect("SignOut.aspx");
    }
}

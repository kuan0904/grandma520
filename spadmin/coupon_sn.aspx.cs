using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using unity;
using System.Collections.Specialized;


public partial class spadmin_coupon_sn : System.Web.UI.Page
{

    protected void Page_Init(object sender, EventArgs e)
    {
       
    }
    protected void Page_Load(object sender, EventArgs e)
    {

       
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            selectSQL();
        }

    }
    protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        var pager = (DataPager)ListView1.FindControl("DataPager1");
        pager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        selectSQL();
    }
    protected void sortdata(object sender, EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        string sorttype = obj.CommandArgument;
        string sortColumn = obj.CommandName;
        sorttype = (sorttype == "desc") ? "asc" : "desc";
        obj.CommandArgument = sorttype;
        selectSQL(sorttype, sortColumn);

    }

    public void selectSQL(string sorttype = "desc", string sortColumn = "id")
    {

        string strsql = @"select * from  coupon ";
        strsql += " ORDER BY  " + sortColumn + " " + sorttype;
        NameValueCollection nvc = new NameValueCollection();
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
        ListView1.DataSource = dt;
        ListView1.DataBind();



    }
    protected void Button1_Click1(object sender, EventArgs e)
    {

        selectSQL();

    }
    protected void Btn_add_Click(object sender, EventArgs e)
    {
        Btn_save.CommandArgument = "add";
        MultiView1.ActiveViewIndex = 1;
        cleaninput();
    }
    protected void link_edit(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        Selected_id.Value = obj.CommandArgument;
        Btn_save.CommandArgument = "edit";
        MultiView1.ActiveViewIndex = 1;
        using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
        {
            conn.Open();
            OleDbCommand cmd = new OleDbCommand();
            OleDbDataReader rs;

            string strsql = "select * from   coupon where id = @id";
            cmd = new OleDbCommand(strsql, conn);
            cmd.Parameters.Add("id", OleDbType.Numeric).Value = Selected_id.Value;
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                status.SelectedValue = rs["status"].ToString();
                sn.Text = rs["sn"].ToString();
                money.Text = rs["price"].ToString();
                strdate.Text =DateTime.Parse ( rs["strdate"].ToString()).ToString ("yyyy/MM/dd");
                enddate.Text = DateTime.Parse(rs["enddate"].ToString()).ToString("yyyy/MM/dd");
                num.Text = rs["num"].ToString();
                if (rs["usetimes"].ToString() !="")
                {
                    usetimes.SelectedValue = rs["usetimes"].ToString();
                }
                useprice.Text = rs["useprice"].ToString();
            }
            rs.Close();
            cmd.Dispose();
            conn.Close();
        }
    }
    protected void Btn_save_Click(object sender, System.EventArgs e)
    {

        using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
        {
            conn.Open();
            OleDbCommand cmd = new OleDbCommand();  

            if (num.Text == "") num.Text = "999999";
            if (strdate.Text == "") strdate.Text = "2017/01/01";
            if (enddate.Text == "") enddate.Text = "2030/01/01";
            if (usetimes.SelectedIndex  == -1) usetimes.SelectedIndex=0;
            if (useprice.Text == "") useprice.Text = "1";
            LinkButton obj = sender as LinkButton;
            string strsql = "update Coupon set sn=@sn,price=@price,status=@status,strdate=@strdate,enddate=@enddate,num=@num,useprice=@useprice,usetimes=@usetimes where id=@id";
            if (Btn_save.CommandArgument == "add")
            {
                strsql = @"insert into coupon (sn,price, status,strdate,enddate,num,useprice,usetimes ) values
            ( @sn,@money,@status,@strdate,@enddate,@num,@useprice,@usetimes)";
            }
            cmd = new OleDbCommand(strsql, conn);
        
            cmd.Parameters.Add("sn", OleDbType.VarChar).Value = sn.Text;
            cmd.Parameters.Add("price", OleDbType.VarChar ).Value = money.Text;
            cmd.Parameters.Add("status", OleDbType.VarChar ).Value = status.SelectedValue ;
            cmd.Parameters.Add("strdate", OleDbType.VarChar).Value =strdate .Text;
            cmd.Parameters.Add("enddate", OleDbType.VarChar).Value = enddate .Text;
            cmd.Parameters.Add("num", OleDbType.VarChar).Value = num.Text;
            cmd.Parameters.Add("useprice", OleDbType.VarChar).Value = useprice.Text;
            cmd.Parameters.Add("usetimes", OleDbType.VarChar).Value = usetimes.SelectedValue ;          
                cmd.Parameters.Add("id", OleDbType.VarChar).Value = Selected_id.Value;
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();


        }

        
        selectSQL();
        MultiView1.ActiveViewIndex = 0;
    }
    protected void Btn_save_Click1(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        string strsql = "";
        NameValueCollection nvc = new NameValueCollection();
        NameValueCollection m_id = new NameValueCollection();
        DataTable dt = new DataTable();
        nvc.Clear();

        if (Btn_save.CommandArgument == "add")
        {
            strsql = @"insert into coupon (sn, status ) values
            ( @w_p_code,@sn,'N')";
        }
     
        int i = 0;
        int n = int.Parse(num.Text);
      

        for (i=0;i< n; i++)
        {
            string sn = Guid.NewGuid().ToString().Substring(0, 8);          
            nvc.Add("sn", sn);
            admin_contrl.Data_add(strsql, nvc);
            nvc.Clear();
        }
           
        selectSQL();
        MultiView1.ActiveViewIndex = 0;
    }
    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {
        cleaninput();
        MultiView1.ActiveViewIndex = 0;
    }
    public void cleaninput()
    {

        Selected_id.Value = "";
      
     



    }
}
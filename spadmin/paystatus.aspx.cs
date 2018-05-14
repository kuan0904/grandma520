using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using unity;

public partial class spadmin_paystatus : System.Web.UI.Page
{

    static string strsql = "";
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
    public void selectSQL()
    {
        ListView1.DataBind();

    }

    protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        selectSQL();
    }

    //編輯
    protected void link_edit(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        Selected_id.Value = obj.CommandArgument;
        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";
        string strsql = "";
        OleDbConnection conn = new OleDbConnection(unity.classlib.dbConnectionString);
        OleDbDataReader rs = default(OleDbDataReader);
        OleDbCommand cmd = new OleDbCommand();
        conn.Open();
        strsql = "select * from  paystatus where id  = @id ";
        cmd = new OleDbCommand(strsql, conn);
        cmd.Parameters.Add("id", OleDbType.LongVarWChar).Value = Selected_id.Value;
        rs = cmd.ExecuteReader();
        if (rs.Read())
        {
            status.SelectedValue = rs["status"].ToString();
            ps_name.Text = rs["name"].ToString();

        }
        rs.Close();
        cmd.Dispose();
        conn.Close();
    }



    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
        string strsql = "";

        //-----------------------------------------------------------------------

        if (Btn_save.CommandArgument == "add")
        {
            strsql = " insert into paystatus( ps_condition, status,  ps_name,contents ) values ";
            strsql += "(@ps_condition, @status, @ps_name,@contents ) ";
        }
        else
        {
            strsql = "update paystatus set name=@name,status=@status where id =@id";
        }


        OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString);
        OleDbCommand cmd = new OleDbCommand();
        conn.Open();
        cmd = new OleDbCommand(strsql, conn);
        cmd.Parameters.Add("name", OleDbType.LongVarWChar).Value = ps_name.Text;
        cmd.Parameters.Add("status", OleDbType.LongVarWChar).Value = status.SelectedValue;


        if (Btn_save.CommandArgument == "add")
        {

        }
        else
        {
            cmd.Parameters.Add("id", OleDbType.VarChar).Value = Selected_id.Value;
        }


        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();

        MultiView1.ActiveViewIndex = 0;

        cleaninput();
        selectSQL();
    }




    protected void Btn_add_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "add";
        cleaninput();
    }

    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        cleaninput();
    }


    public void cleaninput()
    {
        Selected_id.Value = "";

        ps_name.Text = "";


    }

    protected void btn_del_Click(object sender, System.EventArgs e)
    {

        OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString);
        OleDbCommand cmd = new OleDbCommand();

        conn.Open();

        cmd = new OleDbCommand("update   paystatus  set status = 'D' where id = '" + Selected_id.Value + "' ", conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();


        selectSQL();
    }



    //刪除
    protected void link_delete(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        //string[] arg = obj.CommandArgument.ToString.Split(",");
        //sql_delete(arg[0], arg[1]);

        OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString);
        OleDbCommand cmd = new OleDbCommand();

        conn.Open();
        cmd = new OleDbCommand("delete from  paystatus where id =  " + obj.CommandArgument  , conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();


        selectSQL();

    }


    public string statusTotxt(string str)
    {
        if (str == "Y")
        {
            return "開啟";
        }
        if (str == "N")
        {
            return "關閉";
        }
        return "";

    }


}
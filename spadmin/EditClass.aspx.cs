﻿using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using unity;



public partial class admin_EditClass : System.Web.UI.Page
{
    static string  strsql  = "";   
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
        strsql = "select * from    category where c_id  = @c_id ";
        cmd = new OleDbCommand(strsql, conn);
        cmd.Parameters.Add("c_id", OleDbType.LongVarWChar).Value = Selected_id.Value;
        rs = cmd.ExecuteReader();
        if (rs.Read())
        {
           status.SelectedValue = rs["status"].ToString();        
           c_name.Text  = rs["c_name"].ToString();     
           priority.Text = rs["priority"].ToString();
           
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
            strsql = " insert into category( priority, status,  c_name ) values ";
            strsql += "(@priority, @status, @c_name ) ";
        }
        else {
            strsql = "update category set priority=@priority,status=@status, c_name=@c_name";
            strsql += " where c_id =@c_id";
        }


        OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString);
        OleDbCommand cmd = new OleDbCommand();    
        conn.Open();
        cmd = new OleDbCommand(strsql, conn);    
        cmd.Parameters.Add("priority", OleDbType.LongVarWChar).Value = priority.Text;
        cmd.Parameters.Add("status", OleDbType.LongVarWChar).Value = status.SelectedValue;      
        cmd.Parameters.Add("c_name", OleDbType.LongVarWChar).Value =c_name.Text;   
        if (Btn_save.CommandArgument == "add")
        {
       
        }
        else {
            cmd.Parameters.Add("c_id", OleDbType.VarChar).Value = Selected_id.Value ;
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
        priority.Text = "1";
        c_name.Text = "";

   
    }

    protected void btn_del_Click(object sender, System.EventArgs e)
    {
       
        OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString);
        OleDbCommand cmd = new OleDbCommand();

        conn.Open();

        cmd = new OleDbCommand("update  category set status = 'D' where c_id = '" + Selected_id.Value + "' ", conn);
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
        cmd = new OleDbCommand("update  category set status = 'D' where c_id = '" + obj.CommandArgument  + "' ", conn);
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
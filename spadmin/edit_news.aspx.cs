using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Diagnostics;
using System.Data.OleDb;
using unity;

public partial class spadmin_news : System.Web.UI.Page
{
    string fname = "";
    string fname2 = "";
    string fname3 = "";
protected void Page_Load(object sender, EventArgs e)
{
    if (!IsPostBack)
    {
        MultiView1.ActiveViewIndex = 0;

        selectSQL();
    }

}
protected void link_edit(object sender, System.EventArgs e)
{
    LinkButton obj = sender as LinkButton;
    Selected_id.Value = obj.CommandArgument;

        using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
        {
            conn.Open();
            OleDbCommand cmd = new OleDbCommand();
            OleDbDataReader rs;


            string strsql = "select * from news where newsid = @newsid";
        cmd = new OleDbCommand(strsql, conn);
        cmd.Parameters.AddWithValue ("newsid", SqlDbType.Int).Value = Selected_id.Value;

        rs = cmd.ExecuteReader();

        if (rs.Read())
        {
         
            fname = rs["pic"].ToString();
            fname2 = rs["pic2"].ToString();
            fname3 = rs["pic3"].ToString();
            HiddenField2.Value = fname2;
            HiddenField3.Value = fname3;
            Image2.Visible = fname2 == "" ? false : true;
            Image3.Visible = fname3 == "" ? false : true;                               
            subject.Text = rs["subject"].ToString();
            contents.Text = rs["contents"].ToString();
            strdat.Text = DateTime.Parse(rs["strdat"].ToString()).ToString("yyyy/MM/dd");
                enddat.Text = DateTime.Parse(rs["enddat"].ToString()).ToString("yyyy/MM/dd");
                status.SelectedValue = rs["status"].ToString();
            Image1.ImageUrl = "../upload/" + fname;
            Image2.ImageUrl = "../upload/" + fname2;
            Image3.ImageUrl = "../upload/" + fname3;
            Image1.Visible = true;
            Image1.Width = 300;
            HiddenField1.Value = fname;
        }


        cmd.Dispose();
        rs.Close();
        conn.Close();
    }

    MultiView1.ActiveViewIndex = 1;
    Btn_save.CommandArgument = "edit";

}
protected void Btn_save_Click(object sender, System.EventArgs e)
{

    LinkButton obj = sender as LinkButton;
    if (FileUpload1.FileName != "")
    {
        string img_path = "../upload/";
        //fname = DateTime.Now.ToString("yyyyMMddHHmmssff") + unity.classlib.GetFileExt(FileUpload1.FileName);
            fname = unity.classlib.FileRename(FileUpload1.FileName);
            //filex.SaveAs(Server.MapPath(img_path + filex.FileName));
            FileUpload1.SaveAs(Server.MapPath(img_path + fname));
    }
    if (FileUpload2.FileName != "")
        {
            string img_path = "../upload/";
            fname2 = unity.classlib.FileRename(FileUpload1.FileName);
            FileUpload2.SaveAs(Server.MapPath(img_path + fname2));
        }

        if (FileUpload3.FileName != "")
        {
            string img_path = "../upload/";
            fname3 = unity.classlib.FileRename(FileUpload1.FileName);
            FileUpload3.SaveAs(Server.MapPath(img_path + fname3));
        }
        if (fname == "" && HiddenField1.Value != "") fname = HiddenField1.Value;
        if (fname2 == "" && HiddenField2.Value != "") fname2 = HiddenField2.Value;
        if (fname3 == "" && HiddenField3.Value != "") fname3 = HiddenField3.Value;
        Image1.ImageUrl = "../upload/" + fname;
        Image2.ImageUrl = "../upload/" + fname2;
        Image3.ImageUrl = "../upload/" + fname3;
        using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
        {
          
        conn.Open();
        string strsql = "";
        OleDbCommand cmd = new OleDbCommand();

      
            if (Btn_save.CommandArgument == "add")
        {
            strsql = @"insert into news ( subject , contents,strdat,enddat,status,pic ,pic2,pic3,viewcount ) 
            values
                ( @subject ,@contents,@strdat,@enddat,@status,@pic ,@pic2,@pic3,0  )";
            cmd = new OleDbCommand(strsql, conn);
            cmd.Parameters.AddWithValue ("subject", SqlDbType.NVarChar).Value = subject.Text;
            cmd.Parameters.AddWithValue("contents", SqlDbType.NVarChar).Value = contents.Text;
            cmd.Parameters.AddWithValue("strdat", SqlDbType.VarChar).Value =strdat.Text;
            cmd.Parameters.AddWithValue("enddat", SqlDbType.VarChar).Value = enddat.Text;
            cmd.Parameters.AddWithValue("status", SqlDbType.VarChar).Value = status.SelectedValue;
            cmd.Parameters.AddWithValue("pic", SqlDbType.VarChar).Value = fname;
            cmd.Parameters.AddWithValue("pic2", SqlDbType.VarChar).Value = fname2;
            cmd.Parameters.AddWithValue("pic3", SqlDbType.VarChar).Value = fname3;        

        }
        else
        {
            strsql = @"update  news set  subject=@subject ,contents=@contents,
                strdat=@strdat,enddat=@enddat,
            status=@status,pic=@pic,pic2=@pic2,pic3=@pic3 where newsid = @newsid";
            cmd = new OleDbCommand(strsql, conn);
            cmd.Parameters.AddWithValue("subject", SqlDbType.NVarChar).Value = subject.Text;
            cmd.Parameters.AddWithValue("contents", SqlDbType.NVarChar).Value = contents.Text;
            cmd.Parameters.AddWithValue("strdat", SqlDbType.VarChar).Value =strdat.Text;         
            cmd.Parameters.AddWithValue("enddat", SqlDbType.VarChar).Value = enddat.Text;
            cmd.Parameters.AddWithValue("status", SqlDbType.VarChar).Value = status.SelectedValue;
            cmd.Parameters.AddWithValue("pic", SqlDbType.VarChar).Value = fname;
            cmd.Parameters.AddWithValue("pic2", SqlDbType.VarChar).Value = fname2;
            cmd.Parameters.AddWithValue("pic3", SqlDbType.VarChar).Value = fname3;
            cmd.Parameters.AddWithValue("newsid", SqlDbType.Int).Value = Selected_id.Value;
            }
            cmd.ExecuteNonQuery();
        conn.Close();

    }

    selectSQL();
    MultiView1.ActiveViewIndex = 0;
}
protected void Btn_cancel_Click(object sender, System.EventArgs e)
{

    MultiView1.ActiveViewIndex = 0;
}
protected void Button1_Click1(object sender, EventArgs e)
{
    //    LinqDataSource1.Where = "subject.Contains(\"" + keyword.Text + "\")   ";
    selectSQL();
    // LinqDataSource1.Where = "account.Contains(""new"")"
}
public void selectSQL()
{
    string strsql = "select * from news where status<> 'D'  ";
    if (keyword.Text != "")
    {
        strsql += " and (subject like '%" + keyword.Text + "%' or contents like '%" + keyword.Text + "%')";
    }
    strsql += "order by newsid desc";
    SqlDataSource1.SelectCommand = strsql;

    ListView1.DataBind();
    MultiView1.ActiveViewIndex = 0;

}
//刪除
protected void link_delete(object sender, System.EventArgs e)
{
    LinkButton obj = sender as LinkButton;
        //string[] arg = obj.CommandArgument.ToString.Split(",");
        //sql_delete(arg[0], arg[1]);

        using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
        {
            OleDbCommand cmd = new OleDbCommand();
            conn.Open();
            cmd = new OleDbCommand("update news set status = 'D' where newsid = @newsid  ", conn);
            cmd.Parameters.AddWithValue("newsid", SqlDbType.Int).Value = obj.CommandArgument;
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();

        }
    selectSQL();

}
protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
{
    var pager = (DataPager)ListView1.FindControl("DataPager1");
    pager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
    selectSQL();
}
protected void Btn_add_Click(object sender, EventArgs e)
{
    Btn_save.CommandArgument = "add";
    MultiView1.ActiveViewIndex = 1;
    cleaninput();
}
public void cleaninput()
{
    Selected_id.Value = "";
        enddat.Text = "";
    subject.Text = "";
    contents.Text = "";
     strdat.Text = "";
    status.SelectedIndex = -1;
    Image1.Visible = false;

}

    protected void Button2_Click(object sender, EventArgs e)
    {


        using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
        {
            OleDbCommand cmd = new OleDbCommand();
            conn.Open();
            cmd = new OleDbCommand("update news set pic2 = '' where newsid = @newsid ", conn);
            cmd.Parameters.AddWithValue ("newsid", SqlDbType.Int).Value = Selected_id.Value;
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }
        Image2.Visible = false;
        HiddenField2.Value = "";
    }

    protected void Button3_Click(object sender, EventArgs e)
    {

        using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
        {
            OleDbCommand cmd = new OleDbCommand();
            conn.Open();
            cmd = new OleDbCommand("update news set pic3 = '' where newsid = @newsid ", conn);
            cmd.Parameters.AddWithValue ("newsid", SqlDbType.Int).Value = Selected_id.Value;
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }
        Image3.Visible = false;
        HiddenField3.Value = "";
    }



    protected void Button41_Click(object sender, EventArgs e)
    {
        using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
        {
            OleDbCommand cmd = new OleDbCommand();
            conn.Open();
            cmd = new OleDbCommand("update news set pic = '' where newsid = @newsid ", conn);
            cmd.Parameters.AddWithValue("newsid", SqlDbType.Int).Value = Selected_id.Value;
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }
        Image1.Visible = false;
        HiddenField1.Value = "";
    }
}
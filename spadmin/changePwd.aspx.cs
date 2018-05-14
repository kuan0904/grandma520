using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using unity;
public partial class spadmin_changePwd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userid"] == null )
            {
                Server.Transfer("login.aspx");
            }

            OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString);
      
           

            string strsql  = "SELECT * FROM admin_account where user_id = @userid";
            conn.Open();
             
            OleDbCommand cmd = new OleDbCommand(strsql, conn);
            OleDbDataReader rs;
            cmd.Parameters.Add("@userid", OleDbType.Numeric ).Value = Session["userid"].ToString();
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                account_pid.Text = rs["account_pid"].ToString ();
            }
            rs.Close();
            cmd.Dispose();
            conn.Close();

        }

    }

    protected void Btn_cancel_Click(object sender, EventArgs e)
    {
        Server.Transfer ("default.aspx");
    }

    protected void Btn_save_Click(object sender, EventArgs e)
    {
        int status = 0;

        OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString);
        OleDbCommand cmd = default(OleDbCommand);
        string strsql = "";
        OleDbDataReader rs = default(OleDbDataReader);

        strsql = "SELECT * FROM Users where user_id = @user_id and account_pwd=@account_pwd";
        cmd = new OleDbCommand(strsql, conn);
        cmd.Parameters.Add("@userid", OleDbType.Numeric).Value = Session["userid"].ToString();
        cmd.Parameters.Add("@account_pwd", OleDbType.VarChar ).Value =   account_pwd0.Text;
        conn.Open();
        rs = cmd.ExecuteReader();
        if (rs.Read())
        {
            status = 1;
        }
        rs.Close();
        cmd.Dispose();
        if (status == 0)
        {
            strsql = "update Users set account_pwd=@account_pwd where user_id = @userid" ;
            cmd = new OleDbCommand(strsql, conn);
           
            cmd.Parameters.Add("@userid", OleDbType.Numeric).Value = Session["userid"].ToString();
            cmd.Parameters.Add("@account_pwd", OleDbType.VarChar).Value = userpwd.Text.Trim () ;
            cmd.ExecuteNonQuery();
           
            cmd.Dispose();
            status = 2;
        }
        conn.Close();

        string js = null;
        if (status == 1)
        {
            js = "<script language=\"javascript\">alert('原密碼錯誤，請重新輸入');</script>";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", js, false);

        }
        else if (status == 2)
        {
            Session["userid"] = null ;
            Session["username"] = null ;
            Session.Abandon();

            js = "<script language=\"javascript\"> ";
            js +=  "alert('更新完畢,請重新登入');";
            js +=  " window.top.location.href =\"default.aspx\";";
            // 導向下一頁
            js += " </script>";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", js, false);

        }

    }
}
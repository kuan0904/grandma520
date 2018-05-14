using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using unity;
using System.Data;
using System.Collections.Specialized;
public partial class spadmin_memberdata : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GridView1.AllowPaging = false;
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("id", "0");
        string strsql = @"select * , year(birthday) AS 年, Month(birthday) AS 月,day(birthday) AS 日  from memberorder  where   memberid >@id ";
     

        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
        GridView1.DataSource = dt;
        GridView1.DataBind();

        export_excel("gridview1", "output", 1);


        dt.Dispose();
     
    }
    private void export_excel(string gvname, string filename, int t_mode)
    {
        //  呼叫方式 export_excel("gridview1", "output",1);
        // export_excel(要匯出的 Gridview 名稱, 匯出的檔名,模式);  // 1=會加入日期時間

        GridView xgv = (GridView)FindControl(gvname);
        string style = "<style> .text { mso-number-format:\\@; } </script> ";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw);
        Response.Clear();
        if (t_mode == 1)  // 加上時間日期
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "_" + DateTime.Now.ToString("yyyyMMdd-HHmm") + ".xls");
        else
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + ".xls");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>");
        GridView1.RenderControl(hw);
        Response.Write(style);
        Response.Write(sw.ToString().Replace("<div>", "").Replace("</div>", ""));
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        //處理'GridView' 的控制項 'GridView' 必須置於有 runat=server 的表單標記之中
    }

}
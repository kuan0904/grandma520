﻿using System;
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
using System.Collections.Specialized;

public partial class spadmin_product : System.Web.UI.Page
{

    public string[] stringArray = new string[5];
    
    protected void Page_Init(object sender, EventArgs e)
    {
        DropDownList1.DataBound  += new EventHandler(DropDownList1_DataBound);
        string strsql = "select * from category where status <> 'D' and c_id>@id " ;
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("id", "0");
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);                 
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string name = dt.Rows[i]["c_name"].ToString();
            string id = dt.Rows[i]["c_id"].ToString();
            c_id.Items.Add(new ListItem(name, id));
                
        }
        dt.Dispose();
   
         

     }
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
        Image2.Visible = true;
        Image3.Visible = true ;
        LinkButton obj = sender as LinkButton;
        Selected_id.Value   = obj.CommandArgument;
      
        string strsql = "select * from productdata where p_id  = @p_id";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("p_id", Selected_id.Value  );
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
        price.Text = dt.Rows[0]["price"].ToString();
        pricing .Text = dt.Rows[0]["pricing"].ToString();
        p_id.Text = dt.Rows[0]["p_id"].ToString();
        productname.Text = dt.Rows[0]["productname"].ToString();
        storage.Text = dt.Rows[0]["storage"].ToString();
        description.Text = dt.Rows[0]["description"].ToString();
        status.SelectedValue = dt.Rows[0]["status"].ToString();
        c_id.SelectedValue = dt.Rows[0]["c_id"].ToString();
        stringArray[1] = dt.Rows[0]["pic1"].ToString();
        stringArray[2] = dt.Rows[0]["pic2"].ToString();
        stringArray[3] = dt.Rows[0]["pic3"].ToString();
        stringArray[0] = dt.Rows[0]["logo"].ToString();
        stringArray[4] = dt.Rows[0]["banner"].ToString();
        sort.Text = dt.Rows[0]["sort"].ToString();
        memos.Text = dt.Rows[0]["memos"].ToString();
        Image1.ImageUrl = "../upload/" + stringArray[1] + "?" + DateTime.Now.ToString("yyyyMMddhhmmss");
        if (stringArray[2] != "") 
            Image2.ImageUrl = "../upload/" + stringArray[2] + "?" + DateTime.Now.ToString("yyyyMMddhhmmss"); 
        else
            Image2.Visible = false;
        if (stringArray[3] != "")
            Image3.ImageUrl = "../upload/" + stringArray[3] + "?" + DateTime.Now.ToString("yyyyMMddhhmmss"); 
        else
            Image3.Visible = false;     
        viewcount.Text = dt.Rows[0]["viewcount"].ToString();
        promo.Checked = dt.Rows[0]["promo"].ToString() == "1" ? true : false;
        //1.免運費
        //2
        //3

        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";
        if (obj.CommandName == "copy")
        {
      
            Btn_save.CommandArgument = "copy";
        }
        

    }
    protected void Btn_add_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "add";
        cleaninput();
    }
    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
        int i = 0;     
        LinkButton obj = sender as LinkButton;
        NameValueCollection nvc = new NameValueCollection();
        string strsql = "";
        if (Btn_save.CommandArgument == "copy" || Btn_save.CommandArgument == "add")
        {
            strsql = "insert into productdata (viewcount) values (@viewcount ) ";           
            nvc.Add("viewcount", "0");
            i = admin_contrl.Data_add (strsql, nvc);           
            strsql = "select max(p_id ) from productdata  where p_id >@p_id ";
            nvc.Clear();
            nvc.Add("p_id", "0");
            DataTable dt = admin_contrl.Data_Get(strsql, nvc);
            p_id.Text = dt.Rows[0][0].ToString();           
        }

        string img_path = "../upload/";
        if (Image1.ImageUrl != "") stringArray[1] = p_id.Text + "-1.jpg";
        if (Image2.ImageUrl != "") stringArray[2] = p_id.Text + "-2.jpg";
        if (Image3.ImageUrl != "") stringArray[3] = p_id.Text + "-3.jpg";
        if (FileUpload1.FileName != "")
        {
            FileUpload1.SaveAs(Server.MapPath(img_path + p_id.Text  + "-1.jpg" ));
            stringArray[1] = p_id.Text + "-1.jpg";
        }
        if (FileUpload2.FileName != "") { 
            FileUpload2.SaveAs(Server.MapPath(img_path + p_id.Text + "-2.jpg" ));
            stringArray[2] = p_id.Text + "-2.jpg";
        }
        if (FileUpload3.FileName != ""){
            FileUpload3.SaveAs(Server.MapPath(img_path + p_id.Text + "-3.jpg"));
            stringArray[3] = p_id.Text  + "-3.jpg";
        }

        if (sort.Text == "") sort.Text = "0";
       string promotxt =    promo.Checked ==  true  ? "1" :"";
        strsql = @"UPDATE  productdata  SET productname=@productname,price=@price
                ,description = @description, storage = @storage, pic1 = @pic1, pic2 = @pic2,pic3 = @pic3,
                c_Id = @c_Id,  status = @status,sort=@sort ,memos =@memos,pricing  =@pricing  ,promo=@promo where p_id=@id ";      
             nvc.Clear();        
            nvc.Add("productname", productname.Text ) ;
             nvc.Add("price", price.Text);    
            nvc.Add("description", description.Text);
            nvc.Add("storage", storage.Text);             
            nvc.Add("pic1", stringArray[1] == null ? "" : stringArray[1]);
            nvc.Add("pic2", stringArray[2] == null ? "" : stringArray[2]);
            nvc.Add("pic3", stringArray[3] == null ? "" : stringArray[3]);
            nvc.Add("c_Id", c_id.SelectedValue);
            nvc.Add("status", status.SelectedValue);
            nvc.Add("sort", sort.Text);
            nvc.Add("memos",memos.Text);
        nvc.Add("pricing ", pricing.Text  );
        nvc.Add("promo ", promotxt);
        nvc.Add("p_id", p_id.Text);
        i = admin_contrl.Data_update(strsql, nvc, p_id.Text);
   
      
        selectSQL();
            MultiView1.ActiveViewIndex = 0;
    }
    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {

        MultiView1.ActiveViewIndex = 0;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //        string.Contains("pattern") is equivalent to LIKE '%pattern%'
        //string.StartsWith("pattern") is equivalent to LIKE 'pattern%'
        //string.EndsWith("pattern") is equivalent to LIKE '%pattern'
    }
    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {

        DropDownList obj = sender as DropDownList;
        obj.Items.Insert(0, new ListItem("不區分", ""));

    }
    public void selectSQL(string sorttype = "desc", string sortColumn = "p_id")
    {
        viewDataSource.SelectParameters.Clear();
        string strsql = " SELECT  * ,(select c_name from  category  where category.c_id =  productdata.c_id) as c_name   from  productdata    where status <> 'D' ";
    
        if (search_txt.Text != "")
        {
            int n;
            bool isNumeric = int.TryParse(search_txt.Text, out n);     
      
                strsql += @" and (memos like '%'+@S+'%'    or productname like '%'+@S+'%'   or description like '%'+@S+'%')  ";
            viewDataSource.SelectParameters.Add("S", search_txt.Text);
        }
        if (DropDownList1.SelectedIndex >0)
        {
            strsql += " and  c_id = @c_id";
            viewDataSource.SelectParameters.Add("c_id",  DropDownList1.SelectedValue );

        }
    
        strsql += " ORDER BY  sort," + sortColumn + " " + sorttype;
        viewDataSource.SelectCommand = strsql;
        ListView1.DataSourceID  = viewDataSource.ID;
        ListView1.DataBind();

        MultiView1.ActiveViewIndex = 0;
    }
    protected void ContactsListView_PagePropertiesChanging(object sender,  PagePropertiesChangingEventArgs e)
    {
        var pager = (DataPager)ListView1.FindControl("DataPager1");
        pager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);       
        selectSQL();
    }

    protected void btn_search_click(object sender, EventArgs e)
    {
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
    public void cleaninput()
    {
        p_id.Text = "";
    
        ContentPlaceHolder mp;       
        mp =          (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
        MultiView mu1;
        mu1 = (MultiView) mp.FindControl ("MultiView1");
        View vi2 =(View ) mu1.FindControl("view2");
        foreach (Control x in vi2.Controls)
        {
           
            if (x is TextBox)
            {
            
                ((TextBox)x).Text ="";
            }
            if (x is DropDownList )
            {

                ((DropDownList)x).SelectedIndex = 0;
            }
            if (x is Image)
            {

                ((Image)x).ImageUrl = "";
            }
        }        
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
        cmd = new OleDbCommand("update productdata set status = 'D' where p_id = @p_id ", conn);
        cmd.Parameters.Add("@p_id", OleDbType.Numeric).Value = obj.CommandArgument ;
        cmd.ExecuteNonQuery();
        cmd.Dispose();        
        conn.Close();

        selectSQL();
   

    }




    protected void img_del(object sender, EventArgs e)
    {
        LinkButton  obj = (LinkButton)sender;
      
        obj.CommandArgument = Selected_id.Value ;
        using (OleDbConnection conn = new OleDbConnection(classlib.dbConnectionString))
        {
            string strsql = @"update productdata set " + obj.CommandName + " = '' where p_id =" + obj.CommandArgument;
          
            conn.Open();
            OleDbDataAdapter myAdapter = new OleDbDataAdapter();
            OleDbCommand cmd = new OleDbCommand(strsql, conn);
           // cmd.Parameters.Add("@p_id", OleDbType.Numeric).Value = obj.CommandArgument;
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
            link_edit(obj, e);
        }
    }
}
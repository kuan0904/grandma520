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
using System.IO;
using System.Text;
using unity;
using System.Collections.Specialized;
using System.Net;
public partial class spadmin_orderdata : System.Web.UI.Page
{

    public string ord_code = "";
    public string ord_date = "";
    public string totalprice = "";
    public string DeliveryPrice = "";
    public string ordname = "";
    public string ordphone = "";
    public string ordaddress = "";
    public string SubPrice = "";
    public string email = "";
    public string memberid = "";
    public string ord_id = "";
    public string CardAUTHINFO = "";
    public string outfile = "";
    public string discount = "";
    public string mobile = "";

    protected void Page_Init(object sender, EventArgs e)
    {
        //   Export("application/ms-excel", "employee.xls")
        enddate.Text = DateTime.Today.ToString("yyyy/MM/dd");
        strdate.Text = DateTime.Today.AddDays (-7).ToString("yyyy/MM/dd");
        DataTable dt = new DataTable();
        string strsql = "select * from Receivetime where status=@status";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("status", "Y");
        dt = admin_contrl.Data_Get(strsql, nvc);
        receivetime.DataSource = dt;
        receivetime.DataBind();
        dt.Dispose();

        strsql = "select * from invoice where status=@status";
        dt = admin_contrl.Data_Get(strsql, nvc);
        invoice.DataSource = dt;
        invoice.DataBind();
        dt.Dispose();

        strsql = "select * from paymode where status=@status";
        dt = admin_contrl.Data_Get(strsql, nvc);
        paymode.DataSource = dt;
        paymode.DataBind();

        strsql = "select * from payStatus where status=@status";
        dt = admin_contrl.Data_Get(strsql, nvc);
        payStatus.DataSource = dt;
        payStatus.DataBind();
        qstatus.DataSource = dt;
        qstatus.DataBind();
        qstatus.Items.Insert(0, new ListItem("不區分"));
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Literal2.Text = "";
        outfile = "";
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
           
        }
      
    }
    protected void link_edit(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        Selected_id.Value = obj.CommandArgument;
     
        DataTable dt= new DataTable() ;
        string strsql = "select * from OrderData where ord_id=@ord_id";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("ord_id", Selected_id.Value  );
        dt= admin_contrl.Data_Get(strsql, nvc);
        totalprice = dt.Rows[0]["totalprice"].ToString();
        ord_code = dt.Rows[0]["ord_code"].ToString();
        ord_date = DateTime.Parse(dt.Rows[0]["crtdat"].ToString()).ToString("yyyy/MM/dd hh:mm tt");
        paymode .SelectedValue = dt.Rows[0]["paymode"].ToString();
        receivetime.SelectedValue  = dt.Rows[0]["receivetime"].ToString();
        invoice .SelectedValue = dt.Rows[0]["invoice"].ToString();
        contents.Text  = dt.Rows[0]["contents"].ToString();
        ordname = dt.Rows[0]["ordname"].ToString();
        ordphone = dt.Rows[0]["ordphone"].ToString();
        ordaddress = dt.Rows[0]["ordaddress"].ToString();
        shipname.Text= dt.Rows[0]["shipname"].ToString();
        shipphone.Text  = dt.Rows[0]["shipphone"].ToString();
        shipaddress.Text  = dt.Rows[0]["shipaddress"].ToString();
        atmCode.Text  = dt.Rows[0]["atmCode"].ToString();
        email = dt.Rows[0]["memberid"].ToString();
        DeliveryPrice = dt.Rows[0]["DeliveryPrice"].ToString();
        SubPrice = dt.Rows[0]["SubPrice"].ToString();
        memberid = dt.Rows[0]["memberid"].ToString();
        ord_id = dt.Rows[0]["ord_id"].ToString();
        payStatus.SelectedValue  = dt.Rows[0]["status"].ToString();
        companyno.Text = dt.Rows[0]["companyno"].ToString();
        title.Text = dt.Rows[0]["title"].ToString();
        discount = dt.Rows[0]["DiscountPrice"].ToString();
        mobile = dt.Rows[0]["mobile"].ToString();
        coupon_no.Text = dt.Rows[0]["coupon_no"].ToString();
        if (dt.Rows[0]["paid"].ToString() == "Y")
            paid.SelectedValue = "Y";
        else
            paid.SelectedValue = "N";
        dt.Dispose();
        nvc.Clear();
        nvc.Add("ord_code", ord_code);
        strsql = @"select * , OrderDetail.price as sellprice FROM         OrderDetail INNER JOIN
                      productData ON OrderDetail.p_id = productData.p_id where ord_code=@ord_code";
        dt = admin_contrl.Data_Get(strsql, nvc);
        Repeater1.DataSource = dt;
        Repeater1.DataBind();

        strsql = "select * from CardAUTHINFO where ord_code=@ord_code";
        nvc.Clear();
        nvc.Add("ord_code", ord_code);
        dt = admin_contrl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0)
        {
            CardAUTHINFO = "授權碼:" + dt.Rows[0]["AUTHCODE"].ToString() + "<br>授權結果:" + dt.Rows[0]["AUTHMSG"].ToString();

        }
        dt.Dispose();

        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";

    }
    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
        string strsql = @"update  OrderData set 
        paymode=@paymode,
        invoice=@invoice,
        receivetime=@receivetime,
        shipname=@shipname,
        shipphone=@shipphone,
        shipaddress=@shipaddress,     
        contents=@contents,
        companyno=@companyno,
        status =@status,
        coupon_no=@coupon_no,
        atmcode=@atmcode,
        title=@title,
        paid=@paid
        where ord_id=@ord_id";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("paymode", paymode.SelectedValue);
        nvc.Add("invoice", invoice.SelectedValue);
        nvc.Add("receivetime", receivetime.SelectedValue);       
        nvc.Add("shipname", shipname.Text);
        nvc.Add("shipphone", shipphone.Text);
        nvc.Add("shipaddress", shipaddress.Text);
        nvc.Add("contents", contents.Text );
        nvc.Add("companyno", companyno.Text);
        nvc.Add("status", payStatus.SelectedValue);
        nvc.Add("coupon_no", coupon_no.Text);
        nvc.Add("atmCode ", atmCode .Text);
        nvc.Add("title", title.Text);
        nvc.Add("paid", paid.SelectedValue );
        nvc.Add("ord_id", Selected_id.Value);                   
        int i = admin_contrl.Data_add(strsql, nvc);
        nvc.Clear();
    
        LinkButton obj = sender as LinkButton;
        selectSQL();
        MultiView1.ActiveViewIndex = 0;
    }
    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {

        MultiView1.ActiveViewIndex = 0;
    }

    protected void btn_search_Click(object sender, EventArgs e)
    {
        //        string.Contains("pattern") is equivalent to LIKE '%pattern%'
        //string.StartsWith("pattern") is equivalent to LIKE 'pattern%'
        //string.EndsWith("pattern") is equivalent to LIKE '%pattern'
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


    public void selectSQL(string sorttype = "desc", string sortColumn = "ord_id")
    {

        NameValueCollection nvc = new NameValueCollection();
        string strsql = @" SELECT  * 
      
                    FROM   OrderData INNER JOIN
                      payStatus ON OrderData.status =payStatus.id            where ord_id > 0  and  OrderData.status <> 0  ";
        if ( qpaykind.SelectedIndex > 0)
        {
            strsql += " and paymode= " + qpaykind.SelectedValue + "";
        }
        if (qstatus .SelectedIndex > 0)
        {
            strsql += " and OrderData.status= " +  qstatus .SelectedValue + " ";
        }
        if (strdate.Text != "")   strsql += " and crtdat >= #" + strdate.Text  + "#";               
        if (enddate.Text != "")   strsql += " and crtdat <= #" +  enddate.Text + " 23:59:59#";        
      
        if (keyword.Text != "")
        {
            strsql += " and ( ord_code like '%'+@S+'%'  or ord_name like '%'+@S+'%' or ord_email like '%'+@S+'%' or ord_ship_name like '%'+@S+'%' or ord_ship_email like '%'+@S+'%' ) ";
           
            //SqlDataSource3.SelectParameters.Add("S", keyword.Text);
            nvc.Add("S", keyword.Text);
        }
              
        string sql_select = strsql + " ORDER BY  " + sortColumn + " " + sorttype;
        DataTable dt = admin_contrl.Data_Get(sql_select, nvc);
        ListView1.DataSource = dt;
        ListView1.DataBind();
       
        dt = admin_contrl.Data_Get(strsql.Replace ("*", "COUNT(*), SUM(totalprice)"), nvc);
        Literal1.Text = "<b> 訂單筆數:" + dt.Rows[0][0].ToString() + "   訂單金額合計:" + dt.Rows[0][1].ToString() + "</b>" ;
    

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
    public string get_pd(string ord_code)
    {
        string msg = "";
        string strsql = @"SELECT productdata.productname 
        FROM productdata INNER JOIN orderdetail ON  productdata.p_id = orderdetail.p_id
        WHERE orderdetail.ord_code = @ord_code      ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("ord_code", ord_code);
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
        for (int i= 0; i < dt.Rows.Count; i++)
        {
        msg += dt.Rows[i][0].ToString () + "<br>";
        }  
       
        return msg;
    }

    public string get_num(string ord_code,string status)
    {
        string msg = "";
        string strsql = @"SELECT count(*)   FROM smslog     WHERE ord_code = @ord_code   and status=@status   ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("ord_code", ord_code);
        nvc.Add("status", status);
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            msg += dt.Rows[i][0].ToString() ;
        }

        return msg;
    }


    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Button b1 = (Button)e.Item.FindControl("Button1");
            System.Data.DataRowView rowView = e.Item.DataItem as System.Data.DataRowView;

        }
   
   
    }




    protected void btn_csv_Click(object sender, EventArgs e)
    {
        string strsql = @" SELECT  *  ,(select sum(num) from OrderDetail where  OrderDetail.ord_code =  OrderData.ord_code) as num
                    ,(select name from  paymode  where  id= OrderData.paymode) as payname 
                FROM   OrderData INNER JOIN
                      payStatus ON OrderData.status =payStatus.id            where ord_id > 0 and  OrderData.status <> 0 ";
        NameValueCollection nvc = new NameValueCollection();
        if (qpaykind.SelectedIndex > 0)
        {
            strsql += " and paymode= " + qpaykind.SelectedValue + "";
        }
        if (qstatus.SelectedIndex > 0)
        {
            strsql += " and OrderData.status= " + qstatus.SelectedValue + " ";
        }
        if (strdate.Text != "") strsql += " and crtdat >= #" + strdate.Text + "#";
        if (enddate.Text != "") strsql += " and crtdat <= #" + enddate.Text +  " 23:59:59#";

        if (keyword.Text != "")
        {
            strsql += " and ( ord_code like '%'+@S+'%'  or ord_name like '%'+@S+'%' or ord_email like '%'+@S+'%' or ord_ship_name like '%'+@S+'%' or ord_ship_email like '%'+@S+'%' ) ";

            //SqlDataSource3.SelectParameters.Add("S", keyword.Text);
            nvc.Add("S", keyword.Text);
        }


        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
        int i = 0;
        string out_csv = "訂單編號 , 訂單日期, 訂單人,訂單內容,規格,收件人,地址,收件人電話, 收件時間,備註說明,金額,付款方式,後五碼,發票 " + "\r\n";

        for (i = 0; i < dt.Rows.Count; i++)
        {
            string num = "60";
            if (dt.Rows[i]["num"].ToString ()  != "")
            {
              
                if (int.Parse(dt.Rows[i]["num"].ToString()) > 6)
                    num = "120";
                else if (int.Parse(dt.Rows[i]["num"].ToString()) < 4)
                    num = "60";
                else
                    num = "90";
            }
            string receivetime = dt.Rows[i]["receivetime"].ToString();
            if (receivetime == "1") receivetime = "4";
            if (receivetime == "2") receivetime = "1";
            if (receivetime == "3") receivetime = "2";

            string pdname = "";
            strsql = @"select *  FROM  OrderDetail INNER JOIN
                      productData ON OrderDetail.p_id = productData.p_id
               where ord_code=@ord_code";
            nvc.Clear();
            nvc.Add("ord_code", dt.Rows[i]["ord_code"].ToString());
            DataTable detail = admin_contrl.Data_Get(strsql, nvc);
            for (int j=0;j<detail.Rows.Count; j++)
            {
                pdname +=  detail.Rows[j]["productname"].ToString() 
                    +  "* " + detail.Rows[j]["num"].ToString() +  "／"  ;
                //"," + detail.Rows[j]["price"].ToString()


            }
            out_csv += dt.Rows[i]["ord_code"].ToString() +
         "-," + DateTime.Parse(dt.Rows[i]["crtdat"].ToString()).ToString("yyyy-MM-dd") +
              "," + dt.Rows[i]["ordname"].ToString() +
         "," + pdname +
            "," + num +
         "," + dt.Rows[i]["shipname"].ToString() +
         "," + dt.Rows[i]["shipaddress"].ToString() +
         "," + dt.Rows[i]["shipphone"].ToString() +
         " -," + receivetime +
         "," + dt.Rows[i]["contents"].ToString() +
            "," + dt.Rows[i]["totalprice"].ToString() +
         "," + dt.Rows[i]["payname"].ToString() + 
           "," + dt.Rows[i]["atmcode"].ToString() + "," + dt.Rows[i]["invoice"].ToString() + "\r\n";
        }
        string filenname = Server.MapPath("orderdata/order_" +  DateTime.Now.ToString ("yyyyMMdd") +".csv");
        using (StreamWriter file =
        new StreamWriter(filenname, false, Encoding.UTF8))
        {
            file.WriteLine(out_csv);
            file.Close();
            file.Dispose();
        }
        outfile = "<br><a href=\"orderdata/order_" + DateTime.Now.ToString("yyyyMMdd") + ".csv"  + "\" target=\"_blank\"><h2>下載檔案</h2></a>";
    }

    protected void Button_send1_Click(object sender, EventArgs e)
    {

        Button btn = (Button ) sender;
        Encoding encoding = Encoding.GetEncoding(950);
       
        string strsql = @" SELECT  *  FROM   OrderData     where ord_id  =@ord_id ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("ord_id", btn.CommandArgument );
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
         string phone = dt.Rows[0]["ordphone"].ToString();      
        string ord_code = dt.Rows[0]["ord_code"].ToString();
        string TotalPrice = dt.Rows[0]["totalprice"].ToString();
        nvc.Clear();
        dt.Dispose();
        strsql = @" SELECT  *  FROM   promo_system   where ps_id  =@ps_id ";
        nvc.Add("ps_id", "12");
        dt = admin_contrl.Data_Get(strsql, nvc);
        string msg = dt.Rows[0]["contents"].ToString(); 
        msg = msg.Replace("@ord_code@", ord_code);
        msg = msg.Replace("@TotalPrice@", TotalPrice.ToString());
        msg = msg.Replace("<p>", "").Replace("</p>", "");
        string kmsgid = classlib.Sendsms(phone, msg);
       // Literal2.Text = "<script>$(document).ready(function(){ alert('簡詢已送出!');});</script>";
        strsql = "insert into smslog (ord_code,status) values ('" + ord_code + "','收款')";
        nvc.Add("ord_code", "ord_code");
         admin_contrl.Data_add (strsql, nvc);
        selectSQL();

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        Encoding encoding = Encoding.GetEncoding(950);
        string strsql = @" SELECT  *  FROM   OrderData     where ord_id  =@ord_id ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("ord_id", btn.CommandArgument);
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
        string phone = dt.Rows[0]["ordphone"].ToString();
        string ord_code = dt.Rows[0]["ord_code"].ToString();
        nvc.Clear();
        dt.Dispose();
        strsql = @" SELECT  *  FROM   promo_system   where ps_id  =@ps_id ";
        nvc.Add("ps_id", "13");
        dt = admin_contrl.Data_Get(strsql, nvc);
        string msg = dt.Rows[0]["contents"].ToString();
        msg = msg.Replace("@ord_code@", ord_code);
        // msg = msg.Replace("@TotalPrice@", TotalPrice.ToString());
        msg = msg.Replace("<p>", "").Replace("</p>", "");
        string kmsgid = classlib.Sendsms(phone, msg);
       // Literal2.Text = "<script>$(document).ready(function(){ alert('簡詢已送出!');});</script>";
        strsql = "insert into smslog (ord_code,status) values ('" + ord_code + "','出貨')";
        nvc.Add("ord_code", "ord_code");
        admin_contrl.Data_add(strsql, nvc);
        nvc.Clear();
        strsql = @"update  OrderData set status =4 where ord_id  =@ord_id ";
        nvc.Add("ord_id", btn.CommandArgument);

        selectSQL();
    }



}
<%@ WebHandler Language="C#" Class="Shoppinglist" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Collections.Generic;
using unity;
public class Shoppinglist : IHttpHandler,IRequiresSessionState  {

    public void ProcessRequest (HttpContext c) {
        string  shopCounts ="0";
        string shipitem = "";
        if (c.Session["ShoppingList"] != null)
        {

            List<ShoppingList> Shoppinglist = new List<ShoppingList>();
            Shoppinglist = c.Session["ShoppingList"] as List<ShoppingList>;
           // shopCounts = Shoppinglist.Count().ToString();
            foreach (ShoppingList idx in Shoppinglist)
            {

                shipitem += idx.productname+ "<span>*" + idx.num + "</span><br>";

            }
        }
        c.Response.Write (shipitem);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
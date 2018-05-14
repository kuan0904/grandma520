using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using unity;
public partial class MasterPage : System.Web.UI.MasterPage
{
    public string  shopCounts ="0";
    public string shipitem = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ShoppingList"] != null)
        {

            List<ShoppingList> Shoppinglist = new List<ShoppingList>();
            Shoppinglist = Session["ShoppingList"] as List<ShoppingList>;
            shopCounts = Shoppinglist.Count().ToString();
            foreach (ShoppingList idx in Shoppinglist)
            {

                shipitem += idx.productname+ "<span>*" + idx.num + "</span><br>";        

            }
        }
    }
}

using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using MyPublic;
using System.Data;
using System.Data.OleDb;


using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web.Security;
using System.Web.UI.WebControls;


public partial class Account_Login : Page
{
    private const string AntiXsrfTokenKey = "__AntiXsrfToken";
    private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
    private string _antiXsrfTokenValue;

    protected void Page_Init(object sender, EventArgs e)
    {
        Session["companyName"] = "外婆滴雞精";
        // 下面的程式碼有助於防禦 XSRF 攻擊
        var requestCookie = Request.Cookies[AntiXsrfTokenKey];
        Guid requestCookieGuidValue;
        if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
        {
            // 使用 Cookie 中的 Anti-XSRF 權杖
            _antiXsrfTokenValue = requestCookie.Value;
            Page.ViewStateUserKey = _antiXsrfTokenValue;
        }
        else
        {
            // 產生新的防 XSRF 權杖並儲存到 cookie
            _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
            Page.ViewStateUserKey = _antiXsrfTokenValue;

            var responseCookie = new HttpCookie(AntiXsrfTokenKey)
            {
                HttpOnly = true,
                Value = _antiXsrfTokenValue
            };
            if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
            {
                responseCookie.Secure = true;
            }
            Response.Cookies.Set(responseCookie);
        }

      
    }


    protected void Page_Load(object sender, EventArgs e)
        {
        if (!IsPostBack)
        {
            // 設定 Anti-XSRF 權杖
            ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
            ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
        }
        else
        {
            // 驗證 Anti-XSRF 權杖
            if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
            {
                throw new InvalidOperationException("Anti-XSRF 權杖驗證失敗。");
            }
        }

        var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
           
        }

    protected void LogIn(object sender, EventArgs e)
    {

        //  Context.GetOwinContext().Authentication.SignOut();
        if (IsValid)
        {

            string sql;
            sql = "select * from admin_account where account_pid = @account_pid and account_pwd = @account_pwd  ";
            bool results = false;
            OleDbConnection conn = new OleDbConnection(unity.classlib.dbConnectionString);
            conn.Open();
            OleDbCommand cmd = new OleDbCommand(sql, conn);
            OleDbDataReader rs;
            cmd.Parameters.Add("@account_pid", OleDbType.VarChar).Value = unity.classlib.RemoveBadSymbol(UserName.Text.Trim());
            cmd.Parameters.Add("@account_pwd", OleDbType.VarChar, 20).Value = unity.classlib.RemoveBadSymbol(Password.Text.Trim());
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                Session["userid"] = rs["user_id"].ToString();
                Session["username"] = rs["name"].ToString();
                Session.Timeout = 300;
                rs.Close();
                cmd.Dispose();
                //sql = "insert into login_log ( account_pid, login_time, login_ip) ";
                //sql += " values (@username,getdate(),'" + unity.classlib.getIP(Request) + "');";
                sql = "update  admin_account set login_times =  login_times +1, last_lgoin_ip = '" + unity.classlib.getIP(Request) + "' ";
                sql += " where user_id =@userid ";
                cmd = new OleDbCommand(sql, conn);
                cmd.Parameters.Add("@userid", OleDbType.Numeric ).Value = Session["userid"].ToString();
                rs = cmd.ExecuteReader();
                //cmd.ExecuteNonQuery();
                //cmd.Dispose();
                results = true;
                FailureText.Text = "";
            }
            else
            {
                FailureText.Text = "帳戶或密碼有誤";
            }
            rs.Close();
            cmd.Dispose();
            conn.Close();
            if (FailureText.Text == "") {
                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }





            }
     
      
        }
    }

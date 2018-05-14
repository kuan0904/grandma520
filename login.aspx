<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <script>
        function check() {
            var email = $("#<%=email.ClientID %>").val();
            var password = $("#<%=password.ClientID %>").val();
            if (email == "") {
                alert("請輸入Email");
                return false
            }

            if (password == "") {
                alert("請輸入Email");
                return false
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    
    <!--===========登入會員============-->
    <div class="oldBG">
        <section class="grey-bg mar-tm-10" id="work" style="padding-top:60px;">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div class="work_title">
                            <h1>登入 / 首次購物</h1>
                            <h2>Login member</h2>
                        </div>
                    </div>
                    <!--登入-->
                    <div class="col-md-6 linkBox">
                        <h2>登入會員</h2>
                        <br />
                        <form role="form">
                            <div class="form-group">
                                <label for="exampleInputEmail1">電子郵件</label> <asp:TextBox ID="email" runat="server"   class="form-control"  placeholder="輸入電子郵件"></asp:TextBox>                         
                                <div class="checkbox">
                                    <label>
                                    <input name="remeber" type="checkbox" value="Y"  <%= (Request.Cookies["memberdata"] !=null) ? "checked =\"checked\"":""   %> />    記住電子郵件
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">密碼</label><asp:TextBox ID="password" runat="server"   class="form-control"  TextMode="Password" placeholder="密碼"></asp:TextBox>                        
                                <a href="forgot"><p>忘記密碼</p></a>
                            </div><asp:LinkButton ID="LinkButton1" runat="server" OnClientClick ="return check();"   OnClick="LinkButton1_Click"   CssClass ="btn btn-warning btn-lg">登入會員</asp:LinkButton>
                        
                        </form>
                    </div>
                    <!--註冊-->
                    <div class="col-md-5 col-md-offset-1 linkBox">
                        <h2>免註冊!</h2>
                        <p>現在起結帳成功後系統將自動為您升級為會員！</p>
                        <p>
                            將喜愛的商品放入購物車完成訂購步驟，<br />
                            最後留下個人資料，系統將自動為您升級為會員。<br />
                            立即享受，如此輕鬆的快速線上購物<br />
                        </p>
                        <br />
                        <form role="form">
                            <button type="button" class="btn btn-warning btn-lg" onclick ="location.href='pay';">首次立即購物</button>                          
                        </form>
                    </div>

                    </div>              
            </div>
        </section>
    </div>
</asp:Content>


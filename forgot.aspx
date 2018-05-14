<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="forgot.aspx.cs" Inherits="forgot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    
    <script>
        function check() {
            var email = $("#<%=email.ClientID %>").val();
            if (email == "") {
                alert("請輸入Email");
                return false
            }


        }

    </script>


<div class="oldBG">
        <section class="grey-bg mar-tm-10" id="work" style="padding-top:60px;">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div class="work_title">
                            <h1>忘記密碼</h1>
                            <h2>Forgot Password</h2>
                        </div>
                    </div>
                    <!--電子郵件-->
                    <div class="col-md-6 linkBox">
                        <h2>提交電子郵件</h2>
                        <p>密碼將發送至您的電子郵件</p>
                        <br />
                     
                            <div class="form-group">
                                <label for="exampleInputEmail1">電子郵件</label>                           
                                <asp:TextBox   id="email"  runat="server" placeholder="輸入電子郵件" cssclass="form-control" ></asp:TextBox>                               
                            </div>                           
                      
                        <asp:LinkButton ID="LinkButton1" runat="server"  OnClick="LinkButton1_Click">      <button type="button" class="btn btn-warning btn-lg">送出</button>  </asp:LinkButton>
                    </div>                    
                    </div>              
            </div>
        </section>
    </div>  

</asp:Content>


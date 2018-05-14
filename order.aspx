<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="order.aspx.cs" Inherits="order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
        <!--===========會員中心============-->
    <div class="oldBG">
        <section class="grey-bg mar-tm-10" id="work" style="padding-top:60px;">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div class="work_title">
                            <h1>會員中心</h1>
                            <h2>member</h2>
                        </div>
                    </div>
                    <!-- 選單 -->
                        <div class="col-sm-3 col-sm-offset-1 blog-sidebar">                                 
                            <div class="list-group">                               
                                <a href="order" class="list-group-item active">訂單查詢</a>       
                                <a href="member" class="list-group-item">會員個資修改</a>          
                            
                            </div>
                        </div>
                    <!-- 資訊區(訂單查詢) -->
                        <div class="col-sm-8 blog-main">
                            <div class="pay">
                                <h3>訂單查詢</h3>
                            </div>
                            <div class="panel panel-default">
                                <!-- Default panel contents -->
                                <div class="panel-heading">訂單詳情</div>
                                <!-- Table -->
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>訂購日期</th>
                                            <th>訂單編號</th>
                                            <th>處理進度</th>
                                            <th>訂單總額</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="Repeater1" runat="server">
                                            <ItemTemplate>
                                                  <tr>
                                            <td><%# DateTime.Parse (  Eval("crtdat").ToString ()).ToString ("yyyy-MM-dd") %></td>
                                            <td><a href='order-info?ord_code=<%#Eval("ord_code") %>'><%#Eval("ord_code") %></a></td>
                                            <td><%#Eval("name") %></td>
                                            <td>NTD$<%#Eval("totalprice") %></td>
                                        </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>                                     
                                  
                                       
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>              
            </div>
        </section>
    </div>
</asp:Content>


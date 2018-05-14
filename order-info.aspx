<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="order-info.aspx.cs" Inherits="order_info" %>

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
                    <!-- 資訊區(訂單查詢>訂單nnn) -->
                        <div class="col-sm-8 blog-main">
                            <div class="pay">
                                <h3>訂單查詢</h3>
                            </div>
                            <div class="panel panel-default">
                                <!-- Default panel contents -->
                                <div class="panel-heading">訂單詳情>訂單編號:<%=ord_code  %></div>
                                <!-- Table -->
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>送貨地址</th>
                                            <th>付款方法</th>
                                            <th>收達時間</th> 
                                            <th>處裡進度</th> 
                                                                                    
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><%=username  %>, <%=mobile %>,<%=address  %></td>
                                            <td><%=paymode %></td>
                                            <td><%=receivetime %></td>
                                            <td><%=ordstatus %></td>                             
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="panel panel-default">
                                <!-- Default panel contents -->
                                <div class="panel-heading">訂購商品</div>
                                <!-- Table -->
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>商品名稱</th>
                                            <th>單價</th>
                                            <th>數量</th>                                            
                                            <th>小計</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="Repeater1" runat="server">
                                            <ItemTemplate>
                                            <tr>
                                                <td><%#Eval("productname") %></td>
                                                <td>NTD$<%#Eval("sellprice") %></td>
                                                <td><%#Eval("num") %></td>
                                                <td>NTD$<%#Eval("amount") %></td>
                                            </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <!--計算-->
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td>運費</td>
                                            <td>NTD$<%=DeliveryPrice %></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td>折扣</td>
                                            <td>NTD$-<%=DiscountPrice  %></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td><b>總額</b></td>
                                            <td><b>NTD$<%=TotalPrice %></b></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>              
            </div>
        </section>
    </div>
</asp:Content>


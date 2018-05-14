<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="pay-step02.aspx.cs" Inherits="pay_step02" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">

    <!--===========線上購物============-->
    <div class="oldBG">
        <section class="grey-bg mar-tm-10" id="work" style="padding-top: 60px;">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div class="work_title">
                            <h1>購物車</h1>
                            <h2>ShoppingCart</h2>
                        </div>
                    </div>
                    <div class="col-xs-6 col-lg-6 text-center" style="color: #bdbab5;">
                        <h1>
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span><strong>Step01 </strong>
                        </h1>
                        <h3>填寫訂單資訊
                        </h3>
                    </div>
                    <div class="col-xs-6 col-lg-6 text-center">
                        <h1>
                            <span class="glyphicon glyphicon-ok" aria-hidden="true"></span><strong>Step02 </strong>
                        </h1>
                        <h3>完成訂購
                        </h3>
                    </div>
                    <!-----------------購物清單---------------------->
                    <div class="col-xs-12 col-lg-12 ">
                        <div class="panel panel-default">
                            <div class="panel-heading">購物清單</div>
                            <!-- Table -->
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>品名</th>
                                        <th>規格</th>                                        
                                        <th>數量</th>
                                        <th>單價</th>
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
                          
                                 
                                    <tr class="warning">
                                        <td>小計</td>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <strong>NT$<%=SubPrice %></strong>
                                        </td>
                                    </tr>
                                </tbody>

                            </table>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <!----------訂單總計------------->
                    <div class="col-xs-12 col-lg-12 ">
                        <div class="panel panel-default">
                            <div class="panel-heading">訂單資訊</div>
                            <!-- Table -->
                            <table class="table">
                                <tbody>
                                         <tr>
                                        <td>訂單編號</td>
                                        <td><%=ord_code%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>購物總計</td>
                                        <td>NTD$<%=SubPrice%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>折扣優惠</td>
                                        <td>$<%=DiscountPrice  %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>付款方式<br />
                                        </td>
                                        <td><%=paymode %>
                                        </td>
                                    </tr>
                                       <tr>
                                        <td>運費<br />
                                        </td>
                                        <td>NTD$<%=DeliveryPrice %>
                                        </td>
                                    </tr>
                                    <tr class="warning">
                                        <td>訂單總額</td>
                                        <td>
                                            <strong>NTD$<%=TotalPrice %></strong>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!--付款方式-->
                    <div class="col-xs-12 col-lg-12 pay">
                        <h3>付款與配送</h3>
                        <h4>
                            <strong>【送貨方式】</strong> 黑貓冷凍宅配到府<br />
                            <strong>【帳號】 </strong>郵局700：2441115 0500210 許如雲<br />
                            <br />
                            注意：外婆滴雞精堅持手工新鮮現做，不添加防腐劑，宅配前必須預冷，以確保雞精新鮮，所以當大家收到時都是新鮮現滴的喔！
                        </h4>
                    </div>



                    <!--送出-->
                    <div class="col-xs-12 col-lg-12  text-center" style="padding-top: 40px; padding-bottom: 40px;">
                        <h4 style="color: #d75900;">感謝您的購買，外婆滴雞精祝您萬事如意
                        </h4>
                        <button type="button" class="btn btn-warning btn-lg">會員專區</button>
                        <button type="button" class="btn btn-default btn-lg"><a href="index">回首頁</a></button>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>


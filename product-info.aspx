<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="product-info.aspx.cs" Inherits="product_info" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        var price=<%=price  %>;
        var p_id = '<%=Request.QueryString ["p_id"]%>'      
        $(document).ready(function() {
            $("#addbuy").click(function () {
                var num = $("#num").val();	    
                goodsAdd(p_id, num,'add');
            });

            $("#num").change(function () {	
                var num= parseInt($(this).val());
                $.post('get_price.ashx', {
                    "p_ID": p_id
               , "p_num":num        
               , "_": new Date().getTime()
                }, function (data) {	           
                    var price= parseInt( data);	          
                    $(".buyq-total").html(num * price);
	     
                });
            });
        });
    </script>
        <script>
        $(document).ready(function () {

            $('img').each(function () {
                $(this).removeAttr('style')
            });
        });


    </script>
    <!--========  雞圖  =========-->
    <div class="ChickensBG">
        <section style="padding-top: 0px;" id="">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="single_image">
                            <img src="images/lifeImg_type.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">

    <!--===========線上購物============-->
    <div class="oldBG">
        <ol class="breadcrumb">
            <li><a href="index">首頁</a></li>
            <li><a href="product">線上購物</a></li>
            <li class="active"><%=productname %></li>
        </ol>
        <section>
            <div class="container" style="padding-bottom: 65px;">
                <div class="row case">
                    <div class="col-md-4 col-md-offset-2">
                        <div class="single_image" style="padding-top: 40px;">
                            <img src="upload/<%=pic %>" alt="" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="work_title">
                            <h1><%=productname %></h1>
                            <span style="font-size: 16px;text-decoration: line-through;color: #55703b;">原價NT$<%=Pricing  %></span>
                            <h4>NT$<span><%=price %></span>元</h4>
                        </div>
                        <ul>
                          
                            <li>
                                <p>規格：<%=memos %></p>
                            </li>
                        </ul>
                        <span align="right" width="100">數量：
                                    	<select class="buyq-select" id="num">
                                            <%=buy_num_option %>
                                        </select>
                        </span>
                        <div class="baton">
                            <a href="#">
                                <button type="button" class="btn btn-primary cs-btn" id="addbuy">加入購物車</button>
                            </a>
                        </div>
                        <div class="work_title  text-center">
                            <h3>分享給朋友：
                                <a href="">
                                    <img src="images/0_01.png" alt=""   id="FB" /></a>                               
                                <a href="">
                                    <img src="images/0_03.png" alt="" />
                                </a>
                            </h3>
                        </div>
                    </div>
                </div>
                <!--產品說明內文開始-->
                <div class="row">
                    <div class="col-md-8 col-md-offset-2 square">
                         <span  class="single_image"> <%=description %></span> 
                    </div>
                </div>
            </div>
        </section>
    </div>

</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="product.aspx.cs" Inherits="product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
        <!--===========線上購物============-->
    <div class="oldBG">
        <ol class="breadcrumb">
            <li><a href="http://www.grandma520.com/">首頁</a></li>          
            <li class="active">線上購物</li>
        </ol>
        <section class="grey-bg mar-tm-10" id="work">
            <div class="container">
                <div class="row case">
                    <div class="col-md-12 text-center">
                        <div class="work_title  wow fadeInUp animated cwTeXFangSong ">
                            <h1>線上購物</h1>
                            <h2>product</h2>
                        </div>
                        <div class="work_title  wow fadeInUp animated cwTeXFangSong" data-wow-delay="0.5s">
                            <h3><span><a href="product">全部</a></span>
                                <asp:Repeater ID="Repeater2" runat="server">
                                    <ItemTemplate> <span><a href="product?c_id=<%#Eval("C_id") %>"><%#Eval("C_name") %></a></span></ItemTemplate>
                                </asp:Repeater>                           
                      
                            </h3>                          
                        </div>
                    </div>
                    <!--1排-->
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                             <div class="col-xs-6 col-lg-4">
                                        <div class="single_image">
                                          <a href="product-info?p_id=<%#Eval("p_id") %>">
                                              <img src="upload/<%#Eval("pic1") %>" />
                                            <div class="image_overlay">
                                            </div>
                                            <div class="shadow">
                                                <div class="square">
                                                    <h4><%#Eval("productname") %></h4>
                                                    <h6><%#Eval("memos") %></h6>
                                                       <span style="font-size: 14px;text-decoration: line-through;color: #55703b;">原價NT$<%# Eval("Pricing")  %></span>
                                                    <h5>NT$<%#Eval("price") %></h5>
                                                </div>
                                            </div>
                                            </a>
                                        </div>
                                    </div>
                        </ItemTemplate>
                    </asp:Repeater>
                                       
 
                </div>
            </div>
        </section>
    </div>
</asp:Content>


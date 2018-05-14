<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="kitchen-info.aspx.cs" Inherits="kitchen_info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
        <!--===========外婆上菜內頁============-->
    <div class="oldBG">
        <ol class="breadcrumb">
            <li><a href="index">首頁</a></li>
            <li><a href="kitchen">外婆上菜</a></li>     
            <li class="active"><%=subject  %></li>       
        </ol>
        <section>
            <div class="container" style="padding-bottom:65px;">
                <div class="row case">
                    <div class="col-md-4 col-md-offset-2">
                        <div class="single_image" style="padding-top:40px;">
                            <img src="upload/<%=pic %>" alt="" />
                        </div>                                         
                    </div>
                    <div class="col-md-4">
                        <div class="work_title">
                            <h1><%=subject  %></h1>                            
                        </div> 
                        <p><%=subtitle%></p>   
                                    
                        <div class="work_title  text-center">
                            <h3>
                                分享給朋友：
                                <a href="#" ><img src="images/0_01.png" alt="" id="FB" /></a>
                                <a href=""><img src="images/0_02.png" alt="" /> </a>
                                <a href=""><img src="images/0_03.png" alt="" /> </a>
                            </h3>
                        </div>                         
                    </div>                     
                </div>
                <!--說明內文開始-->
                <div class="row">                                                                     
                    <div class="col-md-8 col-md-offset-2 square" >  
                     <span  class="single_image"><%=contents %></span> 
                    </div>

                    <!--上下篇-->
                    <div class="col-xs-6 col-lg-6 text-center kinfo">
                        <a href="">
                            <h3>
                                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span><strong> <a href="kitchen-info?d_id=<%=lasidx  %>">上一篇</a>  </strong>
                            </h3>                            
                        </a>
                    </div>
                    <div class="col-xs-6 col-lg-6 text-center kinfo">
                      <a href="">
                          <h3>
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span><strong> <a href="kitchen-info?d_id=<%=ntxidx   %>">下一篇 </a> </strong>
                        </h3>                        
                        </a>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>


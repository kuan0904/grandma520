<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="kitchen.aspx.cs" Inherits="kitchen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
        <!--===========外婆上菜============-->
    <div class="oldBG">
        <ol class="breadcrumb">
            <li><a href="/index">首頁</a></li>
            <li class="active">外婆上菜</li>
        </ol>
           <section style="padding-top:0px;">
              <div class="container">
                <div class="row case">
                    <div class="col-md-7" >                        
                         <div class="work_title  cwTeXFangSong  text-center ">
                             <h1>外婆上菜</h1>
                            <h2>kitchen</h2>
                        </div>                     
                             <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <div class="col-xs-6 col-md-6 text-center">
                            <div class="thumbnail">
                                <a href="kitchen-info?d_id=<%#Eval("d_id") %>">
                                    <img src="upload/<%#Eval("pic") %>" alt="">
                                    <div class="image_overlay">
                                    </div>
                                    <p><%#Eval("subject") %></p>
                                </a>
                            </div>                       
                    </div>
                        </ItemTemplate>
                    </asp:Repeater>
                           
                    </div>
                    <div class="col-md-5" >
                        <div class="work_title">
                            <div style="height: 100px;"></div>
                        </div>
                        <div class="single_image">
                            <img src="images/kitchen-77.png" alt="" class="kitchen_ma1">
                        </div>
                        <p style="text-align: right;"></p>
                    </div>

                </div>
            </div>
        </section>


             <div class="single_image">
                            <img src="images/kitchen-77.png" alt="" class="kitchen_ma2">
                        </div>

    </div>
</asp:Content>


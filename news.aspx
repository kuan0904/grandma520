<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="news.aspx.cs" Inherits="news" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <div class="oldBG">
        <section class="grey-bg mar-tm-10" id="work" style="padding-top:60px;">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div class="work_title wow fadeInUp animated cwTeXFangSong">
                            <h1>最新消息</h1>
                            <h2>news</h2>
                        </div>
                    </div>
                    <!-- 選單 -->
                        <div class="col-sm-3 col-sm-offset-1 blog-sidebar">                          
                            <div class="list-group">                                                        
                         <%=itemlist  %>
                              
                            </div>
                        </div>
                    <!-- 日期 -->
                        <div class="col-sm-8 blog-main">
                            <div class="pay">
                                <h3>活動期間：[<%=strdat  %>~<%=enddat  %>]</h3>
                            </div>
                            <h2><%=subject %></h2>
                            <!--自訂內容開始-->
                          <%=contents  %>
                        </div>
                    <!--上下-->
                    <div class="col-xs-12 col-lg-12  text-center" style="padding-top:40px;padding-bottom:40px;">
                        <a href="news?newsid=<%=lasidx  %>"><button type="button" class="btn " >上一篇</button></a> 
                            <a href="news?newsid=<%=ntxidx %>"><button type="button" class="btn ">下一篇</button></a> 
                    </div>


                    </div>              
            </div>
        </section>
    </div>

</asp:Content>


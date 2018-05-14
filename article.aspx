<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="article.aspx.cs" Inherits="article" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <script>
       $(function () {
           $('a[href*=#]:not([href=#])').click(function() {
               var target = $(this.hash);
               $('html,body').animate({
                   scrollTop: target.offset().top -50
               }, 1000);
               return false;
           });
 
       });
 

        if (window.location.hash.indexOf('#') >= 0) {
            $('html,body').animate({
                scrollTop: ($(window.location.hash).offset().top - 50) + "px"
            },
            300);
        }; //主要修复评论定位不准确BUG
        $('#comments a[href^=#][href!=#]').click(function () {
            var target = document.getElementById(this.hash.slice(1));
            if (!target) return;
            var targetOffset = $(target).offset().top - 50;
            $('html,body').animate({
                scrollTop: targetOffset
            },
            300);
            return false;
        }); //主要修复评论定位不准确BUG
    </script>
    <style >

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <div class="oldBG">
        <ol class="breadcrumb">
            <li><a href="http://www.grandma520.com/">首頁</a></li>
            <li class="active">認識滴雞精</li>       
        </ol>
                        <!--============ 外婆堅持============-->
        <section style="padding-top:40px;">
            <div class="container">
                <div class="col-md-12 text-center">
                    <div class="work_title wow fadeInUp animated cwTeXFangSong">
                        <h1>認識滴雞精</h1>
                        <h2>persistence</h2>
                    </div>
                </div>
                 <div class="col-md-12 text-center">                      
                        <div class="qa  wow fadeInUp animated cwTeXFangSong" data-wow-delay="0.5s">
                            <h3>
                            <span><a href="#what">什麼是滴雞精?</a></span>
                            <span><a href="#use">使用什麼雞</a></span>
                                  <br class="phone"/>
                            <span><a href="#who">適用對象</a></span>
                            <span><a href="#QA">Q&A</a></span>
                                <br class="phone"/>
                            <span><a href="#eat">食用方法</a></span>
                            <span><a href="#SGS">SGS檢驗報告</a></span>
                                <br class="phone"/>
                            </h3>                          
                        </div>
                    </div>
                 <div class="row case" id="what">                    
                     <div class="col-md-6 ">
                        <div style="border-top: 2px solid #cfbb99;border-bottom: 1px solid #cfbb99;">
                        <h2 class="cwTeXFangSong">什麼是滴雞精?</h2>
                        </div>
                        <p class="about_us_p">
                         外婆遵循古法智慧，將自家放養果樹下長大的黑羽土雞 ,經由8個小時文火慢工細燜，將全雞的精華都濃縮在一碗雞精中，滴滴萃煉出香純濃郁的滴雞精，因為長時間厚工的滴煉，所以特別珍貴營養。富含人體所需的小分子胺基酸，可以讓人體快速的吸收，是營養補給、調整體質的最佳選擇。
                        </p>
                    </div>
                     <div class="col-md-6" >                       
                            <div class="single_image">
                                <img src="images/about/abotu-06.jpg" alt="">
                            </div>                      
                    </div>
                </div>
                 <div class="row case text-center" style="margin-top:20px;" id="use">
                     <div class="col-md-12 ">
                        <div style="border-top: 2px solid #cfbb99;border-bottom: 1px solid #cfbb99;">
                        <h2 class="cwTeXFangSong">外婆滴雞精使用什麼雞?</h2>
                        </div>                        
                    </div>
                      <div class="col-md-12">                       
                            <div class="single_image">
                            <img src="images/PK.png" alt="" style="max-width:700px;" />
                        </div>                    
                    </div>
                </div>
                <div class="row case"  style="margin-top:20px;">
                    <div class="col-md-6 ">
                        <div style="border-top: 2px solid #cfbb99;border-bottom: 1px solid #cfbb99;">
                        <h2 class="cwTeXFangSong">純淨自然，自己的雞自己養</h2>
                        </div>
                        <p class="about_us_p">
                            滴雞精的好壞最重要的是雞隻的來源，為了確保用來滴雞精的每一隻黑羽土雞都是安全健康的，外婆堅持自己養。在寬廣的果園樹下，讓土雞們盡情的奔跑、快樂成長，飼養過程使用獨特的草本酵素、益生菌等營養素，來照顧雞隻的健康，所以全程不施打抗生素及成長激素，在如此細心的呵護照料之下慢活達120天的最佳熟齡，才送往HACCP  IS22000標準的電宰場，由獸醫進行嚴格把關，只有最健康的雞才能完成電宰，並且逐批送SGS檢驗，確保無藥物殘留。吃雞肉只是吃到一小塊，喝滴雞精，喝到的是全雞的精華，所以雞隻的來源是最重要的。
                            <br />
                            唯有如此用心、堅持，才能造就一碗安心、無毒、濃郁香純的滴雞精。
                        </p>
                    </div>
                    <div class="col-md-6">
                        <div class="col-xs-6 col-lg-6 no_padding">
                            <div class="single_image">
                                <img src="images/about/170731_0022_2.jpg" alt="">
                            </div>
                        </div>
                        <div class="col-xs-6 col-lg-6 no_padding">
                            <div class="single_image">
                                <img src="images/about/170623_0011.jpg" alt="">
                            </div>
                        </div>
                        <div class="col-xs-6 col-lg-6 no_padding">
                            <div class="single_image">
                                <img src="images/about/170623_0013.jpg" alt="">
                            </div>
                        </div>
                        <div class="col-xs-6 col-lg-6 no_padding">
                            <div class="single_image">
                                <img src="images/about/170623_0018.jpg" alt="">
                            </div>
                        </div>
                    </div>
                </div>
                 <div class="row case text-center" style="margin-top:20px;"  id="who">
                     <div class="col-md-12 ">
                        <div style="border-top: 2px solid #cfbb99;border-bottom: 1px solid #cfbb99;">
                        <h2 class="cwTeXFangSong">滴雞精適用對象</h2>
                        </div>                        
                    </div>
                      <div class="col-md-12">                       
                            <div class="single_image">
                            <img src="images/for.png" alt="" style="max-width:750px;" />
                        </div>                    
                    </div>
                </div>
                <div class="row case text-center" style="margin-top:20px;"  id="QA">
                     <div class="col-md-12 ">
                        <div style="border-top: 2px solid #cfbb99;border-bottom: 1px solid #cfbb99;">
                        <h2 class="cwTeXFangSong">滴雞精Q&A</h2>
                        </div>                        
                    </div>
                      <div class="col-md-12">                       
                            <div class="single_image">
                            <img src="images/articleQA1.png" alt="" style="max-width:750px;" />
                        </div>                    
                    </div>
                </div>
             
                 <div class="row case text-center" style="margin-top:20px;"  id="eat">
                     <div class="col-md-12 ">  
                        <div style="border-top: 2px solid #cfbb99;border-bottom: 1px solid #cfbb99;">
                        <h2 class="cwTeXFangSong">食用方法</h2>
                        </div>                        
                    </div>
                      <div class="col-md-12">                       
                            <div class="single_image">
                            <img src="images/product-info-cooking.png" alt="" style="max-width:750px;" />
                        </div>                    
                    </div>
                </div>
                <script >
    $(document).ready(function () {
        var url = "";
                    $("#sgs").click(function () {
                      
                        if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {

                    
                            url = 'https://www.facebook.com/media/set/?set=a.1591654697751073.1073741831.1422680671315144&type=1&l=7bdd515147';
                       
                        }                   else                            url = 'https://www.facebook.com/pg/grandma520520/photos/?tab=album&album_id=1591654697751073';

                     
                    $('#sgs').attr('href', url);
                   
                    });
                   
                });
                </script>
                <div class="row case" style="padding-top:80px;" id="SGS"> <!--SGS檢驗報告-->
                    <div class="col-md-6 ">
                        <div style="border-top: 2px solid #cfbb99;border-bottom: 1px solid #cfbb99;">
                            <h2 class="cwTeXFangSong">SGS檢驗報告</h2>
                        </div>
                        <p class="about_us_p">                            
                            外婆滴雞精所使用的黑羽土雞是從小雞開始飼養，<br />
                            絕不使用抗生素和成長激素，確保無藥物殘留，我們用心的把關每一個環節，<br />
                            確保你們所喝的每一口滴雞精都是安全無虞的，SGS就是最好的證明。
                        </p>
                         <div class="baton">
                        <a href="#" target="_blank" id="sgs">
                                <button type="button" class="btn btn-primary cs-btn" >了解更多</button>
                           </a> 
                        </div>
                    </div>
                    <div class="col-xs-6 col-lg-4">
                        <div class="single_image">
                            <img src="images/about/sgs.png" alt="">
                        </div>
                    </div>
                </div>   
                <div class="row" style="padding-top:30px;">
                    <!--檢驗圖-->
                    <!-- 觸發視窗內容1 -->
                    <div class="col-xs-4 col-lg-2 no_padding  btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg-1">
                        <div class="single_image">
                            <img src="images/about/p1.jpg" alt="">
                        </div>
                    </div>
                    <div class="modal fade bs-example-modal-lg-1" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="single_image">
                                    <img src="images/about/p1.jpg" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 觸發視窗內容2 -->
                    <div class="col-xs-4 col-lg-2 no_padding  btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg-2">
                        <div class="single_image">
                            <img src="images/about/p2.jpg" alt="">
                        </div>
                    </div>
                    <div class="modal fade bs-example-modal-lg-2" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="single_image">
                                    <img src="images/about/p2.jpg" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 觸發視窗內容3 -->
                    <div class="col-xs-4 col-lg-2 no_padding  btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg-3">
                        <div class="single_image">
                            <img src="images/about/p3.jpg" alt="">
                        </div>
                    </div>
                    <div class="modal fade bs-example-modal-lg-3" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="single_image">
                                    <img src="images/about/p3.jpg" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 觸發視窗內容4 -->
                    <div class="col-xs-4 col-lg-2 no_padding  btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg-4">
                        <div class="single_image">
                            <img src="images/about/p4.jpg" alt="">
                        </div>
                    </div>
                    <div class="modal fade bs-example-modal-lg-4" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="single_image">
                                    <img src="images/about/p4.jpg" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 觸發視窗內容5 -->
                    <div class="col-xs-4 col-lg-2 no_padding  btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg-5">
                        <div class="single_image">
                            <img src="images/about/p5.jpg" alt="">
                        </div>
                    </div>
                    <div class="modal fade bs-example-modal-lg-5" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="single_image">
                                    <img src="images/about/p5.jpg" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 觸發視窗內容6 -->
                    <div class="col-xs-4 col-lg-2 no_padding  btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg-7">
                        <div class="single_image">
                            <img src="images/about/p1.jpg" alt="">
                        </div>
                    </div>
                    <div class="modal fade bs-example-modal-lg-7" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="single_image">
                                    <img src="images/about/p1.jpg" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </section>
    </div>

     <!--========  磚牆圖  =========-->
    <div class="aboutBG">
        <section style="padding-top: 0px;" id="">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                            <img src="images/ZERO.png" alt="" >
                    </div>                    
                </div>
            </div>
        </section>
    </div>
</asp:Content>


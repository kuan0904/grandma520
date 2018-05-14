<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!--google map-->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?&sensor=SET_TO_TRUE_OR_FALSE"></script>
    <script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=false&language=zh-TW"></script>

    <script type="text/javascript">
        function initialize() {

            //繪製地圖
            var map = drawmap();

            // 繪製marker
            var locations = [
              ['外婆滴雞精', 25.059700, 121.481471, 1]
            ];

            var infowindow = new google.maps.InfoWindow();

            var marker, i;
            for (i = 0; i < locations.length; i++) {
                marker = new google.maps.Marker({
                    position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                    title: locations[i][0],
                    zIndex: locations[i][3],
                    map: map
                });
                google.maps.event.addListener(marker, 'click', (function (marker, i) {
                    return function () {
                        infowindow.setContent(locations[i][0]);
                        infowindow.open(map, marker);
                    }
                })(marker, i));
            }

        }
        google.maps.event.addDomListener(window, 'load', initialize);

        function drawmap() {
            //地圖參數選項
            var mapOptions = {
                center: new google.maps.LatLng(25.059700, 121.481471),//地圖的中心點
                mapTypeId: google.maps.MapTypeId.TERRAIN,
                zoom: 16, //數字越小地圖涵蓋範圍越大
                minZoom: 7,
                maxZoom: 18,   //10
                zoomControl: true,
                panControl: true,
                mapTypeControl: false,    //地形圖&衛星圖切換
                streetViewControl: false, //街景
                disableDoubleClickZoom: true, //true禁用雙擊縮放地圖
                keyboardShortcuts: true,  //用鍵盤控制地圖
                scrollwheel: true //滑鼠滾輪拉近拉遠
            };
            //繪製地圖
            var map = new google.maps.Map(document.getElementById("map_canvas"),
                mapOptions);
            return map;
        }
    </script>
    <script async="async" async="async" defer="defer" defer="defer" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB4iPHH287bjgNeLfcTts2UGTy9w5BZCt0&callback=initMap" type="text/javascript"></script>
      <script src="js/jquery.mousewheel.min.js"></script>
    <script>
        $(document).ready(function(){
            var num_li=6//偵測我們有幾個標點（圖片）

            //滾動滑鼠滾輪時，移動到上一頁、下一頁的效果
            n=1
            moving=0
            $(window).mousewheel(function(e){
                $("html,body").stop()
                if(moving==0){
                    moving=1
                    if(e.deltaY==-1){
                        if(n<num_li){
                            n++
                        }
                    }else{
                        if(n>1){
                            n--
                        }
                    }
                }
                x = 54;
                if (n==1)x=50
                $("html,body").animate({"scrollTop":$(".p0"+n).offset().top - x},function(){moving=0})
      
            })          

            if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                $('.newsBG').removeAttr('style');
                $('.aboutBG').removeAttr('style')
                $('.serviceBG').removeAttr('style')
                $('.oldBG').removeAttr('style')
                
                
                
            }
  

        })
    </script>
      <div class="p01"  >
    <div class="container">
        <div class="row">
            <div class="col-md-5 text-center">
                <div class="home_text wow zoomIn animated cwTeXFangSong">
                    <h1>真心滴釀<br />
                        幸福回甘
                                    <p>口口回甘的幸福滋味</p>
                    </h1>
                </div>
            </div>
        </div>
    </div>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
   <!--============ 最新消息============-->
     
    <div class="newsBG" style="height: 100vmin;">
        <section style="padding-top: 5px;">
            <div class="container">               
                <div class="row" style="padding-bottom: 5px;">
                    <asp:Repeater ID="Repeater2" runat="server">
                        <ItemTemplate>
                               <div class="col-md-5 work_title" style="border: 1px solid #c7a983;margin: 10px;padding: 15px;background: rgba(228, 215, 197, 0.5);">
                       <a href="news">                         
                        <h4><%#Eval("subject") %></h4>
                       </a>
                       <h6>活動期間：[<%# DateTime.Parse ( Eval("strdat").ToString()).ToString ("yyyy-MM-dd")  %>
                           ~<%# DateTime.Parse ( Eval("enddat").ToString()).ToString ("yyyy-MM-dd")  %>]</h6>
                      <%#htmlreplace ( Eval("contents").ToString())%>
                       <div class="baton">
                         <a href="news.aspx?newsid=<%#Eval("newsid") %>">
                             <button type="button" class="btn btn-primary cs-btn" >了解更多</button>
                           </a>
                       </div>
                    </div>
                        </ItemTemplate>
                    </asp:Repeater>                                         
                </div>
            </div>
        </section>
    </div>
    </div> 
     <!--============ 一、關於外婆============-->
      <div class="p02">
    <div class="aboutBG"  style="height: 100vmin;">
        <section style="">
            <div class="container" style="padding-bottom: 65px;">
                <div class="row case">
                    <div class="col-xs-12 col-lg-6" style="padding-top: 75px;">
                        <div style="padding: 32px; border: 1px solid #ccc; background: rgba(255, 255, 255, 0.83);">
                            <div class="work_title cwTeXFangSong">
                                <h1>遇見外婆</h1>
                                <h2>about</h2>
                            </div>
                            <p class="about_us_p">
                                從小生活在南部的外婆，飲食簡單，只吃原形食物少吃加工食品，台北的孫女愛吃雞腿，外婆擔心市場雞使用藥物飼養，開始自己少量飼養黑羽土雞，堅持只餵食五穀雜糧並添加草本酵素照顧土雞的健康，她說只有自己養的雞才能放心的大口吃。
                            </p>
                            <h2 class="cwTeXFangSong">外婆滴雞精來自「家人的用心關懷」</h2>
                            <div class="baton">
                                <a href="about">
                                    <button type="button" class="btn btn-primary cs-btn">了解更多</button>
                                </a>
                            </div>
                        </div>
                    </div>
                    <style>
                        .singleimage{
	                        position: relative;
	                        transition: all 1s;
                        }
                      @media (min-width: 992px){
                            .singleimage img {
                                width: 800px;
                            }
                        }
                        @media (max-width: 991px) {
                            .singleimage img {
                                width: 100%;
                            }
                        }
                    </style>
                    <div class="col-xs-12 col-lg-6" style="padding-top: 140px;">
                        <div class="single_image">
                            <img src="images/grandmother_c.png" alt="">
                        </div>
                    </div>

                </div>
                </div> 
        </section>
    </div>
          </div> 
    <!--============ 二、============-->
      <div class="p03">
    <section class="serviceBG" style="height: 100vmin;">
        <div class="container" style="padding-bottom: 65px;">
            <div class="row case">
                <div class="col-xs-4 col-lg-5">
                </div>
                <div class="col-xs-12 col-lg-6" style="padding-top: 75px;">
                    <div style="padding: 32px; border: 1px solid #ccc; background: rgba(255, 255, 255, 0.83);">
                        <div class="work_title cwTeXFangSong">
                            <h1>認識滴雞精</h1>
                            <h2>Creativity</h2>
                        </div>
                        <p class="about_us_p">
                            外婆遵循古法智慧，將自家放養果樹下長大的黑羽土雞，經由8個小時文火慢工細燜，將全雞的精華都濃縮在一碗雞精中，滴滴萃煉出香純濃郁的滴雞精，因為長時間厚工的滴煉，所以特別珍貴營養。
                        </p>
                        <h2 class="cwTeXFangSong">甘醇，每一滴都不放過的好味道</h2>
                        <div class="baton">
                            <a href="article">
                                <button type="button" class="btn btn-primary cs-btn">認識滴雞精</button>
                            </a>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </section>
          </div> 
    <!--============ 三、精選商品============-->
      <div class="p04">
    <div class="oldBG"  style="height: 100vmin;">
        <section style="padding-top: 10px;">
            <div class="container">
                <div class="col-md-12 text-center">
                    <div class="work_title wow fadeInUp animated cwTeXFangSong">
                        <h1>精選商品</h1>
                        <h2>shop</h2>
                    </div>
                </div>
                <div class="row" style="padding-bottom: 20px;">
                    <div class="col-md-4 text-center work_title" style="padding-bottom: 20px;">
                       <a href="/product">
                         <img src="images/0002551.jpg" alt="" class="img-circle">
                        <h4>享‧雞精</h4>
                        <p class="">堅持天然健康營養，無添加水分，一天一碗可有效調整體質。</p>                        
                        </a>
                    </div>
                    <div class="col-md-4 text-center  work_title" style="padding-bottom: 20px;">
                         <a href="/product-info?p_id=3">
                        <img src="images/0002552_S.jpg" alt="" class="img-circle">
                        <h4>送‧好禮</h4>
                        <p class="">帶給自己和朋友一份溫暖、營養的補身極品。</p>
                        </a>
                    </div>
                    <div class="col-md-4 text-center  work_title" style="padding-bottom: 20px;">
                         <a href="/product">
                         <img src="images/0002553.jpg" alt="" class="img-circle">
                        <h4>品‧鮮肉</h4>
                        <p class="">不施打抗生素及成長激素，慢活達120天的最佳熟齡，才送往HACCP IS20001標準的電宰場</p>
                        </a>
                    </div>
                    <div class="col-md-12 text-center">
                        <a href="/product"">
                            <button type="button" class="btn btn-default submit-btn form_submit">更多商品</button>
                        </a>
                    </div>
                </div>
            </div>
        </section>
    </div>
          </div> 
      <div class="p05">
    <div class="oldBG"  style="height: 100vmin;">
        <section style="padding-top: 40px;">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div class="work_title  wow fadeInUp animated cwTeXFangSong">
                            <h1>外婆上菜</h1>
                            <h2>recipes</h2>
                        </div>
                    </div>
                    <!--1排-->

                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                                 <div class="col-xs-6 col-md-4">
                                        <div class="wow fadeInUp" data-wow-delay="0.5s">
                                            <div class="thumbnail">
                                                <div class="single_image">
                                                    <a href="kitchen-info?d_id=<%#Eval ("d_id") %>">
                                                        <img src="upload/<%#Eval("pic") %>" alt="">
                                                        <div class="image_overlay">
                                                            <h2><%#Eval("subject") %></h2>
                                                            <h4><%#Eval("subtitle") %></h4>
                                                        </div>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                        </ItemTemplate>
                    </asp:Repeater>     
           
       

                    <div class="col-md-12 text-center">
                        <a href="kitchen">
                            <button type="button" class="btn btn-default submit-btn form_submit">更多食譜</button>
                        </a>
                    </div>
                </div>
            </div>
        </section>
    </div>
           </div> 
    <!--========  地圖  =========-->
      <div class="p06" >
    <section >
        <div class="">
            <div class="col-md-12 no_padding">
                <!--google地圖 開始-->
                <div style="position: relative;">
                    <div class="entry-content">
                        <div id="map_canvas" style="height: 400px"></div>
                    </div>
                </div>
                <!--google地圖 結束-->
            </div>
        </div>
    </section>
          </div> 
</asp:Content>


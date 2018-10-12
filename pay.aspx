<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="pay.aspx.cs" Inherits="pay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
       input[type=radio   ]{
            width:20px;
            height :20px;
        }
    </style>

    <script>
        var countyid = "<%=countyid %>";
        var zip = "<%=zip%>";
        var cityid = "<%=cityid%>";     
        var shipprice = 0;
        var storage = 10;
        var memberid = '<%=memberid%>';
        var promo = "";
        var ship_condition =<%=ship_condition%>;
        function num_change(obj, p_id) {
            num = obj.value;
            goodsAdd(p_id, num, 'update');
            recalculate();
        }
        function num_del(p_id) {
            num = 0;
            goodsAdd(p_id, num, 'update');
            location.href = 'pay';
        }
        function recalculate() {        
            var amount = 0;
            var tnum = 0;         
            var subtotal = 0;
            amount = 0;
            $('#discount_no').attr('disabled', false);
            $(".sel_ProNum").each(function (index) {
                var obj = $(this);
                var num = $(this).find('select[name="p_num"]').val();
                //var p_id = $(this).find('#p_id').html();  
                num = parseInt(num);
                tnum += num;
                var price = $(this).find('#price').html();
                amount += num * price;
                if ( $(this).find('#promo').val() == '1') promo ="1";
            });
            var countyid = $('#countyid').val();
            shipprice = 150;
            if (countyid > 22) shipprice = 260;                          
            if (amount >= ship_condition) shipprice = 0;     

            if (promo == "1") shipprice = 0;
            if ($('input[name="paymode"]:checked').val() == '4') {
                shipprice += 60;
            }
     
            if ($('#self').prop('checked')) {
                shipprice = 0;
            }
          
            if ($('input[name="paymode"]:checked').val() == '5') {
                shipprice = 0;
                $('#discount_no').attr('disabled', true);
                if ($('#discount_no').val() != '') {
                    alert('自取無折扣優惠');                   
                    $('#discount_no').val('');
                    $('#discount_price').html('0');
                   
                }



            }
            $('#subtotal').html(amount);
            amount = amount - $("#discount_price").html();    
           
            $('#amount').html(amount);         
            $('#shipprice').html(shipprice);
            $('#totalprice').html(amount + shipprice);
        }

        $(document).ready(function () {            
                $("#self").click(function () {   
                    selfclick();
                })
               $("#email").blur(function () {          
                   $.post('Handler.ashx', { "email": $("#email").val(), "_": new Date().getTime() }, function (data) {
                       if (data == "Y") {
                           alert('此Email已是會員,請登入後再結帳!');
                           $("#email").val('');
                       }
                });
            });

            var buynum = 0;
            $(".sel_ProNum").each(function (index) {
                buynum += 1;
            });
            if (buynum == 0) {
                alert('購物車無商品,請重新選購!');
                location.href = '/product';
            }
            getCounty();
            getCity(countyid, '#cityid');
            $("input[name='paymode']").change(function () {
                $('#address').prop('readonly', false);
                $('#countyid').prop('disabled', false);
                $('#cityid').prop('disabled', false);
                selfclick();
                //if ($('input[name=paymode]:checked').val() == '5' || $('#self').prop('checked')) {
                //    selfclick();
                    
                //}              
              
            });
            $("#countyid").change(function () {          
                if ($(this).val() != "") {                  
                    getCity($(this).val(), '#cityid');
                    if (cityid != "") {
                        $("#cityid").find("option[value='" + cityid + '-' + zip + "']").prop("selected", true);
                        $("#cityid").trigger("change");
                    }
                } else {
                    $("#cityid").find("option").remove();
                }
            });
           
            $("#cityid").change(function () {
                if (($(this).val() != "") && ($(this).val() != null)) {
                    zip = $(this).val().split('-')[1];
                    $("#zip").val(zip);
                } else {
                    $("#zip").val('');
                }
            });
           
            recalculate();

            $("#discount_no").on("change paste keyup", function () {
                get_discount($(this).val());
            });
        });
        
        function get_discount(obj) {
        
            $("#discount_price").html('0');
            if (obj != "") {
                var price = $("#subtotal").html();
                $.post('member_handle.ashx', { "p_ACTION": "get_discount", "discount_no": obj, "price": price, "_": new Date().getTime() }, function (data) {
          
                    if (data != "0") {
                        if (data == "-1") {
                            alert('此代碼失效!');
                            $("#discount_no").val('');
                        }
                        if (data == "-3") {
                            alert('未達使用金額!');
                            $("#discount_no").val('');
                        }
                        else if (data == "-2") {
                            alert('你已使用過!');
                            $("#discount_no").val('');
                        }
                        else {
                          
                            if ( parseFloat( data) < 1) {
                                data = price -(price * data);                            
                                data = parseInt(data);
                            }
                        
                            $("#discount_price").html(data);

                            //recalculate();
                        }

                    }

                
                    $("#totalprice").html(price - data);
                });
            }

        }

        function same() {
            if ($("#thesame").prop("checked")) {
                var x1 = $("#username").val();
                var x2 = $("#phone").val();
                var x7 = $("#mobile").val();                
                $("#Rusername").val(x1);
    
                $("#Rmobile").val(x7);
                $("#zip").val(zip);
                $("#Remail").val($("#email").val());
            } else {
                $("#zip").val("");
  
                $("#Rusername").val("");
                $("#address").val("");
            }
        }
        function selfclick() {
            $('#address').prop('readonly', false);
            $('#countyid').prop('disabled', false);
            $('#cityid').prop('disabled', false);      
            if ($('#self').prop('checked')) {
                $('#address').prop('readonly', true);
                $('#countyid').prop('disabled', true);
                $('#cityid').prop('disabled', true);
                 
                countyid = 2;
                zip = "241";
                cityid = "43";     
                getCity(countyid, '#cityid');
                $("#countyid").val('2');
                $("#address").val('新北市三重區名源街61巷5號合豐生機有限公司');
            }
            recalculate();
        }

        function getCity(p_COUNTYID, obj) {
            if (p_COUNTYID != null) {
                $.post('city.ashx', { "p_COUNTYID": p_COUNTYID, "_": new Date().getTime() }, function (data) {
                    if (data != "") {
                        $(obj).find("option").remove();
                        $(obj).html(data);
                        $('#cityid').find('option[value="' + cityid + "-" + zip + '"]').prop("selected", true);
                    }
                });
            }
        }

        function getCounty() {
            $.post('county.ashx', { "_": new Date().getTime() }, function (data) {
                if (data != "") {                 
                    $("#countyid").find("option").remove();
                    $("#countyid").html(data);
                    $('#countyid').find('option[value="' + countyid + '"]').prop("selected", true);
                }
            });
        }



        function checkdata() {
            $("#email").val($("#email").val().toLowerCase());
            $("#Remail").val($("#Remail").val().toLowerCase());
            var username = $("#username").val();
            var email = $("#email").val();

            var mobile = $("#mobile").val();         
            var phone = $("#phone").val();          
            var Remail = $("#Remail").val();
            var Rusername = $("#Rusername").val();
            var Rmobile = $("#Rmobile").val();
            var countyid = $("#countyid").val();
            var cityid = $("#cityid").val();
            var zip = $("#zip").val();
            var address = $("#address").val();
    
            var password = $("#password").val();
            var passconfirm = $("#passconfirm").val();
            var paymode = $('input[name=paymode]:checked').val();
            var invoice = $("#invoice2").prop("checked") ? "2" : "3";
            var companyno = $("#companyno").val();
            var receivetime = $("#receivetime").val();
            var contents = $('#contents').val();
            var discount_no = $('#discount_no').val();
            var title = $("#title").val();
            var birthday = $("#birthday").val();
            var atmcode = $("#atmcode").val();
            $('#address').prop('readonly', false);
            $('#countyid').prop('disabled', false);
            $('#cityid').prop('disabled', false);
            if (cityid != "" && cityid != null) {
                zip = cityid.split('-')[1];
                cityid = cityid.split('-')[0];
            }

            if (email == "") {
                alert("請輸入Email");
                $("#email").focus();
                return false;
            }
            else if (!validEmail(email)) {
                alert("EMail格式錯誤");
                $("#email").focus();
                return false;
            }
            if (Remail == "") {
                alert("請輸入訂單明細收件信箱");
                $("#Remail").focus();
                return false;
            }
            else if (!validEmail(Remail)) {
                alert("EMail格式錯誤");
                $("#Remail").focus();
                return false;
            }
            
            else if (password == "" && memberid =="") {
                alert("請輸入密碼");
                $("#password").focus();
            } else if ( memberid =="" && (password.length < 6 || password.length > 16)) {
                alert("請輸入英數6-16字元");
                $("#password").focus();
            }
            else if ((password != passconfirm) &&  memberid =="")  {
                alert("密碼與確認密碼不同");
                $("#passconfirm").focus();
            }
            else if (birthday == "") {
                alert("請輸入生日");
                $("#birthday").focus();
            }
            else if (username == "") {
                alert("請輸入姓名");
                $("#username").focus();
                return false;

            } else if (phone == "") {
                alert("請輸入行動電話");
                $("#phone").focus();
                return false;
            }
            else if (Rusername == "") {
                alert("請輸入收件姓名");
                $("#Rusername").focus();
                return false;
            }
            else if (Rmobile == "") {
                alert("請輸入收件人行動電話");
                $("#Rmobile").focus();
                return false;
            } else if ((cityid == "") || (countyid == "") || (address == "")) {
                alert("請輸入收件人地址");
                $("#address").focus();
                return false;
            }
            else if (paymode == undefined) {
                alert("請選擇付款方式");
                $("#paymode").focus();
                return false;
            }
            else if (paymode == "2" && atmcode == "") {
                alert("請輸入帳號末五碼");
                $("#atmcode").focus();
                return false;
            }
            else if ($("#invoice2").prop("checked") == false && $("#invoice3").prop("checked") == false) {
                alert('請選擇發票方式');
                $("#invoice2").focus();
                return false;
            }
            else if ($("#invoice3").prop("checked") == true && (title == '' || companyno == '')) {
                alert('請填統編及公司抬頭');
                $("#invoice3").focus();
                return false;
            }
            else {
                var p_id = "";
                var num = "";
                $(".sel_ProNum").each(function (index) {
                    var obj = $(this);
                    num += $(this).find('select[name="p_num"]').val() + ";";
                    p_id += $(this).find('#p_id').html() + ";";
                });
                if (confirm("送出訂單資料中,請勿重覆按下送出")) {
                    $("#send").prop('disabled', true);
                    $.post('add_order.ashx', {
                        "p_ACTION": "add",
                        "email": email,
                        "password": password,
                        "username": username,
                        "phone": phone,
                        "mobile": mobile,
                        "Rusername": Rusername,
                        "countyid": countyid,
                        "cityid": cityid,
                        "zip": zip,
                        "address": address,
                        "self": $('#self').prop('checked')==true?"Y":"",
                        "Rmobile": Rmobile,
                        "Remail": Remail,
                        "invoice": invoice,
                        "companyno": companyno,
                        "title": title,
                        "paymode": paymode,
                        "receivetime": receivetime,
                        "contents": contents,
                        "p_id": p_id,
                        "num": num,
                        "discount_no": discount_no,
                        "birthday": birthday,
                        "atmcode": atmcode,
                        "promo":promo,
                        "_": new Date().getTime()
                    }, function (data) {

                        if (data == "1") {
                            if (paymode == "1") {
                                location.href = 'cardpay.ashx';
                            }
                            else {
                                location.href = 'pay-step02.aspx';
                            }
                        }
                        else if (data == "-1") {
                            alert('此帳號已經存在');
                            $("#send").prop('disabled', false);
                        }
                        else {
                            alert('資料有誤')
                            location.href = 'pro-list.aspx';
                        }
                    });
                }
                return false;

            }

        }
    </script>
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
                    <div class="col-xs-6 col-lg-6 text-center">
                        <h1>
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span><strong>Step01 </strong>
                        </h1>
                        <h3>填寫訂單資訊
                        </h3>
                    </div>
                    <div class="col-xs-6 col-lg-6 text-center" style="color: #bdbab5;">
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
                                        <th>單價</th>
                                        <th>數量</th>
                                        <th>刪除</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="Repeater1" runat="server">
                                        <ItemTemplate>
                                            <tr class="sel_ProNum">
                                                <td><%# Eval("productname ")%><span id="p_id"  style="display:none"><%#Eval("p_id") %></span></td>
                                                <td>
                                                    <%# Eval("memos") %>
                                                </td>
                                                <td>NTD$<span id="price"><%#Eval("price") %></span>
                                                </td>
                                                <td>
                                                    <span>
                                                        <select id="p_num" name="p_num" class="buynum" onchange="num_change(this,'<%#Eval("p_id") %>')">
                                                            <%# get_storage(Eval("p_id").ToString(),(int) Eval("num"))%>;
                                                        </select>
                                                    </span>
                                                </td>
                                                <td><input type="hidden" id="promo" value ="<%#Eval("promo") %>" />
                                                    <asp:LinkButton ID="LinkButton1" runat="server"><span class="glyphicon glyphicon-remove" aria-hidden="true" onclick ="num_del('<%#Eval("p_id") %>');"></span></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>


                                    <tr class="warning">
                                        <td>小計</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <strong>NT$<span id="amount">0</span> </strong>
                                        </td>
                                    </tr>
                                </tbody>

                            </table>
                        </div>
                    </div>
                    <!----------訂購人資料----------->
                    <div class="col-xs-12 col-lg-6 pay">
                        <h3>訂購人資料</h3>
                        <br />
                        <asp:MultiView ID="MultiView1" runat="server">
                            <asp:View ID="View1" runat="server">
                                          <div class="form-group">
                            <label for="exampleInputPassword1">※電子信箱 </label>
                            <p>訂單成立後，電子郵件即為您的會員帳號</p>
                            <input name="email" type="text" class="form-control" id="email" placeholder="輸入電子信箱 " />

                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">※設定密碼</label><p>日後登入網站會員的密碼</p>
                            <input name="password" type="password" id="password" placeholder="密碼" class="form-control" />
                            <p>(英數字元，需6字以上)</p>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">※確認密碼</label>
                            <input name="passconfirm" type="password" id="passconfirm" placeholder="再次輸入密碼" class="form-control" />
                        </div>
                  <div class="form-group">
                            <label for="exampleInputPassword1">※生日 </label>
                           
                            
                      <input name="birthday" type="text" id="birthday" value="" class="form-control" placeholder="yyyy/mm/dd" onkeyup="
        var v = this.value;
        if (v.match(/^\d{4}$/) !== null) {
            this.value = v + '/';
        } else if (v.match(/^\d{4}\/\d{2}$/) !== null) {
            this.value = v + '/';
        }" maxlength="10">
                        </div>

                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                  <input name="email" type="text" class="form-control" id="email" value="<%=email  %>" />

                            </asp:View>
                        </asp:MultiView>
              
                        <div class="form-group">
                            <label for="exampleInputEmail1">※訂購人姓名</label>
                            <input type="text" class="form-control" id="username" placeholder="輸入姓名" value="<%=username  %>" />
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">※行動電話</label>
                            <input name="mobile" type="text" id="mobile" placeholder="輸入行動電話" class="form-control" value="<%=mobile  %>" />

                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">連絡電話</label>
                            <input name="phone" type="text" id="phone" placeholder="輸入聯絡電話" class="form-control" value="<%=phone  %>" />
                        </div>


                    </div>
                    <!----------收件人資料----------->
                    <div class="col-xs-12 col-lg-6 pay">
                        <h3>收件人資料</h3>
                        <input name="thesame" id="thesame" type="checkbox" value="" class="checkbox-login" onclick="same();"><a>同訂購人資料</a>
                        <br>
                        <br />

                        <div class="form-group">
                            <label for="exampleInputEmail1">※收件人姓名</label>
                            <input name="Rusername" type="text" id="Rusername" placeholder="輸入姓名" class="form-control" />

                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">※行動電話</label>
                            <input name="Rmobile" type="text" id="Rmobile" class="form-control" placeholder="輸入行動電話" />

                        </div>
         
                        <div class="form-group">
                            <label for="exampleInputPassword1">※電子信箱 </label>
                            <p>訂單明細收件信箱</p>
                            <input type="text" name="Remail" id="Remail" class="form-control"  placeholder="輸入電子信箱 " value="<%=email %>" />
                        </div>
       
                        <div class="form-group">
                            <label for="exampleInputPassword1">※收件地址</label>
                            <div>
                                <input id="self" type="checkbox"  style ="width:20px; height :20px"/>(三重自取)
                                <input name="zip" type="number" id="zip" placeholder="" class="input-postal"  value ="<%=zip%>" hidden="hidden" />
                                <select class="select-city" name="countyid" id="countyid">
                                </select>
                                <select class="select-city" id="cityid" name="cityid">
                                    <option>鄉鎮市區</option>
                                </select>
                            </div>
                            <input name="address" type="text" id="address" placeholder="地址" class="form-control" value ="<%=address%>" />

                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">配達時段</label>
                            <span>
                                <select name="receivetime" id="receivetime">
                                    <option value="1" selected="">不指定</option>
                                    <option value="2"> 13時前</option>
                                    <option value="3">14-18</option>
                                
                                </select>
                            </span>
                        
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">備註</label>
                            <input type="text" class="form-control" id="contents" name="contents" placeholder="如有備註請填寫" />
                        </div>


                    </div>

                    <!--選擇發票-->
                    <div class="col-xs-6 col-lg-6 pay">
                        <h3>統一發票</h3>
                        <label>
                            <input type="radio" name="invoice" id="invoice2" value="2" checked >二聯式紙本發票</label>
                        <label>
                            <input type="radio" name="invoice" id="invoice3" value="3">三聯式紙本發票</label>
                        <div class="form-group">
                            <label for="exampleInputEmail1">抬頭</label><input name="title" type="text" id="title" placeholder="輸入抬頭(三聯式發票填寫)" class="form-control" />

                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">統一編號</label><input name="companyno" type="text" id="companyno" placeholder="輸入統一編號(三聯式發票填寫)" class="form-control" />

                        </div>
                    </div>
                    <!--付款方式-->
                    <div class="col-xs-6 col-lg-6 pay">
                        <h3>付款與配送</h3>
                        <h4>
                            <strong>【送貨方式】</strong> 黑貓冷凍宅配到府<br />
                            <strong>【帳號】 </strong>郵局700：2441115 0500210 許如雲<br />
                            <br />
                            注意：外婆滴雞精堅持手工新鮮現做，不添加防腐劑，宅配前必須預冷，以確保雞精新鮮，所以當大家收到時都是新鮮現滴的喔！
                        </h4>
                    </div>
                </div>
                <div class="row">
                    <!----------訂單總計------------->
                    <div class="col-xs-12 col-lg-12 ">
                        <div class="panel panel-default">
                            <div class="panel-heading">訂單總計</div>
                            <!-- Table -->
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <td>購物總計</td>
                                        <td>NT$:<span id="subtotal">0</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>輸入折扣碼</td>
                                        <td><input id="discount_no" type="text" /></td>
                                      
                                    </tr>
                                    <tr>
                                        <td>折扣優惠</td>
                                        <td>
                                            NT$:-<span id="discount_price">0</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>付款方式與運費<br />
                                            <span style="color: #ca0000;">※黑貓冷凍運費説明：單筆購物滿<%=ship_condition %>元(含)以上免運。<br>
                                                未滿<%=ship_condition %>元，本島150元，外島260元。</span><br />
                                             <label>
                                                <input type="radio" name="paymode" value="1" id="card"   >信用卡</label><br />
                                            <label>
                                                <input type="radio" name="paymode" value="2">銀行匯款</label>銀行帳號未5碼<input name="atmcode" id="atmcode" type="text" size ="5" maxlength ="5" /><br />
                                            <label>
                                                <input type="radio" name="paymode" value="3">無摺存款</label><br />
                                            <label>
                                                <input type="radio" name="paymode" value="4">貨到付款(外加60元手續費)</label><br />
                                            <label>
                                                <input type="radio" name="paymode" value="5">現金(限自取)<br>地址：新北市三重區名源街61巷5號</label>
                                        </td>
                                        <td>NT$:<span id="shipprice">0</span>
                                        </td>
                                    </tr>
                                    <tr class="warning">
                                        <td>訂單總額</td>
                                        <td>
                                            <strong>NT$<span id="totalprice">0</span></strong>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!--送出-->
                    <div class="col-xs-12 col-lg-12  text-center" style="padding-top: 40px; padding-bottom: 40px;">
                        <h4 style="color: #d75900;">送出訂單後，系統將自動發送以上明細與資訊至電子信箱
                        </h4>
                        <button type="button" class="btn btn-warning btn-lg" onclick="checkdata();" id="send">確認送出訂單</button>
                        <button type="button" class="btn btn-default btn-lg">重新填寫</button>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>


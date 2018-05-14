<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="member.aspx.cs" Inherits="member"  EnableEventValidation="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
         <script>
        var countyid = "<%=countyid %>";
        var zip = "<%=zip%>";
        var cityid = "<%=cityid%>";
    
        $(document).ready(function () {        
            getCounty();
            getCity(countyid);
            $("#btnUpdate").click(function () {
                var username = $("#username").val();                        
                countyid = $("#countyid").val();
                var phone = $("#phone").val();
                var mobile = $("#mobile").val();
                cityid = $("#cityid").val();
                var password = $("#password").val();
                var passconfirm = $("#passconfirm").val();
                var address = $("#address").val();
                var birthday = $("#birthday").val();
              
                if (cityid != "" && cityid != null) {
                    zip = cityid.split('-')[1];
                    cityid = cityid.split('-')[0];
                }                       
               if (username == "") {
                    alert("請輸入姓名");
                    $("#username").focus();
                } else if (password == "") {
                    alert("請輸入密碼");
                    $("#password").focus();
                } else if (password.length < 6 || password.length > 16) {
                    alert("請輸入英數6-16字元");
                    $("#password").focus();
                }
                else if (password != passconfirm) {
                    alert("密碼與確認密碼不同");
                    $("#passconfirm").focus();              
                } else if (phone == "") {
                    alert("請輸入行動電話");
                    $("#phone").focus();
                } else if (birthday == "") {
                    alert("請輸入生日");
                    $("#birthday").focus();
                } else if ((cityid == "") || (countyid == "") || (address == "")) {
                    alert("請輸入地址");
                    $("#address").focus();
                } else {
                
                    $.post('member_handle.ashx', {
                        "p_ACTION": "Update",
                        "username": username,
                        "mobile": mobile,                 
                        "phone": phone,
                        "cityid": cityid,
                        "countyid": countyid,
                        "zip": zip,
                        "address": address,
                        "password": password,
                        "birthday": birthday,
                        "_": new Date().getTime()
                    }, function (data) {
                        if (data == "0") {
                            alert("error");
                        } else if (data == "1") {
                            alert("您的資料已經完成修改，感謝您的使用!");
                            var page = GetURLParameter("page");
                            if (page !== undefined) {
                                var s = base64_decode(page);
                                if (s.indexOf('?') != -1) s += "&=_" + new Date().getTime().toString();
                                else s = page + "?=_" + new Date().getTime().toString();
                                location.href = s;
                            }
                            else
                                location.href = 'index.aspx';
                        }

                    }
                    );
                }
            });
            $("#countyid").change(function () {             
                if ($(this).val() != "") {
                    getCity($(this).val());
                    if (cityid != "") {
                        $("#cityid").find("option[value='" + cityid  + '-' + zip + "']").prop("selected", true);
                        $("#cityid").trigger("change");
                    }
                } else {
                    $("#cityid").find("option").remove();
                }
             
            });
            $("#cityid").change(function () {
                if (($(this).val() != "") && ($(this).val() != null)) {
                    var zip = $(this).val().split('-')[1];
                    $("#zip").val(zip);
                } else {
                    $("#zip").val('');
                }
            });             
        });

      

        function getCity(p_COUNTYID) {     
            if (p_COUNTYID != null) {
                $.post('city.ashx', { "p_COUNTYID": p_COUNTYID, "_": new Date().getTime() }, function (data) {
                    if (data != "") {
                        $("#cityid").find("option").remove();
                        $("#cityid").html(data);
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

 
        function init() {
          
                $('#countyid').find('option[value="' + countyid + '"]').prop("selected", true);
                $('#cityid').find('option[value="' + cityid + "-" + zip + '"]').prop("selected", true);
                $("#username").val('');
                $("#countyid").val('');
                $("#phone").val('');
                $("#mobile").val('');
                $("#zip").val('');
                $("#birthday").val('');
                $("#password").val('');
                $("#passconfirm").val('');
                $("#address").val('');
        
        }
    </script>

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
                                <a href="order" class="list-group-item">訂單查詢</a>
                                <a href="member" class="list-group-item active">會員個資修改</a>             
                                <asp:LinkButton ID="logout" runat="server" OnClick ="logout_Click"   class="list-group-item">登出</asp:LinkButton>   
                            </div>
                        </div>
                    <!-- 資訊區(會員個資修改) -->
                        <div class="col-sm-8 blog-main">
                            <div class="pay">
                                <h3>會員個資修改</h3>
                            </div>
                            <form role="form">
                                <div class="form-group">
                                    <label for="">電子信箱</label>
                                    <br />  
                                    <label for=""> <%=email  %>  </label>
                                </div>                        
                                <div class="form-group">
                                    <label for="exampleInputEmail1">姓名</label>   
                                     <input name="username" type="text" id="username"  class="form-control"  placeholder="輸入姓名" value ="<%=username%>"/>
                                 
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">行動電話</label>                               
                                        <input name="mobile type="text" id="mobile" placeholder="輸入行動電話"  value ="<%=mobile %>"  class="form-control" />
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">連絡電話</label>
                                      <input name="phone" type="text" id="phone" placeholder="輸入連絡電話"  value ="<%=phone %>"  class="form-control" />
                             
                                </div>    
                                      <div class="form-group">
                                    <label for="exampleInputPassword1">生日</label>
                                      <input name="birthday" type="date"  id="birthday" placeholder="生日"  value ="<%=birthday %>"  class="form-control" />
                             
                                </div>                         
                                <div class="form-group">
                                    <label for="exampleInputPassword1">收件地址</label>
                                    <div>
                                           <input name="zip" type="text" id="zip" placeholder="zip"  size="6" readonly   value ="<%=zip %>"/>
                    <select class="select-city" name="countyid" id="countyid">
                    
					</select>
                    <select class="select-city" id="cityid" name="cityid" >  
                    <option>鄉鎮市區</option>                 
					</select>

                                        
                                    </div>
                                    <input type="" class="form-control" id="address" placeholder="地址" value ="<%=address %>" />
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">修改密碼</label>
                                       <input name="password" type="password" id="password"  class="form-control" placeholder="密碼"   value ="<%=password%>" />                                              
                                    <p>(英數字元，需6字以上)</p>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">確認密碼</label>
                                         <input name="passconfirm" type="password" id="passconfirm" class="form-control" placeholder="再次輸入密碼"   value ="<%=password%>" />               
                                </div> 
                            </form>

                        </div>
                    <!--送出-->
                    <div class="col-xs-12 col-lg-12  text-center" style="padding-top:40px;padding-bottom:40px;">
                        <button type="button" class="btn btn-warning btn-lg"  id="btnUpdate">確認修改</button>
                        <button type="button" class="btn btn-default btn-lg" onclick ="init();">重新填寫</button>
                    </div>


                    </div>              
            </div>
        </section>
    </div>
</asp:Content>


<%--
  Created by IntelliJ IDEA.
  User: arbitrary
  Date: 2017/9/10
  Time: 上午12:19
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" isELIgnored="false" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
    //el表达式
    String names="";
    String pwd="";
%>

<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <meta name="Robots" content="index,follow" />
    <title>第三波书店-最方便的网上书店</title>
    <link rel="stylesheet" href="/resources/static/css/bootstrap/dist/css/bootstrap.css">
    <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
    <script src="/resources/static/js/frontjs/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="/resources/static/js/frontjs/layer/layer.js" type="text/javascript"></script>


        <meta name="viewport" content="width=device-width" />
        <title>第三波书店-管理后台</title>
        <link href="/resources/bookstore/Content/themes/base/jquery-ui.css" rel="stylesheet" />
        <link href="/resources/bookstore/Content/themes/base/jquery.ui.datepicker.css" rel="stylesheet" />
        <link href="/resources/bookstore/Areas/Admin/Css/Login.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="action_area" class="login">
    <div class="login_t">
    </div>
    <div class="login_m">
    </div>
    <div class="login_b">
    <form id="_form" action="" method="post">
        <p>
            <label>用户名</label>
            <input style="width: 250px;" type="text" name="account" class="username" value = "${userName}"placeholder="请输入用户名...">
        </p>
        <p>
            <label>密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
            <input style="width: 250px;" type="password" name="password" class="password" value = "${password}" placeholder="请输入密码...">
        </p>
        <p class="form_usb">
            <button type="button" id="login">登录</button>
            <a href="#">重置</a>
        </p>
        <div style="display:none"class="error"><span>+</span></div>
    </form>
</div>
</div>
<!--href设置为此，为绝对的空连接，点击不返回任何数值，此例中如此设置来制作平滑上滚-->
<script type="text/javascript"></script>
<script  src="/js/common/jquery/jquery1.8.3.min.js"></script>
<!--<script  src="/js/common/supersized.3.2.7.min.js"></script>-->
<!--<script  src="/js/common/supersized-init.js"></script>-->
<script src="/js/user.login.js"></script>

<script >
    jQuery(document).ready(function() {
        try{
            var _href = window.location.href+"";
            if(_href && _href.indexOf('?kickout')!=-1){
                layer.msg('您已经被踢出，请重新登录！');
            }
        }catch(e){

        }
        //回车事件绑定
        document.onkeydown=function(event){
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if(e && e.keyCode==13){
                $('#login').click();
            }
        };

        //登录操作
        $('#login').click(function(){

            var username = $('.username').val();
            var password = $('.password').val();
            if(username == '') {
                $('.error').fadeOut('fast', function(){
                    $('.error').css('top', '27px').show();
                });
                $('.error').fadeIn('fast', function(){
                    $('.username').focus();
                });
                return false;
            }
            if(password == '') {
                $('.error').fadeOut('fast', function(){
                    $('.error').css('top', '96px').show();
                });
                $(this).find('.error').fadeIn('fast', function(){
                    $('.password').focus();
                });
                return false;
            }
            var data = {loginid:username,loginpwd:password, rememberMe:$("#rememberMe").is(':checked')};
            var load = layer.load();

            $.ajax({
                url:"${basePath}/u/adminLogin",
                data: data,
                type:"post",
                dataType:"json",
                beforeSend:function(){
                    layer.msg('开始登录，请注意后台控制台。');
                },
                success:function(result){
                    layer.close(load);
                    if(result && result.status != 200){
                        layer.msg(result.message,function(){});
                        $('.password').val('');
                        return;
                    }else{
                        layer.msg('登录成功！');
                        setTimeout(function(){
                            //登录返回
                            window.location.href= result.back_url || "${basePath}/";
                        },1000)
                    }
                },
                error:function(e){
                    console.log(e,e.message);
                    layer.msg('请看后台Java控制台，是否报错，确定已经配置数据库和Redis',new Function());
                }
            });
        });
        $('.page-container form .username, .page-container form .password').keyup(function(){
            $(this).parent().find('.error').fadeOut('fast');
        });
        //注册
        $("#register").click(function(){
            window.location.href="register.shtml";
        });
    });
</script>
</body>
</html>
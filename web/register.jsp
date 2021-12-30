<%--
  Created by IntelliJ IDEA.
  User: Jarvis
  Date: 2021/12/23
  Time: 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <script rel="stylesheet" src="js/jquery-3.6.0.js"></script>
    <script>
        //定义
        function register() {
            var userName = $("#userName").val();//方法中获取
            var email = $("#email").val();
            $.ajax({
                url: "/user",
                type: "post",
                //data: {opr: "userByName", "name": userName},
                data: {opr: "email", email: email},
                dateType: "text",
                success: function (date) {//成功后会有相应response 任何数据给data
                    if (date == "true") {
                        //$("#result").html("用户名可以使用");
                        $("#email1").html("邮箱可以使用");
                    } else {
                        //$("#result").html("用户名已被注册");
                        $("#email1").html("邮箱已被注册");
                    }
                },
                error: function () {
                    alert("请求失败。。。")
                }
            })
        }

    </script>
</head>
<body>
用户名：<input type="text" id="userName" name="userName" value=""/>
<span id="result" style="color: red"></span>
注册邮箱：<input type="text" name="email" id="email">
<span id="email1" style="color: red"></span>
<br>
<input type="button" value="注 册" onclick="register();">
</body>
</html>

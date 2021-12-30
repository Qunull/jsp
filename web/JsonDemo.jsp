<%--
  Created by IntelliJ IDEA.
  User: Jarvis
  Date: 2021/12/24
  Time: 9:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JSON数据展示</title>
    <script rel="stylesheet" src="js/jquery-3.6.0.js"></script>
    <script type="text/javascript">
        $(function (){
            //1.JSON对象
            var userJson = {
                "id":1,
                "name":"张三",
                "password":"123456"
            };
            $("#objectDiv").html("ID："+userJson.id+"<br/>"+
                "用户名："+userJson.name+"<br/>"+
                "密 码："+userJson.password);
            //2.JSON格式 的 字符串数组
            var country = ["中国","美国","俄罗斯"];
            var $country = $(country);//封装成jquery对象
            $country.each(function () {//使用each方法
                //创建option 标签 追加到select
               var $option = $("<option>" +this+ "</option>") ;
               $("#arraySel").append($option);
               //创建li 追加到ul
                var $li = $("<li>" +this+ "</li>") ;
                $("#arrayUl").append($li);
            });
            //3.JSON对象数组
            var userJSONArray = [
                {"id":1,"name":"admin","password":"0000"},
                {"id":2,"name":"詹姆斯","password":"1111"},
                {"id":3,"name":"王五","password":"2222"}
            ];
            var $table = $("<table border='1'><tr><td>"+
                "ID"+"</td><td>"+"用户名"+"</td><td>"+
                "密码"+"</td></tr></table>");
            var $userJSONArry = $(userJSONArray);
            $userJSONArry.each(function (){
                var $tr = $("<tr><td>"+this.id+
                    "</td><td>"+this.name+
                    "</td><td>"+ this.password+
                    "</td></tr>");
                $table.append($tr);
            });
            $("#objectArrayDiv").append($table);
        });
    </script>
</head>
<body>
一、JSON格式的user对象:<div id="objectDiv"></div><br>
二、JSON格式的字符串数组:&nbsp;&nbsp;<select id="arraySel"></select>
<ul id="arrayUl"></ul>
三、JSON格式的user对象数组:<div id="objectArrayDiv"></div>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: Jarvis
  Date: 2021/12/6
  Time: 9:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8"  %>
<html>
<head>
    <title>注册信息</title>
</head>
<body>
<%
    //解决中文乱码
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    String userName = request.getParameter("uname");
    String password = request.getParameter("upassword");
    /*String email = request.getParameter("email");
    out.print("<h2>"+userName+"<h2>");
    out.print("<h2>"+password+"<h2>");
    out.print("<h2>"+email+"<h2>");
    String[] hobbies = request.getParameterValues("hobby");
    if (hobbies != null && hobbies.length != 0){
        for (int i = 0; i < hobbies.length; i++) {
            out.print(hobbies[i]+"&nbsp;");
        }
    }*/
    if(userName.equals("admin") && password.equals("123")){
        out.print("登录成功");
    }else {
        out.print("登陆失败");
    }
%>
</body>
</html>

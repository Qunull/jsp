<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="entity.User" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title>My JSP 'doLogin.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->

</head>

<body>
<%
    String userName = request.getParameter("userName");
    if (userName == null || userName.equals("")) {
        response.sendRedirect("enter.jsp");
    } else {
        User user = new User();
        user.setUserName(userName);
        session.setAttribute("user", user);
        response.sendRedirect("online.jsp");
    }
%>
</body>
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.user.UserDao" %>
<%@ page import="dao.user.UserDaoImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<%@ page import="service.user.UserService" %>
<%@ page import="service.user.imlp.UserServiceImpl" %>
<html>
<head>
    <title>访问UserDao数据</title>
</head>
<body>
<%
    //使用方 调用的是 业务层 -- service
    UserService userService = new UserServiceImpl();//接口指向实现类
    List<User> userList = userService.getUserList();
    for (User user : userList){
        out.print(user.getId()+"&nbsp;&nbsp;"+
                user.getUserName()+"&nbsp;&nbsp;"+
                user.getPassword()+"&nbsp;&nbsp;"+
                user.getEmail()+"<br/>");
    }
%>
</body>
</html>

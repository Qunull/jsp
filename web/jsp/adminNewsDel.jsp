<%@include file="../common/common.jsp"%>>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    //获取要删除的 news 对象的 id
    int id = Integer.parseInt(request.getParameter("id"));

    //创建 NewsService 对象，调用其删除 delete() 方法，实现删除
    newsService.delete(id);

    //返回admin首页
    request.getRequestDispatcher("newsDetailList.jsp").forward(request, response);
%>
</body>
</html>

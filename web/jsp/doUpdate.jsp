<%@ page import="entity.News" %>
<%@ page import="java.util.Date" %>
<%@include file="../common/common.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    String categoryId = request.getParameter("categoryId");
    String title = request.getParameter("title");
    String summary = request.getParameter("summary");
    String newscontent = request.getParameter("newscontent");
    String author = request.getParameter("author");
    //做一个 新闻对象
    News news = (News) session.getAttribute("news");
    news.setTitle(title);
    news.setContent(newscontent);
    news.setAuthor(author);
    news.setSummary(summary);
    news.setCreateDate(new Date());
    news.setCategoryId(Integer.valueOf(categoryId));
    //执行 添加 操作
    if(newsService.updateNews(news)){//添加成功
%>
<jsp:forward page="newsDetailList.jsp"></jsp:forward>
<%
    }else {
        response.sendRedirect("adminNewsUpdate.jsp");
    }
%>
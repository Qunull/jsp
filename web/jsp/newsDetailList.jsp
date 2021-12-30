<%@ page import="service.news.NewsService" %>
<%@ page import="service.news.impl.NewsServiceImpl" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.News" %>
<%@ page import="util.PageUtil" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%--<jsp:include page="../common/common.jsp"/>--%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>无标题文档</title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/css/common.css"/>
    <style type="text/css">
        <!--

        -->
    </style>
    <%-- <script type="text/javascript">
         function addNews() {
             //跳转到添加页面
             window.href = "newsDetailCreateSimple.jsp";
         }
     </script>--%>
    <script type="text/javascript">
        function addNews() {
            location.href = "/jsp/newsDetailCreateSimple.jsp"
        }

        //点击 首页 上一页 下一页 末页 触发函数
        /*   function page_nav(form, pageIndex) {
               form.currentPageNo.value = pageIndex;
               form.submit();//提交操作
           }*/

        function jump_to(form, pageIndex) {
            form.currentPageNo.value = pageIndex;
            form.submit();//提交操作
        }
    </script>
</head>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    //访问业务层 获取新闻
    //NewsService newsService = new NewsServiceImpl();//生成service对象
  /*  String pageSizeStr = request.getParameter("pageSize");//页面容量
    String currentPageNoStr = request.getParameter("currentPageNo");//当前页码
    int currentPageNo = currentPageNoStr == null ? 1 : Integer.parseInt(currentPageNoStr);
    int pageSize = pageSizeStr == null ? 2 : Integer.parseInt(pageSizeStr);
    String title = request.getParameter("title");
    if (title == null) {
        title = "";
    }
    String categoryIdStr = request.getParameter("categoryId");
    Integer categoryId = categoryIdStr == null ? 0 : Integer.valueOf(categoryIdStr);
    int totalCount = newsService.getCount(title, categoryId);//总条数
    PageUtil pageUtil = new PageUtil();
    pageUtil.setPageSize(pageSize);
    pageUtil.setCurrentPageNo(currentPageNo);
    pageUtil.setTotalCount(totalCount);
    int totalPageCount = pageUtil.getTootalPageCount();//总页数
    //对首页 和 末页 进行控制
    if (currentPageNo <= 1) {
        currentPageNo = 1;
    }
    if (currentPageNo > totalPageCount) {
        currentPageNo = totalPageCount;
    }

*/
%>
<body>


<%--首次 访问改查询页面的时候 -- 访问1次Servlet--%>
<%
    List<News> newsList = (List<News>) request.getAttribute("newsList");
    if (newsList == null || newsList.size() == 0) {//第一次访问
        request.getRequestDispatcher(request.getContextPath() + "/news?opr=newsList").forward(request, response);
    }
%>


<!--页面顶部-->
<%--<div id="header">
    <div class="main-top">
        <div class="logo"><a href=""><span>新闻大视野</span></a></div>

        <div class="nav">
            <ul class="clearfix">
                <li><a href="#">首页</a></li>
                <li><a href="#">国内</a></li>
                <li><a href="#">国际</a></li>
                <li><a href="#">娱乐</a></li>
                <li><a href="#">军事</a></li>
            </ul>
        </div>
    </div>
    <!--banner-->
    <div class="main-banner">
        <img src="<%=request.getContextPath() %>/images/banner.png"/>
    </div>
    <!--管理工具栏-->
    <div class="admin-bar">
        <span class="fr">退出账户</span>
        管理员：admin 2012-06-19
    </div>
</div>--%>
<!--主体-->
<%--<div id="content" class="main-content clearfix">--%>
<%-- <div class="main-content-left">
     <!--新闻管理-->
     <div class="class-box">
         <div class="class-box-header">
             <h3>新闻管理</h3>
         </div>
         <div class="class-box-content">
             <ul>
                 <li><a href="#">新闻管理</a></li>
                 <li class="clear-bottom-line"><a href="#">最新新闻</a></li>
             </ul>
         </div>
     </div>
     <!--//-->
     <!--主题管理-->
     <div class="class-box">
         <div class="class-box-header">
             <h3>分类管理</h3>
         </div>
         <div class="class-box-content">
             <ul>
                 <li><a href="#">分类管理</a></li>
                 <li class="clear-bottom-line"><a href="#">删除主题</a></li>
             </ul>
         </div>
     </div>
     <!--//-->
     <!--账户管理-->
     <div class="class-box">
         <div class="class-box-header">
             <h3>用户管理</h3>
         </div>
         <div class="class-box-content">
             <ul>
                 <li><a href="#">用户管理</a></li>
                 <li class="clear-bottom-line"><a href="#">付费服务</a></li>
             </ul>
         </div>
     </div>
     <!--//-->
 </div>--%>
<div class="main-content-right">
    <!--即时新闻-->
    <div class="main-text-box">
        <div class="main-text-box-tbg">
            <div class="main-text-box-bbg">
                <form name="searchForm" id="searchForm" action="${pageContext.request.contextPath}/news" method="post">
                    <input type="hidden" name="opr" value="newsList"/>
                    <div>
                        新闻分类：
                        <select name="categoryId">
                            <%--  <%if (categoryId == 0) {%>--%>
                            <option value="0"
                                    <c:if test="${categoryId == 0}">selected</c:if> >全部
                            </option>
                            <option value='1'
                                    <c:if test="${categoryId == 1}">selected</c:if> >国内
                            </option>
                            <option value='2'
                                    <c:if test="${categoryId == 2}">selected</c:if> >国际
                            </option>
                            <option value='3'
                                    <c:if test="${categoryId == 3}">selected</c:if> >娱乐
                            </option>
                            <option value='4'
                                    <c:if test="${categoryId == 4}">selected</c:if> >军事
                            </option>
                            <option value='5'
                                    <c:if test="${categoryId == 5}">selected</c:if> >财经
                            </option>
                            <option value='6'
                                    <c:if test="${categoryId == 6}">selected</c:if> >天气
                            </option>
                            <%--<%}%>--%>
                            <%--  <%if (categoryId == 1) {%>
                              <option value="0">全部</option>
                              <option value='1' selected>国内</option>
                              <option value='2'>国际</option>
                              <option value='3'>娱乐</option>
                              <option value='4'>军事</option>
                              <option value='5'>财经</option>
                              <option value='6'>天气</option>
                              <%}%>
                              <%if (categoryId == 2) {%>
                              <option value="0">全部</option>
                              <option value='1'>国内</option>
                              <option value='2' selected>国际</option>
                              <option value='3'>娱乐</option>
                              <option value='4'>军事</option>
                              <option value='5'>财经</option>
                              <option value='6'>天气</option>
                              <%}%>
                              <%if (categoryId == 3) {%>
                              <option value="0">全部</option>
                              <option value='1'>国内</option>
                              <option value='2'>国际</option>
                              <option value='3' selected>娱乐</option>
                              <option value='4'>军事</option>
                              <option value='5'>财经</option>
                              <option value='6'>天气</option>
                              <%}%>
                              <%if (categoryId == 4) {%>
                              <option value="0">全部</option>
                              <option value='1'>国内</option>
                              <option value='2'>国际</option>
                              <option value='3'>娱乐</option>
                              <option value='4' selected>军事</option>
                              <option value='5'>财经</option>
                              <option value='6'>天气</option>
                              <%}%>
                              <%if (categoryId == 5) {%>
                              <option value="0">全部</option>
                              <option value='1'>国内</option>
                              <option value='2'>国际</option>
                              <option value='3'>娱乐</option>
                              <option value='4'>军事</option>
                              <option value='5' selected>财经</option>
                              <option value='6'>天气</option>
                              <%}%><%if (categoryId == 6) {%>
                              <option value="0">全部</option>
                              <option value='1'>国内</option>
                              <option value='2'>国际</option>
                              <option value='3'>娱乐</option>
                              <option value='4'>军事</option>
                              <option value='5'>财经</option>
                              <option value='6' selected>天气</option>
                              <%}%>
  --%>

                        </select>
                        新闻标题<input type="text" name="title" id="title" value='${title}'/>
                        <button type="submit" class="page-btn">GO</button>
                        <button type="button" onclick="addNews();" class="page-btn">增加</button>
                        <input type="hidden" id="currentPageNo" name="currentPageNo" value="1"/>
                        <input type="hidden" name="pageSize" value="2"/>
                        <input type="hidden" name="totalPageCount" value="2"/>
                    </div>
                </form>
                <table cellpadding="1" cellspacing="1" class="admin-list">
                    <thead>
                    <tr class="admin-list-head">
                        <th>新闻标题</th>
                        <th>作者</th>
                        <th>时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%

                        /*  List<News> newsList = newsService.getNewsList(title, categoryId, currentPageNo, pageSize);
                          session.setAttribute("newsList", newsList);*/
                    %>
                    <c:forEach items="${newsList}" var="news" varStatus="status">
                        <tr
                                <c:if test="${status.count%2==0}">class="admin-list-td-h2" </c:if> >
                            <td>
                                <a href='${pageContext.request.contextPath}/news?id=${news.id}&opr=newsDetail'>${news.title}</a>
                            </td>
                            <td>${news.author}</td>
                            <td><fmt:formatDate value="${news.createDate}" pattern="yyyy-MM-dd"/></td>
                            <td><a href='${pageContext.request.contextPath}/news?id=${news.id}&opr=toUpdate'>修改</a>
                                <a href="javascript:if(confirm('确认是否删除此新闻？')) location='/jsp/adminNewsDel.jsp?id=${news.id}'">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <%--<tr class="admin-list-td-h2">
                        <td><a href='adminNewsView.jsp?id=3'>JAVA学习开始了</a></td>
                        <td>admin</td>
                        <td>2016-6-12</td>
                        <td><a href='adminNewsCreate.jsp?id=3'>修改</a>
                            <a href="javascript:if(confirm('确认是否删除此新闻？')) location='adminNewsDel.jsp?id=3'">删除</a>
                        </td>
                    </tr>

                    <tr >
                        <td><a href='adminNewsView.jsp?id=4'>Java Web学习心得</a></td>
                        <td>admin</td>
                        <td>2016-6-12</td>
                        <td><a href='adminNewsCreate.jsp?id=4'>修改</a>
                            <a href="javascript:if(confirm('确认是否删除此新闻？')) location='adminNewsDel.jsp?id=4'">删除</a>
                        </td>
                    </tr>

                    <tr class="admin-list-td-h2">
                        <td><a href='adminNewsView.jsp?id=5'>云计算现状</a></td>
                        <td>admin</td>
                        <td>2016-6-12</td>
                        <td><a href='adminNewsCreate.jsp?id=5'>修改</a>
                            <a href="javascript:if(confirm('确认是否删除此新闻？')) location='adminNewsDel.jsp?id=5'">删除</a>
                        </td>
                    </tr> --%>

                    </tbody>
                </table>
                <div class="page-bar">
                    <c:import url="rollPage.jsp">
                        <%--<c:param name="pageIndex" value="<%=Integer.toString(currentPageNo)%>"/>
                        <c:param name="totalCount" value="<%=Integer.toString(totalCount)%>"/>
                        <c:param name="totalPage" value="<%=Integer.toString(totalPageCount)%>"/>--%>
                        <c:param name="pageIndex" value="${currentPageNo}"/>
                        <c:param name="totalCount" value="${totalCount}"/>
                        <c:param name="totalPage" value="${totalPageCount}"/>
                    </c:import>
                    <%--  <ul class="page-num-ul clearfix">
                          <li>共<%=totalCount%>条记录&nbsp;&nbsp; <%=currentPageNo%>/<%=totalPageCount%>页</li>&nbsp;
                          <a href="javascript:page_nav(document.forms[0],1);">首页</a>&nbsp;
                          <a href="javascript:page_nav(document.forms[0],<%=currentPageNo%>-1);">上一页</a>&nbsp;&nbsp;&nbsp;
                          <a href="javascript:page_nav(document.forms[0],<%=currentPageNo%>+1);">下一页</a>&nbsp;
                          <a href="javascript:page_nav(document.forms[0],<%=totalPageCount%>);">最后一页</a>&nbsp;&nbsp;
                      </ul>
                      <span class="page-go-form"><label>跳转至</label>
           <input type="text" name="inputPage" id="inputPage" class="page-key"/>页
           <button type="button" class="page-btn"
                   onClick='jump_to(document.forms[0],document.getElementById("inputPage").value)'>GO</button>
          </span>--%>
                </div>
            </div>
        </div>
    </div>
</div>
<%--</div>--%>
<!--底部-->
<%--<div class="main-footer-box">
    24小时客户服务热线：010-68988888 常见问题解答 新闻热线：010-627488888<br/>
    文明办网文明上网举报电话：010-627488888 举报邮箱：jubao@bj-aptech.com.cn<br/>
    Coyright&copy;1999-2007 News China gov,All Right Reserved.<br/>
    新闻中心版权所有
</div>--%>
</body>
</html>
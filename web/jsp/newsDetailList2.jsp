<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="entity.News" %>
<%@ page import="java.util.List" %>
<%@ page import="util.PageUtil" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@include file="../common/common.jsp"%>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/css/common.css"/>
<script rel="stylesheet" src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript" >
    function addNews(){
        //跳转到添加页面
        window.location = "/jsp/newsDetailCreateSimple.jsp";
    }
    $(function (){
        $.ajax({
            url:"/news",
            type:"post",
            data:{opr:"newsList"},
            dataType:"json",
            success:function (data){
                var $data = $(data);
                var i = 1;
                $data.each(function (){
                    if(i%2==0){
                        var $tr = $("<tr class='admin-list-td-h2'>" +
                            "<td><a href='${pageContext.request.contextPath}/news?id="+this.id+"&opr=newsDetail'>"+this.title+"</a></td>" +
                            "<td>"+this.author+"</td>"+
                            "<td>"+this.createDate+"</td>"+
                            "<td><a href='${pageContext.request.contextPath}/news?id="+this.id+"&opr=toUpdate'>修改</a>"+
                            "<a href=\"javascript:if(confirm('确认是否删除此新闻？')) location='adminNewsDel.jsp?id="+this.id+"'\">删除</a>"+
                            "</td>"+
                            "</tr>");
                        $(".admin-list>tbody").append($tr);
                    }else{
                        var $tr = $("<tr>" +
                            "<td><a href='${pageContext.request.contextPath}/news?id="+this.id+"&opr=newsDetail'>"+this.title+"</a></td>" +
                            "<td>"+this.author+"</td>"+
                            "<td>"+this.createDate+"</td>"+
                            "<td><a href='${pageContext.request.contextPath}/news?id="+this.id+"&opr=toUpdate'>修改</a>"+
                            "<a href=\"javascript:if(confirm('确认是否删除此新闻？')) location='adminNewsDel.jsp?id="+this.id+"'\">删除</a>"+
                            "</td>"+
                            "</tr>");
                        $(".admin-list>tbody").append($tr);
                    }
                    i++;
                });
            },
            error:function (){
                alert("请求失败");
            }
        });
    });

</script>
    <%--首次 访问改查询页面的时候 -- 访问1次Servlet--%>
    <div class="main-content-right">
        <!--即时新闻-->
        <div class="main-text-box">
            <div class="main-text-box-tbg">
                <div class="main-text-box-bbg">
                    <form name ="searchForm" id="searchForm" action="${pageContext.request.contextPath}/news" method="post">
                        <input type="hidden" name="opr" value="newsList" />
		 	          <div>
		 				新闻分类：
		 					<select name="categoryId">
                                <option value="0" <c:if test="${categoryId ==0 }">selected</c:if>   >全部</option>
                                <option value='1' <c:if test="${categoryId ==1 }">selected</c:if> >国内</option>
                                <option value='2' <c:if test="${categoryId ==2 }">selected</c:if> >国际</option>
                                <option value='3' <c:if test="${categoryId ==3 }">selected</c:if> >娱乐</option>
                                <option value='4' <c:if test="${categoryId ==4 }">selected</c:if> >军事</option>
                                <option value='5' <c:if test="${categoryId ==5 }">selected</c:if> >财经</option>
                                <option value='6' <c:if test="${categoryId ==6 }">selected</c:if> >天气</option>
	        				</select>
		 				新闻标题<input type="text" name="title" id="title" value='${title}'/>
		 					<button type="submit" class="page-btn">GO</button>
		 					<button type="button" onclick="addNews();" class="page-btn">增加</button>
		 					<input type="hidden" id="currentPageNo" name="currentPageNo" value="1"/>
		 					<input type="hidden"  name="pageSize" value="2"/>
		 					<input type="hidden" name="totalPageCount" value="2"/>
		 	</div>
		 	</form>
			<table cellpadding="1" cellspacing="1" class="admin-list">
				<thead >
					<tr class="admin-list-head">
						<th>新闻标题</th>
                        <th>作者</th>
                        <th>时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div class="page-bar">
                <c:import url="rollPage.jsp">
                    <c:param name="pageIndex" value="${currentPageNo}"/>
                    <c:param name="totalCount" value="${totalCount}"/>
                    <c:param name="totalPage" value="${totalPageCount}"/>
                </c:import>
		    </div>
        </div>
       </div>
   </div>
   </div>
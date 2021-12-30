<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp"%>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
	</head>
<body>
<%--<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	//1.根据id查询出我们的新闻信息
	String id = request.getParameter("id");
	Integer _id = null;
	if (id != null && !id.equals("")){
		_id = Integer.valueOf(id);
	}else {
		_id = 0;
	}
	News news = newsService.getNewsListById(_id);//调用查询操作
	session.setAttribute("news",news);//将 新闻对象 封装到request
%>--%>
<form name ="dataFrm" id="dataFrm" action="${pageContext.request.contextPath}/news" method="post">
	<input type="hidden" name="opr" value="updateNews"/>
	<input type="hidden" name="id" value="${news.id}"/>
	<table  width="100%" border="0" cellspacing="5" cellpadding="0">
		<thead>
			<tr><td align="center" colspan="2" class="text_tabledetail2">增加新闻</td></tr>
		</thead>
		<tbody>
			<tr>
				<td style="text-align:right;" class="text_tabledetail2">分类</td>
				<td style="text-align:left;">
				<!-- 列出所有的新闻分类 -->
					<select name="categoryId">
							<option value="0"
									<c:if test="${news.categoryId == 0}">selected</c:if> >全部
							</option>
							<option value='1'
									<c:if test="${news.categoryId == 1}">selected</c:if> >国内
							</option>
							<option value='2'
									<c:if test="${news.categoryId == 2}">selected</c:if> >国际
							</option>
							<option value='3'
									<c:if test="${news.categoryId == 3}">selected</c:if> >娱乐
							</option>
							<option value='4'
									<c:if test="${news.categoryId == 4}">selected</c:if> >军事
							</option>
							<option value='5'
									<c:if test="${news.categoryId == 5}">selected</c:if> >财经
							</option>
							<option value='6'
									<c:if test="${news.categoryId == 6}">selected</c:if> >天气
							</option>
	        		</select>
				</td>
			</tr>
			<tr>
				<td style="text-align:right;" class="text_tabledetail2">标题</td>
				<td style="text-align:left;"><input type="text" name="title" value="${news.title}"/></td>
			</tr>
			<tr>
				<td style="text-align:right;" class="text_tabledetail2">作者</td>
				<td style="text-align:left;"><input type="text" name="author" value="${news.author}"/></td>
			</tr>
			
			<tr>
				<td style="text-align:right;" class="text_tabledetail2">摘要</td>
				<td style="text-align:left;"><textarea id="summary" name="summary" rows="8" cols="50">${news.summary}</textarea></td>
			</tr>
			<tr>
				<td style="text-align:right;" class="text_tabledetail2">内容</td>
				<td style="text-align:left;">
				<div id="xToolbar"></div>
				<textarea id="newscontent" name="newscontent" rows="8" cols="30">${news.content}</textarea></td>
			</tr>
			<tr>
				<td style="text-align:right;" class="text_tabledetail2">上传图片 </td>
				<td style="text-align:left;"><input type="text" name="picPath" value=""/></td>
			</tr>
			<tr>
				<td style="text-align:center;" colspan="2">
					<button type="submit" class="page-btn" name="save">保存</button>
					<button type="button" class="page-btn" name="return" onclick="javascript:location.href='/jsp/newsDetailList.jsp'">返回</button>
				</td>
			</tr>
		</tbody>
	</table>
</form>

</body>
</html>
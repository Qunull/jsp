<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
	function page_nav(frm,num){
		frm.currentPageNo.value=num;
		frm.submit();
	}
	
	function jump_to(frm,pageno){
	 	//var regexp=/^\d+$/;
	 	var regexp=/^[1-9]\d*$/;
	 	var totalPage = document.getElementById("inputPage").value;
		if(!regexp.test(pageno)){
			alert("请输入 正确的数字！");
			return false;
		}else if((pageno-totalPage) > 0){
			alert("总页码一共"+totalPage+"页，请输入正确的页码！");
			return false;
		}else{
			page_nav(frm,pageno);
		}  
		
	}
</script>

<div class="page-bar">
<ul class="page-num-ul clearfix">
	<li>共${param.totalCount }条记录&nbsp;&nbsp; ${param.pageIndex }/${param.totalPage }页</li>
	<c:if test="${param.pageIndex>1 }" >
		<a href="javascript:page_nav(document.forms[0],1);">首页</a>
		<a href="javascript:page_nav(document.forms[0],${param.pageIndex-1 });">上一页</a>&nbsp;&nbsp;
	</c:if>
	<c:if test="${param.pageIndex<param.totalPage }" >
		<a href="javascript:page_nav(document.forms[0],${param.pageIndex+1 });">下一页</a>
		<a href="javascript:page_nav(document.forms[0],${param.totalPage });">最后一页</a>&nbsp;&nbsp;
	</c:if>
</ul>
 <span class="page-go-form"><label>跳转至</label>
    <input type="text" name="inputPage" id="inputPage" class="page-key" />页
    <button type="button" class="page-btn" onClick='jump_to(document.forms[0],document.getElementById("inputPage").value)'>GO</button>
</span>
</div> 
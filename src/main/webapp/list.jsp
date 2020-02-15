<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath()); 
%>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.4.4.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<title>员工列表</title>
<title>Insert title here</title>
</head>
<body>
<!-- 搭建显示页面 -->
<div class="container">
	<!-- 标题 -->
	<div class="row">
		<div class="col-md-12">
			<h1>SSM-CRUD</h1>
		</div>
	</div>
	<!-- 按钮 -->
	<div class="row">
		<div class="col-md-4 col-md-offset-8">
			<button class="btn btn-primary">新增</button>
			<button class="btn btn-danger">删除</button>
		</div>
	</div>
	
	<!-- 表格数据 -->
	<div class="row" style="margin-top:20px">
		<div class="col-md-12">
			<table class="table table-hover">
				<tr>
					<td>#</td>
					<td>empName</td>
					<td>gender</td>
					<td>email</td>
					<td>department</td>
					<td>操作</td>
				</tr>
				<c:forEach items="${pageInfo.list}" var="emp">
				</tr>
					<td>${emp.empId}</td>
					<td>${emp.empName}</td>
					<td>${emp.gender}</td>
					<td>${emp.email}</td>
					<td>${emp.department.deptName}</td>
					<td>
						<button class="btn btn-primary">
						<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
						新增</button>
						<button class="btn btn-danger">
						<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						删除</button>
					</td>
				
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
		当前${pageInfo.pageNum}页,总${pageInfo.pages}页,总记录${pageInfo.total}条
		
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<nav aria-label="Page navigation">
			  <ul class="pagination" style="width:520px;">
			  	<li><a href="${APP_PATH}/emps?pn=1" >首页</a></li>
			  	
			  	<c:if test="${pageInfo.hasPreviousPage}">
				    <li >
				      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous" >
				        <span aria-hidden="true">&laquo;</span>
				      </a>
				    </li>
			    </c:if>
			    
			    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
			    	<c:if test="${page_Num == pageInfo.pageNum}">
			    		<li class="active"><a href="#">${page_Num}</a></li>
			    	</c:if>
			    	
			    	<c:if test="${page_Num != pageInfo.pageNum}">
			    		<li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
			    	</c:if>
			    </c:forEach>
			    
			   <c:if test="${pageInfo.hasNextPage}">
			    <li>
			      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			    </c:if>
			    <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
			  </ul>
			</nav>
		</div>
	</div>
</div>
</body>
</html>
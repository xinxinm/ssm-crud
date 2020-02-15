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
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.9.1.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<title>员工列表</title>
<title>Insert title here</title>
</head>
<body>

<div class="modal fade" id="update_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
      		<form class="form-horizontal">
			  <div class="form-group">
			    <label for="inputEmail3" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10 ">
			    	<p class="form-control-static" name="empName" id="update_empName_input_static"></p>
			     <span  class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputEmail3" class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="email" class="form-control" name="email" id="update_emial_input" placeholder="输入员工邮箱">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  
			  <div class="form-group">
			  	<label for="inputEmail3" class="col-sm-2 control-label" style="margin-right:20px;">Gender</label>
			    <label class="radio-inline">
				  <input type="radio"  name="gender" id="update_gender_input1" value="M" > 男
				</label>
				<label class="radio-inline">
				  <input type="radio"  name="gender" id="update_gender_input2" value="F"> 女
				</label>
			  </div>
			  
			   <div class="form-group">
			  	<label for="inputEmail3" class="col-sm-2 control-label" >department</label>
			    	<div class="col-xs-4">
			    	<select class="form-control" id="updateselect" name="dId">
					  
					</select>
					</div>
			  </div>
			</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="update_button">更新</button>
      </div>
    </div>
  </div>
</div>



<!-- 员工添加的模态框  -->
<!-- Modal -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
      		<form class="form-horizontal">
			  <div class="form-group">
			    <label for="inputEmail3" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10 ">
			      <input type="text" class="form-control" name="empName" id="empName_input" placeholder="输入员工姓名">
			     <span  class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputEmail3" class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="email" class="form-control" name="email" id="empEmail_input" placeholder="输入员工邮箱">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  
			  <div class="form-group">
			  	<label for="inputEmail3" class="col-sm-2 control-label" style="margin-right:20px;">Gender</label>
			    <label class="radio-inline">
				  <input type="radio"  name="inlineRadioOptions gender" id="sex_radioman" value="man" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio"  name="inlineRadioOptions gender" id="sex_radiofeman" value="feman"> 女
				</label>
			  </div>
			  
			   <div class="form-group">
			  	<label for="inputEmail3" class="col-sm-2 control-label" >department</label>
			    	<div class="col-xs-4">
			    	<select class="form-control" id="selectModelButton" name="dId">
					  
					</select>
					</div>
			  </div>
			</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="save_emp_button">保存</button>
      </div>
    </div>
  </div>
</div>




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
			<button class="btn btn-primary" id="emp_add_model_btn">新增</button>
			<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
		</div>
	</div>
	
	<!-- 表格数据 -->
	<div class="row" style="margin-top:20px">
		<div class="col-md-12">
			<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<td style="padding-top:18px;">
								<input type="checkbox" id="check_all">
							</td>
							<td>#</td>
							<td>empName</td>
							<td>gender</td>
							<td>email</td>
							<td>department</td>
							<td style="padding-left:65px;">操作</td>
						</tr>
					</thead>
					<tbody class="table_emptr"></tbody>
			</table>
		</div>
	</div>
	
	
	<div class="row">
		<div class="col-md-4 col-md-offset-4" id="page_info_area">
		
		</div>
		
		<div class="col-md-6 col-md-offset-4" id="page_nav_area">
		
		</div>
	</div>
	
</div>
<script type="text/javascript">
	var totalRecode;
	var currentPage;
	//页面加载完成后，直接去发送一个ajax请求，要到分页数据
	$(function(){
		//去首页
		to_page(1);
	});

	function to_page(pn){
		$.ajax({
			url:"${APP_PATH}/emps",
			data:"pn="+pn,
			type:"get",
			success:function(result){
				//console.log(result);
				//1.解析并显示员工数据
				build_emps_table(result);
				//2.解析并显示分页信息
				buid_page_info(result);
				//3.解析分页条数据。
				build_page_nav(result);
			}
		});
	}

	function build_emps_table(result){
		//清空table表格
		$(".table_emptr").empty();
		var emps = result.extend.pageInfo.list;
		$.each(emps,function(index,item){
			//append方法执行完成后还是返回原来的元素。
			var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>");
			var empIdTd = $("<td></td>").append(item.empId);
			var empNameTd = $("<td></td>").append(item.empName);
			var empGenderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
			var emailTd = $("<td></td>").append(item.email);
			var deptNameTd = $("<td></td>").append(item.department.deptName);
			var editButtonTd = 	$("<button></button>").addClass("btn btn-primary edit_btn").append("<span></span>").addClass("glyphicon glyphicon-pencil").text("编辑");
			editButtonTd.attr("edit_id",item.empId);
			var deleteButtonTd = $("<button></button>").addClass("btn btn-danger delete_btn").append("<span></span>").addClass("glyphicon glyphicon-trash").text("删除");
			deleteButtonTd.attr("delete_id",item.empId);
			var btnTd = $("<td></td>").append(editButtonTd).append(" ").append(deleteButtonTd);
		$("<tr></tr>")
		.append(checkBoxTd)
		.append(empIdTd)
		.append(empNameTd)
		.append(empGenderTd)
		.append(emailTd)
		.append(deptNameTd)
		.append(btnTd)
		.appendTo(".table_emptr")
		});
		$("td").css({ height:"40px",lineHeight:"40px"});
		
		$(".edit_btn,.delete_btn").css({marginTop:"0px",marginRight:"10px"});
		//$("tr td:gt(5)").css("border","1px solid red");
		$(".check_item").css("marginTop","12px");
	}
	
	function buid_page_info(result){
		$("#page_info_area").empty();
		$("#page_info_area").append("当前页"
				+result.extend.pageInfo.pageNum+",总"+
				result.extend.pageInfo.pages+"页,"+
				result.extend.pageInfo.total+"总记录条");
		totalRecode = result.extend.pageInfo.total;
		currentPage = result.extend.pageInfo.pageNum;
	}
	
	function build_page_nav(result){
		$("#page_nav_area").empty();
		//page_nav_area
		var ul = $("<ul></ul>").addClass("pagination");
		var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
		var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
		if(result.extend.pageInfo.hasPreviousPage == false)
		{
			//没有前一页
			firstPage.addClass("disabled");
			prePageLi.addClass("disabled");
		}else {
			//为元素添加点击事件
			firstPage.click(function(){
				to_page(1);
			});
			//首页和前一页
			prePageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum-1);
			});
		}
		
		var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
		var lastPage = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
		if(result.extend.pageInfo.hasNextPage == false)
		{
			//没有前一页
			nextPageLi.addClass("disabled");
			lastPage.addClass("disabled");
		}else {
			//下一页点击
			nextPageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum+1);
			})
			
			//末页点击
			lastPage.click(function(){
				to_page(result.extend.pageInfo.pages);
			})
		}
		
		
		
		
		//添加首页前一页
		ul.append(firstPage).append(prePageLi);
		//1,2,3,4,5遍历给ul页码提示
		var pageNums = result.extend.pageInfo.navigatepageNums;
		$.each(pageNums,function(index,item){
			var numLi = $("<li></li>").append($("<a></a>").append(item));
			if(result.extend.pageInfo.pageNum == item)
			{
				numLi.addClass("active");
			}
			
			numLi.click(function(){
				to_page(item);
			})
			ul.append(numLi);
		});
		
		//添加下一页和末页的提示
		ul.append(nextPageLi).append(lastPage);
		
		//把ul加入nav
		var navEle = $("<nav></nav>").append(ul);	
		
		navEle.appendTo("#page_nav_area");
	}
	
	//表单样式 清空和清空内容
	function rest_form(){
		$("#empAddModel form")[0].reset();
		//清空表单样式
		$("#empAddModel form").find("*").removeClass("has-error has-success");
		$("#empAddModel form").find(".help-block").text("");
	}
	
	
	
	//模块框的打开
	$("#emp_add_model_btn").click(function(){
		//点击新增按钮
		$("#empAddModel").modal({
			backdrop:"static"
		});
		
		rest_form();
		getDepts("#selectModelButton");
	});
	
	
	function getDepts(ele){
		$(ele).empty();
		$.ajax({
			url:"${APP_PATH}/depts",
			type:"GET",
			success:function(result){
				$("#selectModelButton").empty();
				var dept = result.extend.depts;
				$.each(dept,function(index,item){
					var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
					optionEle.appendTo(ele);
				})
			}
			
		});
	}
	
	//input框验证
	function validate_add_form(){
		$("#empName_input").removeClass("has-error has-success");
		var empName = $("#empName_input").val();
		var regName = /(^[a-zA-Z0-9_-]{3,16}$) |(^[\u2E80-\u9FFF]+$)/;
		if(!regName.test(empName))
		{
			$("#empName_input").parent().addClass("has-error");
			$("#empName_input").next("span").text("用户名必须在3-16位或2-5个汉字")
			return false;
		}else {
			$("#empName_input").parent().addClass("has-success");
			$("#empName_input").next("span").text("")
		};
		
		$("#empEmail_input").removeClass("has-error has-success");
		var empEmail = $("#empEmail_input").val();
		var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		if(!regEmail.test(empEmail))
		{
			$("#empEmail_input").parent().addClass("has-error");
			$("#empEmail_input").next("span").text("邮箱地址错误必须有@.com")
			return false;
		}else {
			$("#empEmail_input").parent().addClass("has-success");
			$("#empEmail_input").next("span").text("")
		};
		
		return true;
		
	}
	
	//检查用户名是否存在
	$("#empName_input").change(function(){
		//发送ajax请求
		$("#empName_input").parent().removeClass("has-success has-error");
		var empName = $(this).val();
		
		$.ajax({
			url:"${APP_PATH}/checkuser",
			data:"empName="+empName,
			type:"POST",
			success:function(result){
				if(result.code == 100)
				{
					$("#empName_input").next("span").text("用户名可用");
					$("#empName_input").parent().addClass("has-success");
				}else {
					$("#empName_input").next("span").text(result.extend.va_msg);
					$("#empName_input").parent().addClass("has-error");
				}
			}
			
		});
	});
	
	$("#save_emp_button").click(function(){
		/*
		if(!validate_add_form())
		{
			return false;
		}*/
		$.ajax({
			url:"${APP_PATH}/emp",
			type:"POST",
			data:$("#empAddModel form").serialize(),
			success:function(result){
				if(result.code == 100)
				{
					//关闭模态框
					$("#empAddModel").modal('hide');
					//到最后一页
					to_page(totalRecode);
				}else {
					//显示失败信息
					if(undefined != result.extend.errorFields.email)
					{
						//显示员工的错误信息
						$("#empEmail_input").parent().addClass("has-error");
						$("#empEmail_input").next("span").text(result.extend.errorFields.email);
					}
					
					else if(undefined != result.extend.errorFields.empName)
					{
						$("#empName_input").parent().addClass("has-error");
						$("#empName_input").parent().addClass(result.extend.errorFields.empName);
					}
				}
			}
		});
		
	});
	//点击删除的按钮
	$(document).on("click",".delete_btn",function(){
		//1.弹出确认删除框
		var empName = $(this).parents("tr").find("td:eq(2)").text();
		var empId = $(this).attr("delete_id");
		//alert($(this).parents("tr").find("td:eq(1)").text())
		
		if(confirm("确认删除["+empName+"]吗？"))
		{
			//确认发送ajax请求
			$.ajax({
				url:"${APP_PATH}/emp/"+empId,
				type:"DELETE",
				success:function(result){
					to_page(result.extend.pageInfo.pageNum);
				}
			});
		}
	});
	
	//jquery中使用on来识别class因为按钮之间就创建了click事件了
	$(document).on("click",".edit_btn",function(){
		getDepts("#update_modal select");
		getEmp($(this).attr("edit_id"));
		
		//3.把员工的id传递给模态框的更新按钮
		$("#update_button").attr("edit_id",$(this).attr("edit_id"));
		$("#update_modal").modal({
			backdrop:"static"
		});
		
	});
	
	
	function getEmp(id){
		$.ajax({
			url:"${APP_PATH}/emp/"+id,
			type:"GET",
			success:function(result){
				var empData = result.extend.emp;
				$("#update_empName_input_static").text(empData.empName);
				$("#update_emial_input").val(empData.email);
				$("#update_modal input[name='gender']").val([empData.gender]);
				$("#update_modal select").val([empData.dId])
			}
		})
	}
	
	//点击更新，更新员工信息
	$("#update_button").click(function(){
		//验证邮箱是否合法
		var empEmail = $("#update_emial_input").val();
		var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		if(!regEmail.test(empEmail))
		{
			$("#update_emial_input").parent().addClass("has-error");
			$("#update_emial_input").next("span").text("邮箱地址错误必须有@.com")
			return false;
		}else {
			$("#update_emial_input").parent().addClass("has-success");
			$("#update_emial_input").next("span").text("")
		};
		
		//AJAX发送请求中这边需要用POST来接收EmployeeController中put请求的数据
		//如果这边直接用PUT请求获取不到数据数据只为在服务器端为NULL,发送不了给服务器
		//即使是request.getParameter("")也获取不到。
		//发送ajax请求：
		$.ajax({
			url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
			type:"POST",
			data:$("#update_modal form").serialize()+"&_method=PUT",
			success:function(result){
				$("#update_modal").modal("hide");
				//to_page(currentPage);
				to_page(currentPage);
			}
		})
	});
	
	//完成全选全不选
	$("#check_all").click(function(){
		//使用prop修改原生属性值
		//alert($(this).prop("checked"))
		$(".check_item").prop("checked",$(this).prop("checked"));
		
	});
	
	$(document).on("click",".check_item",function(){
		//判断选中的元素是否为5个
		var flag = $(".check_item:checked").length == $(".check_item").length;
		$("#check_all").prop("checked",flag);
	});
	
	//点击全部删除
	$("#emp_delete_all_btn").click(function(){
		var empNames = "";
		var del_idstr = "";
		$.each($(".check_item:checked"),function(){
			empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
		
			del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
		});
		
		//去除emps多余的，
		empNames = empNames.substring(0, empNames.length-1);
		//去除多余员工id的-
		del_idstr = del_idstr.substring(0, del_idstr.length-1);
		
		if(confirm("确认删除【"+empNames+"】吗？"))
		{
			$.ajax({
				//发送ajax请求
				url:"${APP_PATH}/emp/"+del_idstr,
				type:"DELETE",
				success:function(result){
					to_page(currentPage);
				}
				
			});
		}
	});
	
</script>
</body>
</html>
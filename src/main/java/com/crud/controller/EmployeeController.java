package com.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crud.bean.Employee;
import com.crud.bean.Msg;
import com.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
/*
 * 处理员工CRUD
 * */
@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;
	
	//跟新员工
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee) throws Exception{
		System.out.println("-------"+employee+"-------");
		employeeService.updateEmp(employee);
		
		return Msg.success();
	}
	
	//删除员工
	//批量删除1-2-3
	//单个删除1
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids")String ids) throws Exception
	{
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for (String string:str_ids) {
				
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		
		return Msg.success();
	}
	
	//员工保存
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) throws Exception{
		if(result.hasErrors())
		{
			Map<String,Object> map = new HashMap<>();
			//校验失败返回失败。在模态框中显示校验失败的信息
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段："+fieldError.getField());
				System.out.println("错误的信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) throws Exception{
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg selectNameIsRepeat(@RequestParam("empName")String empName) throws Exception{
		//先判断用户名是否合法表达式：
		String regex = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]+$)";
		if(!empName.matches(regex)){
			return Msg.fail().add("va_msg", "用户名必须是3-16位或者2个汉字");
		}
		
		//数据库用户名的校验
		boolean b = employeeService.selectNameIsRepeat(empName);
		if(b)
		{
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名已存在");
		}
	}
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(
			@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) throws Exception{
		
				//这不是一个分页查询
				//引入PageHelper分页插件，插入页码以及分页。
				PageHelper.startPage(pn,5);
				//startPage后面紧跟的这个查询就是一个分页查询
				List<Employee> emps = employeeService.getALL();
				//使用pageInfo包装查询后的结果，只需要将pageInfo交给页面
				//封装了详细的分页信息，包括我们查询出来的数据,传入连续显示的页数
				PageInfo page = new PageInfo(emps,5);
				return Msg.success().add("pageInfo",page);
	}
	
}

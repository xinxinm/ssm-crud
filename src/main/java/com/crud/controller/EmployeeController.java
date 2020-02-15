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
 * ����Ա��CRUD
 * */
@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;
	
	//����Ա��
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee) throws Exception{
		System.out.println("-------"+employee+"-------");
		employeeService.updateEmp(employee);
		
		return Msg.success();
	}
	
	//ɾ��Ա��
	//����ɾ��1-2-3
	//����ɾ��1
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids")String ids) throws Exception
	{
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			//��װid�ļ���
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
	
	//Ա������
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) throws Exception{
		if(result.hasErrors())
		{
			Map<String,Object> map = new HashMap<>();
			//У��ʧ�ܷ���ʧ�ܡ���ģ̬������ʾУ��ʧ�ܵ���Ϣ
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("������ֶΣ�"+fieldError.getField());
				System.out.println("�������Ϣ��"+fieldError.getDefaultMessage());
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
		//���ж��û����Ƿ�Ϸ����ʽ��
		String regex = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]+$)";
		if(!empName.matches(regex)){
			return Msg.fail().add("va_msg", "�û���������3-16λ����2������");
		}
		
		//���ݿ��û�����У��
		boolean b = employeeService.selectNameIsRepeat(empName);
		if(b)
		{
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "�û����Ѵ���");
		}
	}
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(
			@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) throws Exception{
		
				//�ⲻ��һ����ҳ��ѯ
				//����PageHelper��ҳ���������ҳ���Լ���ҳ��
				PageHelper.startPage(pn,5);
				//startPage��������������ѯ����һ����ҳ��ѯ
				List<Employee> emps = employeeService.getALL();
				//ʹ��pageInfo��װ��ѯ��Ľ����ֻ��Ҫ��pageInfo����ҳ��
				//��װ����ϸ�ķ�ҳ��Ϣ���������ǲ�ѯ����������,����������ʾ��ҳ��
				PageInfo page = new PageInfo(emps,5);
				return Msg.success().add("pageInfo",page);
	}
	
}

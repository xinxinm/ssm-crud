package com.crud.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crud.bean.Employee;
import com.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	//查询所有员工
	public List<Employee> getALL() throws Exception {
		return employeeMapper.findEmpWithDept();
	}
	public void saveEmp(Employee employee) throws Exception {
		employeeMapper.saveDepartmentInfo(employee);
		
	}
	public boolean selectNameIsRepeat(String empName) throws Exception {
		List<Employee> empcount = employeeMapper.findEmpNameIsRepeat(empName);
		int count = empcount.size();
		
		return count == 0;
		
	}
	public Employee getEmp(Integer id) throws Exception {
		Employee employee = employeeMapper.findEmpById(id);
		return employee;
	}
	public void updateEmp(Employee employee) throws Exception {
		employeeMapper.updateInfoById(employee);
		
	}
	public void deleteEmp(Integer id) throws Exception {
		employeeMapper.deleteById(id);
	}
	public void deleteBatch(List<Integer> ids) throws Exception {
		employeeMapper.deleteIds(ids);
		
	}

}

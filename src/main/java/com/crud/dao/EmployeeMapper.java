package com.crud.dao;

import com.crud.bean.Employee;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    
    
    public List<Employee> findEmpWithDept() throws Exception;
    
    public void updateEmpData(Employee employee) throws Exception;

    public Employee selectByPrimaryKeyWithDepartment(Integer empId) throws Exception;

    public void saveDepartmentInfo(Employee employee) throws Exception;
    
    public List<Employee> findEmpNameIsRepeat(String empName) throws Exception;

    public Employee findEmpById(Integer id) throws Exception;
    
    public void updateInfoById(Employee employee) throws Exception;
    
    public void deleteById(Integer id) throws Exception;

    public void deleteIds(List<Integer> del_ids) throws Exception;
}
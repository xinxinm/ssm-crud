package com.crud.dao;

import com.crud.bean.Department;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DepartmentMapper {
	public List<Department> findDepartmentInfo();

}





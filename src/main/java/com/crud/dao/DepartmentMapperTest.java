package com.crud.dao;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.crud.bean.Department;

public class DepartmentMapperTest {
	private ApplicationContext applicationContext;
	@Before
	public void setUp() throws Exception {
		applicationContext = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
	}

	@Test
	public void testFindDepartmentInfo() {
		DepartmentMapper departmentMapper = applicationContext.getBean(DepartmentMapper.class);
		List<Department> list = departmentMapper.findDepartmentInfo();
		System.out.println(list);
	}

}

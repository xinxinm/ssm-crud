package com.crud.dao;

import java.util.UUID;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.crud.bean.Employee;

public class EmployeeMapperTest {
	ApplicationContext applicationContext;
	@Before
	public void setUp() throws Exception {
		applicationContext = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
	}

	@Test
	public void testInsert() throws Exception {
		EmployeeMapper employeeMapper = applicationContext.getBean(EmployeeMapper.class);
				for(int i=0;i<=1000;i++)
				{
					String name = UUID.randomUUID().toString().substring(1, 6);
					Employee e = new Employee();
					e.setEmpName(name);
					if(i%2==0)
					{
						e.setGender("M");
					}else {
						e.setGender("F");
					}
					
					if(i%2==0)
					{
						e.setdId(1);
					}else{
						e.setdId(2);
					}
					e.setEmail("906055sa@qq.com");
					employeeMapper.updateEmpData(e);
				}
			
	}

}

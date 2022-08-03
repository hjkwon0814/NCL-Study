package com.test.testapp;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.jdbc.SqlConfig.TransactionMode;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.client.match.ContentRequestMatchers;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import com.test.VO.UserVO;
import com.test.service.UserService;

@WebAppConfiguration
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/appServlet/*.xml",
		"file:src/main/webapp/WEB-INF/spring/root-context.xml" })
class HomeControllerTest {

	@Autowired
	private WebApplicationContext context;

	@Autowired
	private UserService userService;

	private MockMvc mockMvc;
	
	private UserVO testUserVO;
	
	private UserVO testUserVOActual;
	
	private List<UserVO> userVOList;

	@BeforeEach
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.context).alwaysDo(print()).build();
		this.testUserVO = new UserVO();
	}

	@Test
	public void HomeTest() throws Exception {
		this.mockMvc.perform(get("/").characterEncoding("UTF-8").content("hjk")).andExpect(status().isOk())
				.andExpect(model().attributeExists("serverTime", "HomeUsersList"));
	}
	
	@Test
	@Transactional
	public void insertUserVO() throws Exception {
		testUserVO.setName("권혁진");
		testUserVO.setAge(28);
		
		userService.insertUserVO(testUserVO);
		userVOList = userService.getUserVO_ByName(testUserVO.getName());
		
		assertEquals("권혁진", userVOList.get(0).getName());
	}
	
	@Test
	@Transactional
	public void insertUserVO2() throws Exception {
		testUserVO.setName("권혁진");
		testUserVO.setAge(28);
		
		userService.insertUserVO(testUserVO);
		userVOList = userService.getUserVO_ByName(testUserVO.getName());
		
		assertEquals("권혁진", userVOList.get(0).getName());
	}

}

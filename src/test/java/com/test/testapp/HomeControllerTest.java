package com.test.testapp;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import com.test.VO.UserVO;
import com.test.dao.UserDao;
import com.test.service.UserService;

@WebAppConfiguration
@ExtendWith(MockitoExtension.class)
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/appServlet/*.xml",
		"file:src/main/webapp/WEB-INF/spring/root-context.xml" })
@TestMethodOrder(MethodOrderer.class)
class HomeControllerTest {

	@Autowired
	private WebApplicationContext context;

	@Mock
	private UserDao userDao;

	@InjectMocks
	private UserService userService;

	@Autowired
	private UserService userService2;

	private MockMvc mockMvc;

	private UserVO testUserVO;

	private List<UserVO> userVOList;

	private List<UserVO> mockUserVoList;

	@BeforeEach
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.context).alwaysDo(print()).build();
		this.testUserVO = new UserVO();
		this.userVOList = new ArrayList();
	}

	@Test
	@Order(1)
	public void HomeTest() throws Exception {
		this.mockMvc.perform(get("/").characterEncoding("UTF-8").content("hjk")).andExpect(status().isOk())
				.andExpect(model().attributeExists("serverTime", "HomeUsersList"));
	}

	@Test
	@Transactional
	@Order(3)
	public void insertUserVO() throws Exception {
		
		testUserVO.setName("권혁진");
		testUserVO.setAge(28);

		userService2.insertUserVO(testUserVO);
		userVOList = userService2.getUserVO_ByName(testUserVO.getName());

		assertEquals("권혁진", userVOList.get(0).getName());

	}

	@Test
	@Order(2)
	public void insertUserVO2() throws Exception {
		testUserVO.setName("권혁진");
		testUserVO.setAge(28);

		userVOList.add(testUserVO);

		Mockito.when(userService.getUserVO()).thenReturn(userVOList);

		mockUserVoList = userService.getUserVO();

		assertEquals("권혁진", mockUserVoList.get(0).getName());
	}

}

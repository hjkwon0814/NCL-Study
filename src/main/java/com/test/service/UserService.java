package com.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.VO.UserVO;
import com.test.dao.UserDao;

@Service
public class UserService {
	
	@Autowired
	private UserDao userDao;

	
	public List<UserVO> getUserVO() {
			
		return userDao.getUserVO();
		
	}
	
	
	public Integer updateUserVO(UserVO userVO, String name) {
		return userDao.updateUserVO(userVO, name);
	}
	
	
	
	public Integer insertUserVO(UserVO userVO) {
		return userDao.setUserVO(userVO);
	}
	
	public List<UserVO> getUserVO_ByName(String name) {
		return userDao.getUserVO_ByName(name);
	}
	
}

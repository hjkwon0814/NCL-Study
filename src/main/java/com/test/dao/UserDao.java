package com.test.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.test.VO.UserVO;

@Repository("userDao")
public class UserDao {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public List<UserVO> getUserVO() {
		String sqlstatement = "select * from testuser";

		return jdbcTemplate.query(sqlstatement, new RowMapper<UserVO>() {

			@Override
			public UserVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				UserVO userVO = new UserVO();

				userVO.setName(rs.getString("이름"));
				userVO.setAge(rs.getInt("나이"));

				return userVO;
			}

		});
	}
	
	public Integer updateUserVO(UserVO userVO, String name) {
		
		String sqlstatement = "update testuser set 이름=? where 이름=?";
		
		return jdbcTemplate.update(sqlstatement, name ,userVO.getName());
	}
	

}

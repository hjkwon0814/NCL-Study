package com.test.testapp;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;
import java.util.Locale;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.test.VO.UserVO;
import com.test.service.UserService;

@Controller
public class UserController {
	
	
	@RequestMapping(value = "/abc", method = RequestMethod.GET)
	public String Call_Open_Api(Model model) {
		
		/*
		 * BufferedReader br = null;
		 * 
		 * 
		 * try { String Url = "http://apis.data.go.kr/3160000/guroPm25DvcInfoSvc"; URL
		 * url = new URL(Url); try { HttpsURLConnection connection =
		 * (HttpsURLConnection) url.openConnection();
		 * connection.setRequestMethod("GET"); br = new BufferedReader(new
		 * InputStreamReader(connection.getInputStream(), "UTF-8")); String result = "";
		 * String line = ""; while((line = br.readLine()) != null) { result = result +
		 * line + "\n"; } } catch (IOException e) { System.out.println(e.getMessage());
		 * } } catch (MalformedURLException e) { System.out.println(e.getMessage()); }
		 */
		
		return "abc";
	}
}

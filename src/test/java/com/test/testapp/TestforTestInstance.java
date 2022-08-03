package com.test.testapp;

import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.TestMethodOrder;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@TestMethodOrder(org.junit.jupiter.api.MethodOrderer.OrderAnnotation.class)
public class TestforTestInstance {
	
	Integer number = 3;
	
	@Test
	@Order(1)
	public void add1() {
		number++;
		System.out.println("number = " + number);
		System.out.println(this);
	}
	
	@Test
	@Order(2)
	public void add2() {
		number = number * 2;
		System.out.println("number = " + number);
		System.out.println(this);
	}
	
}

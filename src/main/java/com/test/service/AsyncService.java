package com.test.service;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class AsyncService {
	
	@Async("customAsyncExecutor")
	public void call() {
		System.out.println("async Test");
	}
	
}

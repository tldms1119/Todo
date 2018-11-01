package edu.iot.common.service;

import java.util.Map;

import edu.iot.common.model.Todo;

public interface TodoService {
	
	Map<String, Object> getPage(int page, String orderBy) throws Exception;
	
	public void create(Todo todo) throws Exception;
	
	public Todo findById(long todoId) throws Exception;
	
	public void update(Todo todo) throws Exception;
	
	public void delete(Todo todo) throws Exception;
	
	public void checking(Todo todo) throws Exception;

}

package edu.iot.common.dao;

import edu.iot.common.model.Todo;

public interface TodoDao extends CrudDao<Todo, Long> {

	public void checking(Todo todo) throws Exception;
	
}

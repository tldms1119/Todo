package edu.iot.common.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.iot.common.dao.TodoDao;
import edu.iot.common.model.Pagination;
import edu.iot.common.model.Todo;

@Service
public class TodoServiceImpl implements TodoService {
	
	@Autowired
	TodoDao dao;

	@Override
	public Map<String, Object> getPage(int page, String orderBy) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		int total = dao.count();
		Pagination pagination = new Pagination(page, total);
		
		// mapper로 전달될 map
		Map<String, Object> pageMap = pagination.getPageMap();
		pageMap.put("orderBy", orderBy);
		
		// Pagination을 위해 모델 객체에 담을 map(총 리스트 개수, 총 페이지 수, 현재 페이지 등등의 정보 담고 있음)
		map.put("pagination", pagination);
		map.put("list", dao.getPage(pageMap));
		return map;
	}

	@Override
	public void create(Todo todo) throws Exception {
		dao.insert(todo);
	}

	@Override
	public Todo findById(long todoId) throws Exception {
		Todo todo = dao.findById(todoId);
		return todo;
	}

	@Override
	public void update(Todo todo) throws Exception {
		dao.update(todo);
	}

	@Override
	public void delete(Todo todo) throws Exception {
		dao.delete(todo.getToDoId());
	}

	@Override
	public void checking(Todo todo) throws Exception {
		dao.checking(todo);
	}

}

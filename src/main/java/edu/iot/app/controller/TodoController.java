package edu.iot.app.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.iot.common.model.Todo;
import edu.iot.common.service.TodoService;

@Controller
@RequestMapping("/list")
public class TodoController {

	@Autowired
	TodoService service;

	@RequestMapping("/showList")
	public void list(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "orderBy", defaultValue = "deadLine") String orderBy, Model model) throws Exception {
		model.addAttribute("today", getToday());
		model.addAllAttributes(service.getPage(page, orderBy));
		model.addAttribute("orderBy", orderBy);
	}

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public void createForm(Todo todo) {

	}

	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String createSubmit(@Valid Todo todo, BindingResult result) throws Exception {
		System.out.println(todo.toString());
		if (result.hasErrors()) {
			return "list/create";
		}
		service.create(todo);
		return "redirect:showList";
	}

	@RequestMapping(value = "/view/{toDoId}", method = RequestMethod.GET)
	public String view(@PathVariable long toDoId, Model model) throws Exception {
		Todo todo = service.findById(toDoId);
		model.addAttribute("todo", todo);
		return "list/view";
	}

	@RequestMapping(value = "/edit/{toDoId}", method = RequestMethod.GET)
	public String editForm(@PathVariable long toDoId, Model model) throws Exception {
		Todo todo = service.findById(toDoId);
		model.addAttribute("todo", todo);
		return "list/edit";
	}

	@RequestMapping(value = "/edit/{toDoId}", method = RequestMethod.POST)
	public String editSubmit(@Valid Todo todo, BindingResult result, @RequestParam("page") int page) throws Exception {
		if (result.hasErrors())
			return "list/edit";
		service.update(todo);

		return "redirect:/list/view/" + todo.getToDoId() + "?page=" + page;
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET, produces = "text/plain; charset=utf8")
	@ResponseBody
	public String delete(Todo todo) {
		try {
			service.delete(todo);
			return "ok";
		} catch (Exception e) {
			return e.getMessage();
		}
	}

	@RequestMapping(value = "/checking", method = RequestMethod.GET, produces = "text/plain; charset=utf8")
	@ResponseBody
	public String checking(Todo todo) {
		try {
			service.checking(todo);
			return "ok";
		} catch (Exception e) {
			return e.getMessage();
		}
	}

	public static String getToday() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(date);

		return today;
	}

}

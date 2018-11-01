<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="context" value="${ pageContext.request.contextPath }" scope="request"/>
<script src="${ context }/resources/bower_components/tinymce/tinymce.min.js"></script>
<script>
$(function() {
	tinymce.init({
		selector : 'textarea',
		height: 400
	});
});
</script>

<div class="container mt-3">
	<div class="col-md-8 offset-md-2">
		<h2 class="my-5"><i class="far fa-edit"></i> Edit</h2>
		
		<form:form commandName="todo">
			<form:hidden path="toDoId" vlaue="${todo.toDoId}"/>
			<div class="md-form">
				<label for="title">Title</label>
				<form:input path="title" class="form-control" />
				<form:errors path="title" cssClass="error" delimiter="div"/>
			</div>

			<div class="md-form">
				<label for="content">Content</label>
				<form:textarea path="content" class="form-control"/>
				<form:errors path="content" cssClass="error" delimiter="div"/>
			</div>

			<label for="priority">Priority </label>
			<form:select path="priority">
				<form:option value="1">1</form:option>
				<form:option value="2">2</form:option>
				<form:option value="3">3</form:option>
				<form:option value="4">4</form:option>
				<form:option value="5">5</form:option>
			</form:select>

			<br><br>
			
			<label for="deadLine">Dead Line </label> 
			<form:input type="date" path="deadLine"/>
			<p class="text-secondary">(마감일자를 따로 선택하지 않으시면 오늘 할일로 인식해 오늘 날짜로 마감일이 지정됩니다)</p>
			
			<hr>

			<div class="text-center">
				<a href="../view/${ todo.toDoId }?page=${ param.page }" class="btn btn-outline-primary waves-effect"> <i
					class="fas fa-undo"></i> Back
				</a>

				<button type="submit" class="btn btn-outline-secondary waves-effect">
					<i class="fas fa-edit"></i> OK
				</button>
			</div>
		</form:form>
		
	</div>
</div>
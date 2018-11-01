<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="context" value="${ pageContext.request.contextPath }" scope="request"/>

<script>
$(function(){
	$('.delete-btn').click(function(e){
		e.preventDefault();
		var result = confirm('할 일을 삭제할까요?');
		if(!result) return;
		
		var toDoId = $(this).data('target');
		var url = '../delete';
		var params = {
				toDoId : toDoId
		};
		
		$.get(url, params, function(data){
			if(data == 'ok'){
				location = '../showList';
			} else {
				alert('delete fail' + data);
			}
		});
	});
});
</script>
<div class="container mt-3">
	<div class="col-md-8 offset-md-2">
		<h2 class="my-5"><i class="far fa-file-alt"></i> View</h2>
		<div>
			<label>Todo ID</label>
			<p class="font-weight-bold">${ todo.toDoId }</p>
		</div>
		<div>
			<label>Title</label>
			<p class="font-weight-bold">${ todo.title }</p>
		</div>
		<div>
			<label>Priority</label>
			<p class="font-weight-bold">${ todo.priority }</p>
		</div>
		<div>
			<label>Dead Line</label>
			<p class="font-weight-bold"><fmt:formatDate value="${ todo.deadLine }"
				pattern="yyyy-MM-dd" /></p>
		</div>
		<div>
			<div class="font-weight-bold float-left">
				<label>Content</label>
			</div>
			<div class="font-weight-bold float-right">
				<fmt:formatDate value="${ todo.regDate }"
				pattern="yyyy-MM-dd" />
			</div>
		</div><br><hr>
		
		<div>
			${ todo.content }
		</div>
	
		<hr>
		<div class="text-center">
			<a href="../showList?page=${ param.page }" 
				class="btn btn-outline-primary waves-effect"> <i
				class="fas fa-undo"></i>Back
			</a>
			<a href="../edit/${ todo.toDoId }?page=${ param.page }" 
				class="btn btn-outline-secondary waves-effect"> 
				<i class="fas fa-edit"></i>Edit
			</a>
			<a href="" 
				class="delete-btn btn btn-outline-danger waves-effect"
				data-target="${ todo.toDoId }"> 
				<i class="fas fa-trash-alt"></i>Delete
			</a>
		</div>
	</div>
</div>
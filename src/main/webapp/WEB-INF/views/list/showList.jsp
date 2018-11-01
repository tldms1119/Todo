<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="context" value="${ pageContext.request.contextPath }"></c:set>
<script>
$(function(){
	$('.delete-btn').click(function(e){
		e.preventDefault();
		var result = confirm('할 일을 삭제할까요?');
		if(!result) return;
		
		var toDoId = $(this).data('target');
		var url = 'delete';
		var params = {
				toDoId : toDoId
		};
		
		$.get(url, params, function(data){
			if(data == 'ok'){
				location = 'showList';
			} else {
				alert('delete fail' + data);
			}
		});
	});
	
	$('.check').click(function(){
		var result = $(this).prop('checked');
		var checked;
		var toDoId = $(this).data('target');
		if(result) {checked = 1;}
		else {checked = 0;}
		var tr = $(this).closest("tr");
		var params = {
				toDoId : toDoId,
				checked : checked
		}
		if(result){
			$.get('checking', params, function(data){
				if(data == 'ok'){
					alert('완료 처리 되었습니다');
				}
			});
			tr.children('.title').append('<i class="fas fa-check text-success"></i>');
			tr.find('.edit').remove();
		} else {
			$.get('checking', params, function(data){
				if(data == 'ok'){
					alert('완료 해제 처리 되었습니다');
				}
			});
			tr.children('.title').find('i').remove();
			tr.find('.icon').append(`<a class="edit" 
									href="edit/${ item.toDoId }?page=${ pagination.page }">
									<i class="far fa-edit"></i></a>`);
		}
	});
	
	$('#orderBy').change(function(){
		var orderBy = $('#orderBy').val();
		var url = '${ context }/list/showList?orderBy=' + orderBy;
		location = url;
	});
});
</script>
<div class="container mt-3">
	<div class="col-md-10 offset-md-1">
		<h3 class="font-weight-bold">
			<i class="fas fa-list"></i> To Do List
		</h3>
		<hr>

		<div class="float-left">
			<form action="showList">
				<select id="orderBy" name="orderBy">
					<option value="deadLine"
						<c:if test="${orderBy=='deadLine'}">selected</c:if>>Dead Line</option>
					<option value="priority"
						<c:if test="${orderBy=='priority'}">selected</c:if>>Priority</option>
				</select>
			</form>
		</div>

		<div class="float-right mb-2">
			<a href="create"> <i class="fas fa-plus"></i> 추가
			</a>
		</div>

		<table class="table table-striped text-center">
			<tr>
				<th>No</th>
				<th>Title</th>
				<th>Priority</th>
				<th>DeadLine</th>
				<th>Complete</th>
				<th>Button</th>
			</tr>
			<c:forEach var="item" items="${ list }" varStatus="status">
				<fmt:formatDate var="deadLine" value="${ item.deadLine }"
					pattern="yyyy-MM-dd" scope="request" />
				<fmt:formatDate var="regDate" value="${ item.regDate }"
					pattern="yyyy-MM-dd" scope="request" />
				<tr>
					<td>${ item.toDoId }</td>
					<td class=title>
						<a href="view/${ item.toDoId }?page=${ pagination.page }"
							class="<c:if test='${ deadLine < today }'>text-muted</c:if>">
							${item.title}
						</a>
						<c:if test="${item.checked == 1}">
							<i class="fas fa-check text-success"></i>
						</c:if> 
						<iot:deadline-over date="${deadLine}" /></td>
					<td>${ item.priority }</td>
					<td>${ deadLine }</td>
					<td><input type="checkbox" class="check" name="check" 
						data-target="${ item.toDoId }"
						<c:if test="${item.checked == 1}">checked</c:if>
						<c:if test="${ deadLine < today }">disabled</c:if>>
					</td>
					<td class="icon">
						<c:if test="${item.checked == 0}">
							<a class="edit" href="edit/${ item.toDoId }?page=${ pagination.page }"> 
								<i class="far fa-edit"></i>
							</a>
						</c:if> 
						<a href="" class="delete-btn" data-target="${ item.toDoId }"> 
							<i class="far fa-trash-alt"></i>
						</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<iot:pagination />
	</div>
</div>


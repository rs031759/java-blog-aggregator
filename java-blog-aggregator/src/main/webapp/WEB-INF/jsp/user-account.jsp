<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/taglib.jsp"%>

<!DOCTYPE html>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  
<div class="container">
	<!-- Button trigger modal -->
	<button type="button" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModal">New Blog</button>

<br/>
<br/>

	<form:form commandName="blog" cssClass="form-horizontal blogForm">
		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">New Blog</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="name" class="col-sm-2 control-label">Name:</label>
							<div class="col-sm-10">
								<form:input path="name" cssClass="form-control" />
								<form:errors path="name" />
							</div>
						</div>

						<div class="form-group">
							<label for="name" class="col-sm-2 control-label">URL:</label>
							<div class="col-sm-10">
								<form:input path="url" cssClass="form-control" />
								<form:errors path="url" />
							</div>
						</div>

						<div class="model-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
							<input type="submit" class="btn bnt-primary" value="Save" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</form:form>
	
<script type="text/javascript">
$(document).ready(function() {
    
	 
	   $(".triggerRemove").click(function(e) {
		    e.preventDefault();
		    $("modalRemove.removeBtn").attr("href", $(this).attr("href"));
		    $("modalRemove").modal();
	   });
	   
	   $(".blogForm").validate(
				{
					rules: {
						name: {
							required : true,
							minlength : 1
						},
						url: {
							required : true,
							url: true
						}
					},
					highlight: function(element) {
						$(element).closest('.form-group').removeClass('has-success').addClass('has-error');
					},
					unhighlight: function(element) {
						$(element).closest('.form-group').removeClass('has-error').addClass('has-success');
					}
				}
			);
	   
	    
});


</script>	


	<ul class="nav nav-tabs">
		<c:forEach items="${user.blogs}" var="blog">
			<li><a href="#blog_${blog.id}" data-toggle="tab">${blog.name}</a></li>
		</c:forEach>
	</ul>

	<div class="tab-content">
		<c:forEach items="${user.blogs}" var="blog">
			<div class="tab-pane" id="blog_${blog.id}">
				<h1>${blog.name }</h1>
				
				
			<!-- To remove blogs -->
				<p>
					<a href="<spring:url value="blog/remove/${blog.id}.html"/>" class="btn btn-danger">remove blog</a>
					${blog.url}</p>
					
				<table class="table table-bordered table-hover table-striped">
					<thead>
						<tr>
							<th>date</th>
							<th>item</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${blog.items}" var="item">
							<tr>
								<td><c:out value="${item.publishedDate}" /></td>
								
								<td>
									<strong>
										<a href="<c:out value="${item.link}" />" target="_blank">
											<c:out value="${item.title }"/>
										</a>
									</strong>
									<br/>
									${item.description }
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:forEach>
	</div>
</div>

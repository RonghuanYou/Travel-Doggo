<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
	<link rel="stylesheet" href="/css/main.css" />
	<meta charset="UTF-8">
	<title>City</title>
</head>

<body>
	<div class="bg-dark d-flex align-items-center justify-content-around nav-color border-bottom">
		<h2 class="title-font">Travel Doggo</h2>

		<div class="d-flex align-items-center">
			<a href="/dashboard" class="nav-color">Dashboard</a>
			<a href="/traveldoggos" class="nav-color mr-auto p-2">Create/View City</a>
			<a href="/traveldoggos/wishlist" class="nav-color">Travel Wish List</a>
			<a href="/logout" class="nav-color mr-auto p-2">Log Out</a>
			<p class="mt-3"><c:out value="${ user.name }"/>, <c:out value="${ user.location }"/></p>
		</div>
	</div>
	
	
	<div class="container">
		<div class="d-flex justify-content-between mt-3">
			<div>
				<h4><c:out value="${ city.name }"/></h4>
	
				<p>Review: <c:out value="${ city.comment }"/> </p>
				<p>Rating: <c:out value="${ city.rating }"/></p>
				
				<p>Visit Date: <fmt:formatDate type="date" value="${ city.date }"/> </p>
				<p>Created by: <c:out value="${ city.creator.name }"/></p>
		 		<p>Created At: <c:out value="${ city.createdAt }"/></p>
			</div>
			
			<div>
				<c:if test="${ !city.comments.isEmpty() }">
					<h4>More Reviews:</h4>
					<c:forEach var="comment" items="${ city.comments }">
						<p>
							Review From <c:out value="${ comment.visitor.name }"/> <br />
							<c:out value="${comment.review}"></c:out><br />	
							---------------------------------------------------
						</p>									
					</c:forEach>
				</c:if>
				
				
				<h6>New Review:</h6>
				<form:form action="/comment/create" method="POST" modelAttribute="commentObj">
					<form:input value="${ user.id }" path="visitor" type="hidden"/>
					<form:input value="${ city.id }" path="city" type="hidden"/>
					
					<p>
						<form:input path="review" type="textarea"/>
					</p>
					<button class='btn btn-bg'>Submit</button>
				</form:form>
			</div>
		</div>


		
	</div>
</body>
</html>
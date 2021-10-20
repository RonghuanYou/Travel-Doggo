<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
	<link rel="stylesheet" href="/css/main.css" />
	
	<meta charset="UTF-8">
	<title>Travel Doggo</title>
</head>
<body>
	<div class="bg-dark d-flex align-items-center justify-content-around nav-color border-bottom">
		<h2 class="title-font">Travel Doggo</h2>

		<div class="d-flex align-items-center">
			<a href="/dashboard" class="nav-color">Dashboard</a>
			<a href="/logout" class="nav-color mr-auto p-2">Log Out</a>
			<p class="mt-3"><c:out value="${ user.name }"/>, <c:out value="${ user.location }"/></p>
		</div>
	</div>
	<div class="container">
		<h4 class="mt-3">Edit City Information</h4>
		<form:form action="/traveldoggos/${ cityObj.id }/edit" method="POST" modelAttribute="cityObj" class="mt-3">
	        <input type="hidden" name="_method" value="put">
			<form:input path="creator" value="${ user.id }" type="hidden"/>
			
			<p class="input-group mb-3 input-width">
				<span class="input-group-text">City Name</span>
				<form:input path="name"  class="grey-bg form-control"/> 				
			</p>
			<p><form:errors path="name" class="alert alert-danger"/></p>
			
			
			
			<p class="input-group mb-3 input-width">
				<span class="input-group-text">Date</span>
				<form:input path="date" type="date" class="form-control"/>
			</p>
			<p><form:errors path="date" class="alert alert-danger"/></p>
					
					
			<p class="input-group mb-3 input-width">
				<span class="input-group-text">Rating(1-100)</span>
				<form:input path="rating" type="number" class="form-control"/> 
			</p>
			<p><form:errors path="rating" class="alert alert-danger"/></p>	
			
			
			<p class="input-group mb-3 input-width">
				<span class="input-group-text">Comment</span>
				<form:input path="comment" class="form-control"/>
			</p>
			<p><form:errors path="comment" class="alert alert-danger"/></p>
			
			
			<button class='btn btn-bg'>Update</button>
		</form:form>
	</div>
	
</body>
</html>
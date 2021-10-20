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
	<title>Travel Doggo</title>
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
	<div class="container mt-3">
		<div class="ml-6">
			<h4>Your Travel WishList:</h4>
			
			<c:forEach var="city" items="${ user.addingCities }">
				<ul>
					<li><c:out value="${ city.name }"/></li>
				</ul>
			</c:forEach>		
		</div>
	</div>
</body>
</html>
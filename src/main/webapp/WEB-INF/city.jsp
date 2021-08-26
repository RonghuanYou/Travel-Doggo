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
	<link rel="stylesheet" href="css/main.css" />
	<script src="js/city.js"></script>
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
	<div class="container mt-3">
	    <!--The div element for the map -->
	    <div id="map"></div>		
			
							
		<div>
			<h4 class="mt-3">Cities You have visited</h4>
			<table class="table ctable-color table-hover table-dark">
				<thead>
					<tr>
						<th>City</th>
						<th>Visit Date</th>
						<th>Rating(1-100)</th>
						<th>Action</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="city" items="${cities}">
						<tr>
							<td><c:out value="${ city.name }"/></td>
							<td><fmt:formatDate type="date" value="${ city.date }"/></td>
							<td><c:out value="${ city.rating }"/></td>
							<td><a href="/traveldoggos/${ city.id }/updatecity">Edit</a> | <a href="/traveldoggos/${ city.id }/delete">Delete</a></td>
						</tr>					
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		
		<h4>Create City You Visited</h4>
		

		<form:form action="/traveldoggos" method="POST" modelAttribute="cityObj">
			<p>
				City Name:
				<form:input path="name"/>
			</p>
			
			<p>
				Date:
				<form:input path="date" type="date"/>
			</p>
			
			<p>
				Comment:
				<form:input path="comment"/>
			</p>
			<p>
				Rating(1-100):
				<form:input path="rating" type="number"/>
			</p>
			<button>Submit</button>
		</form:form>

	</div>
	
	

	<!-- Async script executes immediately and must be after any DOM elements used in callback. -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCD9JjusaiGFfP84QWAVmVZKemsILtvM2Q&callback=initMap&libraries=&v=weekly" async></script>
</body>
</html>
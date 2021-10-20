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
	<link rel="stylesheet" href="/css/main.css"/>
	<script src="js/city.js"></script>
	<meta charset="UTF-8">
	<title>Travel Doggo</title>
</head>
<body>
	<div class="bg-dark d-flex align-items-center justify-content-around nav-color border-bottom">
		<h2 class="title-font">Travel Doggo</h2>

		<div class="d-flex align-items-center">
			<a href="/dashboard" class="nav-color mr-auto p-2">Dashboard</a>
			<a href="/traveldoggos/wishlist" class="nav-color">Travel Wish List</a>
			<a href="/logout" class="nav-color mr-auto p-2">Log Out</a>
			<p class="mt-3"><c:out value="${ user.name }"/>, <c:out value="${ user.location }"/></p>
		</div>
	</div>
	<div class="container mt-3">
	    <!--The div element for the map -->
	    <div id="map"></div>		
									
		<div>
			<c:if test="${ !cities.isEmpty() }">
			
				<h4 class="mt-3">Cities You've Visited</h4>
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
								<td><a href="/traveldoggos/${ city.id }/city" class="link-color"><c:out value="${ city.name }"/></a></td>
								<td><fmt:formatDate type="date" value="${ city.date }"/></td>
								<td><c:out value="${ city.rating }"/></td>
								<c:if test="${ city.creator.id == user_id }">
									<td>
										<a href="/traveldoggos/${ city.id}/edit" class="link-color">Edit</a> | 
										<a href="/traveldoggos/${ city.id }/delete" class="link-color">Delete</a>	
										<c:if test="${ city.loggingUsers.contains(user) }" >
											| <a href="/traveldoggos/${ city.id }/remove" class="link-color">Remove From WishList</a>
										</c:if>	
										<c:if test="${ !city.loggingUsers.contains(user) }">
											| <a href="/traveldoggos/${ city.id }/add" class="link-color">Add to WishList</a>
										</c:if>	
									</td>
								</c:if>
							
								
								<c:if test="${ city.creator.id != user_id}">
									<td>
										<c:if test="${ city.loggingUsers.contains(user) }">
											<a href="/traveldoggos/${ city.id }/remove" class="link-color">Remove From WishList</a>
										</c:if>
										
										<c:if test="${ !city.loggingUsers.contains(user) }">
											<a href="/traveldoggos/${ city.id }/add" class="link-color">Add to WishList</a>
										</c:if>
									</td>							
								</c:if>
							</tr>					
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
		
		
		<h4 class="mt-3">Enter City You've Visited</h4>
		<form:form action="/traveldoggos" method="POST" modelAttribute="cityObj">	
			<form:input path="creator" value="${ user.id }" type="hidden"/>
			<p class="input-group mb-3 input-width">
				<span class="input-group-text">City Name</span>
				<form:input path="name" class="grey-bg form-control"/>
			</p>
			<p><form:errors path="name" class="alert alert-danger"/></p>
			
			
			<p class="input-group mb-3 input-width">
				<span class="input-group-text">Date Visit</span>
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
			
			<button class='btn btn-bg'>Submit</button>
		</form:form>
	</div>
	
    <!-- <script src="https://maps.googleapis.com/maps/api/js?key={USE_YOUR_API_KEY}&callback=initMap&libraries=&v=weekly" async></script>-->
</body>
</html>
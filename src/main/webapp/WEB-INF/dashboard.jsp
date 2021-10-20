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
	<script src="js/site.js"></script>
	<script type="text/javascript" src="js/echarts.js"></script>
	<script type="text/javascript" src="js/echarts.min.js"></script>
	
	<meta charset="UTF-8">
	<title>Dashboard</title>
</head>
<body>
	<div class="bg-dark d-flex align-items-center justify-content-around nav-color border-bottom">
		<h2 class="title-font">Travel Doggo</h2>
		<div class="mt-2">
			<form onsubmit="event.preventDefault(); getLocationInfo();">
				<p class="input-group mb-3 p-2">
				    <input type="text" placeholder="Search Location" oninput="setLocation(this);" class="form-control bg-color">
				    <button class="btn btn-bg">Search</button>
				</p>
			</form>
		</div>
		<div class="d-flex align-items-center">
			<a href="/traveldoggos" class="nav-color mr-auto p-2">Create/View City</a>
			<a href="/traveldoggos/wishlist" class="nav-color">Travel Wish List</a>
			<a href="/logout" class="nav-color mr-auto p-2">Log Out</a>
			<p class="mt-3"><c:out value="${ user.name }"/>, <c:out value="${ user.location }"/></p>
		</div>
	</div>
	
	<div class="container mt-3">
		<div class="d-flex justify-content-between">
			<div id="forecast" style="width: 750px;height:400px;"></div>		
			<div id="display_info" class="mt-3"></div>		
		</div>
		<div class="border-bottom mb-3"></div>
		<!-- DISPLAY AIR QUALITY GRAPH -->
		
		<div class="d-flex justify-content-between">
			<div id="main" style="height:400px;" class="col-9"></div>
			
			<div class="ml-3">
				AQI (Air Quality Index):</br>
				1 = Good </br> 2 = Fair </br>3 = Moderate </br> 4 = Poor</br> 5 = Very Poor
				<p id="aqi_result" style="color:#ffc107;"></p>
			</div>
		</div>
	</div>
</body>
</html>
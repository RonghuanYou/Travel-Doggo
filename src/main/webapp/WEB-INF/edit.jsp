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
	<link rel="stylesheet" href="css/main.css" />
	<meta charset="UTF-8">
	<title>Travel Doggo</title>
</head>
<body>
	<div class="container">
		<form:form action="/traveldoggos/${ cityObj.id }/edit" method="POST" modelAttribute="cityObj">
	        <input type="hidden" name="_method" value="put">
			<p>
				City Name:
				<form:input path="name"/>
				<form:errors path="name"/>
			</p>
			
			<p>
				Date:
				<form:input path="date" type="date"/>
				<form:errors path="date"/>
			</p>
			
			<p>
				Comment:
				<form:input path="comment"/>
				<form:errors path="comment"/>
			</p>
			<p>
				Rating(1-100):
				<form:input path="rating" type="number"/>
				<form:errors path="rating"/>
			</p>
			<button>Update</button>
		</form:form>
	</div>
</body>
</html>
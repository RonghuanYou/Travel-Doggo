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
	<meta charset="UTF-8">
	<title>Register-Login</title>
</head>

<body>
<div class="container mt-3">
        <div class="container p-5 border border-dark d-flex justify-content-between col-9">
			<div class="register p-3">
				<h4>Register</h4>
				<p class="alert alert-danger"><form:errors path="userObj.*"/></p>
				
				<form:form action="/registration" method="POST" modelAttribute="userObj">
					
					<p class="input-group mb-3">
                        <span class="input-group-text">Name</span>
				        <form:input path="name" class="form-control"/>
					</p>

					
					<p class="input-group mb-3">
	                    <span class="input-group-text">Email</span>
				        <form:input type="email" path="email" class="form-control"/>
					</p>
					
					
					<p class="input-group mb-3">
                        <span class="input-group-text">Location</span>
				        <form:input type="text" path="location" class="form-control"/>
					</p>
					
			
					<p class="input-group mb-3">
                        <span class="input-group-text">Password</span>
				        <form:input type="password" path="password" class="form-control"/>
					</p>
					
					<p class="input-group mb-3">
                        <span class="input-group-text">Password Confirmation</span>
				        <form:password path="passwordConfirmation" class="form-control"/>
				    </p>
					
                    <button class='btn btn-bg'>Register</button>
				</form:form>
			</div>
			
			<div class="login p-3">
				<h4>Login</h4>
				<!-- SHOW ERROR MESSAGES -->
	    		<p class="alert alert-danger"><c:out value="${ error }" /></p>
				<form action="/login" method="POST">
					<p class="input-group mb-3">
	                    <span class="input-group-text">Email</span>
						<input type="email" name="email" class="form-control"/>
					</p>
					
					<p class="input-group mb-3">
                        <span class="input-group-text">Password</span>
						<input type="password" name="password" class="form-control"/>
					</p>
					
                    <button class='btn btn-bg'>Login</button>
				</form>
			</div>
		</div>
		
	</div>
</body>
</html>
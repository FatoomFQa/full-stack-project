<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Chefs APP</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet" href="../css/myStyles.css">
<link rel="stylesheet" href="css/myStyles.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
	crossorigin="anonymous">

<link id="favIcon" rel="icon" type="image/svg"
	href="../images/chefs.svg">

</head>
<body>


	<nav class="navbar navbar-expand-lg navbar-light"
		style="background-color: #7d0633;">
		<div class="container-fluid">
			<a class="navbar-brand" href="${appName}"> <img id="logo"
				src="images/chefs.svg" width="30" height="24"
				class="d-inline-block align-top"> Chefs
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon custom-toggler"></i></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<security:authorize access="isAuthenticated()">
					<ul class="navbar-nav mr-auto">
						<li class="nav-item"><a class="nav-link"
							href="${appName}chefs/index">All Chefs</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${appName}recipe/index?first=All">All Recipes</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${appName}recipe/add">Add Recipe</a></li>
					</ul>
					<ul class="navbar-nav ml-auto">
						<li class="nav-item"><a class="nav-link"
							href="${appName}user/detail?email=<security:authentication property="principal.username"/>"><b>Welcome
									<security:authentication property="principal.username" />
							</b></a></li>
						<li class="nav-item"><a class="nav-link"
							href="${appName}logout">Logout</a></li>
					</ul>
				</security:authorize>

				<security:authorize access="!isAuthenticated()">
					<ul class="navbar-nav mr-auto">
						<li class="nav-item"><a class="nav-link"
							href="${appName}chefs/index">All Chefs</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${appName}recipe/index?first=All">All Recipes</a></li>
					</ul>
					<ul class="navbar-nav ml-auto">
						<li class="nav-item"><a class="nav-link"
							href="${appName}user/login">Login</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${appName}user/signup">Sign Up</a></li>
					</ul>
				</security:authorize>

			</div>
		</div>
	</nav>

	<c:if test="${addRecipeMessage != null}">
		<div class="alert alert-success fade show" role="alert">
			${addRecipeMessage}</div>
		<%
		session.removeAttribute("addRecipeMessage");
		%>
	</c:if>

	<c:if test="${addRatingMessage != null}">
		<div class="alert alert-success fade show" role="alert">
			${addRatingMessage}</div>
		<%
		session.removeAttribute("addRatingMessage");
		%>
	</c:if>

	<c:if test="${signupFailMessage != null}">
		<div class="alert alert-danger show" role="alert">
			${signupFailMessage}</div>
		<%
		session.removeAttribute("signupFailMessage");
		%>
	</c:if>

	<c:if test="${signupSuccessMessage != null}">
		<div class="alert alert-success fade show" role="alert">
			${signupSuccessMessage}</div>
		<%
		session.removeAttribute("signupSuccessMessage");
		%>
	</c:if>

	<c:if test="${downloadSuccssMessage != null}">
		<div class="alert alert-success fade show" role="alert">
			${downloadSuccssMessage}</div>
		<%
		session.removeAttribute("downloadSuccssMessage");
		%>
	</c:if>

	<c:if test="${downloadFailMessage != null}">
		<div class="alert alert-danger fade show" role="alert">
			${downloadFailMessage}</div>
		<%
		session.removeAttribute("downloadFailMessage");
		%>
	</c:if>


	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
		$('.fade').slideUp(5000);
	</script>

	<script src="https://code.jquery.com/jquery-3.5.1.js"
		integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
		crossorigin="anonymous"></script>
	<script src="../js/main.js" type="text/javascript"></script>
	<script src="js/main.js" type="text/javascript"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
		crossorigin="anonymous"></script>


</body>
</html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>


<jsp:include page="../shared/layout.jsp" />
<div class="container-fluid" style="height: 100vh;">
	<h1></h1>
	<div class="row">
		<div class="col-sm-2 filterNav">
			<p>Select the type of meal</p>
			<form action="${appName}recipe/index" method="get" id="recipeFilter">
				<div class="form-check">
					<input name="first" class="form-check-input" type="radio"
						value="All" id="All"> <label class="form-check-label"
						for="Arapic"> All</label>
				</div>
				<div class="form-check">
					<input name="first" class="form-check-input" type="radio"
						value="Soup" id="Soup"> <label class="form-check-label"
						for="Arapic"> Soup</label>
				</div>
				<div class="form-check">
					<input name="first" class="form-check-input" type="radio"
						value="Appetizer" id="Appetizer"> <label
						class="form-check-label" for="defaultCheck2"> Appetizer </label>
				</div>
				<div class="form-check">
					<input name="first" class="form-check-input" type="radio"
						value="Salad" id="Salad"> <label class="form-check-label"
						for="defaultCheck2"> Salad </label>
				</div>
				<div class="form-check">
					<input name="first" class="form-check-input" type="radio"
						value="Main Course" id="MainCourse"> <label
						class="form-check-label" for="defaultCheck2"> Main Course
					</label>
				</div>
				<div class="form-check">
					<input name="first" class="form-check-input" type="radio"
						value="Dessert" id="Dessert"> <label
						class="form-check-label" for="defaultCheck2"> Dessert </label>
				</div>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				<button id="submit" type="submit" class="btn btn-style2">Filter</button>
			</form>
		</div>
		<div class="col-sm-10">
			<div class="row row-cols-1 row-cols-md-3 g-4">
				<c:forEach items="${recipes}" var="recipe" varStatus="status">
					<div class="col" style="margin-top: 10px; width: 25%;">
						<div class="card h-100">
							<img src="${recipe.picture }" class="card-img-top" alt="...">
							<div class="card-body">

								<h5 class="card-title colorOne"
									style="text-transform: capitalize;">
									<a style="text-decoration: none; color: inherit;"
										href="${appName}recipe/detail?id=${recipe.id}">${recipe.name }</a>
								</h5>


								<p class="colorTwo">
									<strong>Servings: </strong>${recipe.servings}</p>

								<p class="colorTwo">
									<strong>Calories: </strong>${recipe.calories}
								</p>

								<p class="colorTwo">
									<strong>Allergy Warnings: </strong> ${recipe.allergyWarnings}
								</p>
								<small style="font-style: italic">Made By:
									${recipe.getUser().getFirstName()}
									${recipe.getUser().getLastName()}</small>
							</div>
							<div class="card-footer">
								<c:forEach var="i" begin="1" end="${rates[0][status.index]}"
									step="1">
									<i class="fa fa-star checked" id=i></i>
								</c:forEach>
								<c:forEach var="i" begin="1" end="${5-rates[0][status.index]}"
									step="1">
									<i class="fa fa-star unchecked" id=i></i>
								</c:forEach>
							</div>

							<security:authorize access="isAuthenticated()">

								<div class="card-footer">

									<c:set var="userId" value="${user.getUserId()}" />
									<c:set var="recipeUserId"
										value="${recipe.getUser().getUserId()}" />
									<c:set var="role" value="${user.getRole()}" />


									<input type="hidden" value="${user.getUserId()}">
									<c:if test='${userId eq recipeUserId}'>


										<a href="${appName}recipe/edit?id=${recipe.id}">
											<button class="btn btn-style">Edit</button>
										</a>
									</c:if>

									<c:if
										test='${(userId eq recipeUserId) || (role eq "ROLE_ADMIN")}'>
										<a href="${appName}recipe/delete?id=${recipe.id}">
											<button class="btn btn-style">Delete</button>
										</a>

									</c:if>

								</div>
							</security:authorize>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
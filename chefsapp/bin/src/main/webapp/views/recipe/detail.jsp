<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<jsp:include page="../shared/layout.jsp" />

<input type="hidden" name="id" value="${recipe.id}">


<div class="recipeContainer container">
	<div class="row">


		<div class="col" id="recipeDetailImg">
			<img alt="recipeImg" src="${ recipe.picture}" width="100%"
				height="600px">
			<div
				style="position: absolute; top: 90%; left: 50%; transform: translate(-50%, -50%);">
				<h1 id="recipeDetailName">${ recipe.name}</h1>
			</div>
		</div>

		<div class="w-100"></div>



		<div class="col info">
			<img
				src="https://i.pinimg.com/originals/fd/80/ec/fd80ecec48eba2a9adb76e4133905879.png"
				alt="cuisine" width="40px" height="40px"> <span>
				cuisine </span> ${recipe.cuisine}
		</div>

		<div class="col info ">

			<img src="https://static.thenounproject.com/png/7383-200.png"
				alt="cuisine" width="40px" height="40px"> <span>duration</span>
			${recipe.duration}
		</div>

		<div class="col info">
			<img
				src="https://i.pinimg.com/originals/fd/80/ec/fd80ecec48eba2a9adb76e4133905879.png"
				alt="cuisine" width="40px" height="40px"> <span>servings</span>
			${recipe.servings}
		</div>
		<div class="w-100"></div>

		<div class="col info">

			<img src="https://image.flaticon.com/icons/png/512/1349/1349981.png"
				alt="cuisine" width="40px" height="40px"> <span>calories</span>
			${recipe.calories}
		</div>

		<div class="col info ">

			<img
				src="https://cdn.iconscout.com/icon/free/png-256/warning-190-457484.png"
				alt="cuisine" width="40px" height="40px"> <span>allergy
				warnings</span> ${recipe.allergyWarnings}
		</div>

		<div class="col info">

			<img
				src="https://freeiconshop.com/wp-content/uploads/edd/food-outline.png"
				alt="cuisine" width="40px" height="40px"> <span>type</span>
			${recipe.type}
		</div>
		<div class="w-100"></div>

		<div class="col" id="recipeDescription">${recipe.description}</div>
		<div class="w-100"></div>


		<div class="col" id="ingredients">
			<h2>Ingredients</h2>

			<c:set var="ingredients" value="${recipe.ingredients}" />

			<c:set var="ing" value="${fn:split(ingredients, ',')}" />
			<ul>
				<c:forEach items="${ ing}" var="ingrediant">
					<li>${ ingrediant}</li>

				</c:forEach>
			</ul>

		</div>



		<div class="col" id="instructions">
			<h2>Instructions</h2>

			<c:set var="instructions" value="${recipe.instructions}" />

			<c:set var="inst" value="${fn:split(instructions, '^')}" />
			<ol>
				<c:forEach items="${ inst}" var="instruction">
					<li>${ instruction}</li>

				</c:forEach>
			</ol>
		</div>
		<div class="w-100"></div>

		<div class="w-25 h-100" style="margin: 0 auto;">
			<button id="shareRecipeButton" type="button"
				class="btn btn-outline-dark w-100">Share Recipe</button>
			<div id="shareUserDiv" style="display: none;">
				<div class="card text-center">
					<img src="${appName}recipe/detail/qrcode?id=${recipe.getId()}"
						width="100" height="100" class="card-img-top">
					<div class="card-body">
						<h5 class="card-title">QRCode</h5>
					</div>
					<div class="card-footer">
						<small class="text-muted"> <a
							href="${appName}recipe/detail/qrcode/download?id=${recipe.getId()}">
								<button class="btn btn-style" type="button">Download
									QRCode</button>
						</a>


						</small>
					</div>
				</div>
			</div>
		</div>
		<div class="w-100"></div>
		<security:authorize access="isAuthenticated()">

			<c:if test="${!flag}">

				<form id="addRating" action="${appName}recipe/detail" method="post">
					<div class="main form-group">
						<label>Rate the recipe:</label> <i class="fa fa-star checked"
							id="1"></i> <i class="fa fa-star unchecked" id="2"></i> <i
							class="fa fa-star unchecked" id="3"></i> <i
							class="fa fa-star unchecked" id="4"></i> <i
							class="fa fa-star unchecked" id="5"></i>
					</div>
					<div class="form-group">
						<label>Comment: </label> <input type="text" name="comment"
							class="form-control">

					</div>
					<input type="hidden" name="rating" value="1" id="rate"> <input
						type="hidden" name="recipe" value="${recipe.id}"> <input
						type="hidden" name="user" value="${currentUser}"> <input
						type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

					<button class="btn btn-style" id="submitRatingBtn" type="submit">Submit
						rating</button>
				</form>
			</c:if>
		</security:authorize>
		<div class="w-100"></div>

		<div class="col">

			<h4>
				<img src="https://image.flaticon.com/icons/png/512/1380/1380338.png"
					alt="cuisine" width="40px" height="40px">Comments:
			</h4>

			<c:forEach items="${ rates}" var="recipeRates">

				<p style="border-left: thin solid #f2a07b; padding-left: 5px;">
					<strong class="colorOne">${ recipeRates.getUser().getFirstName()}:
					</strong>${recipeRates.getComment()}</p>
			</c:forEach>
		</div>


	</div>
</div>

<script src="../js/rate.js" type="text/javascript"></script>
<script src="js/rate.js" type="text/javascript"></script>
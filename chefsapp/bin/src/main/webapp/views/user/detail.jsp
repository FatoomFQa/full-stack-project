<jsp:include page="../shared/layout.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<div id="userInfo" class="container"
	style="padding: 1%; margin-top: 5%;">
	<p id="title" class="h3" style="margin: 0%; margin-bottom: 2%;">Chef
		Details</p>
	<div class="container d-flex flex-row">
		<div class="w-25 h-100"
			style="margin-left: -1.5%; padding: 1%; padding-left: 2.75%;">
			<img id="userDetailImage" class="img-fluid img-thumbnail"
				src="${user.getPicture()}">
		</div>
		<div class="w-50 d-flex flex-column"
			style="margin-left: 2%; border-left: solid; border-left-color: lightgray; border-width: thin; padding-left: 2%;">
			<p class="detailP colorTwo">
				<i class="bi bi-person-fill"></i><span> <b>Name:</b>
					${user.getFirstName()} ${user.getLastName()}
				</span>
			</p>
			<p class="detailP colorTwo">
				<i class="bi bi-envelope"></i></i><span> <b>Email:</b>
					${user.getEmailAddress()}
				</span>
			</p>
			<p class="detailP colorTwo">
				<i class="bi bi-file-text"></i></i><span> <b>Number of added
						recipes:</b> ${count}
				</span>
			</p>
			<security:authorize access="isAuthenticated()">
				<c:if test="${flag}">
					<button id="editInfo" type="button" class="btn btn-style w-50 ">Edit
						Information</button>
				</c:if>
			</security:authorize>
		</div>
		<div class="w-25 h-100" style="margin: 2%;">
			<button class="btn btn-style w-100" id="shareUserButton"
				type="button">Share Chef</button>
			<div id="shareUserDiv" style="display: none;">
				<div class="card text-center">
					<img
						src="${appName}user/detail/qrcode?email=${user.getEmailAddress()}"
						class="card-img-top">
					<div class="card-body">
						<h5 class="card-title colorTwo">QRCode</h5>
					</div>
					<div class="card-footer colorTwo">
						<small class="text-muted"> <a
							href="${appName}user/detail/qrcode/download?email=${user.getEmailAddress()}">
								<button class="btn btn-style" type="button">Download
									QRCode</button>
						</a>
						</small>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:if test="${count != 0}">
		<p class="h5" style="margin-top: 2%; margin-bottom: 1%;">Recipes</p>
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
								<c:if test="${flag}">


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
	</c:if>

</div>

<security:authorize access="isAuthenticated()">
	<c:if test="${flag}">
		<div id="editUser" style="display: none;">
			<p class="h3 colorTwo">Edit Information</p>
			<form action="${appName}user/edit" method="post">
				<img class="img-fluid img-thumbnail" id="userProfileImageEdit"
					src="${user.getPicture()}">
				<div class="mb-3">
					<label class="form-label colorTwo">Picture URL</label> <input
						id="pictureUrlUserEdit" type="text" name="picture"
						class="form-control" value="${user.getPicture()}" required>
				</div>

				<div class="mb-3">
					<label class="form-label colorTwo">First Name</label> <input
						name="firstName" type="text" class="form-control"
						value="${user.getFirstName()}" required>
				</div>

				<div class="mb-3">
					<label class="form-label colorTwo">Last Name</label> <input
						name="lastName" type="text" class="form-control"
						value="${user.getLastName()}" required>
				</div>

				<div class="mb-3">
					<label class="form-label colorTwo">Password</label> <input
						name="password" type="password" class="form-control" required>
				</div>

				<input name="emailAddress" type="hidden"
					value="${user.getEmailAddress()}"> <input name="role"
					type="hidden" value="ROLE_USER"> <input name="userId"
					type="hidden" value="${user.getUserId()}"> <input
					type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button id="editBtn" type="submit" class="btn btn-style mb-3">Edit</button>
			</form>
		</div>
	</c:if>
</security:authorize>

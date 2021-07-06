<jsp:include page="../shared/layout.jsp"></jsp:include>


<p class="h3 colorTwo">Sign Up</p>
<form action="${appName}user/signup" method="post">

	<img class="img-fluid img-thumbnail" id="userProfileImage"
		src="../images/profile.png">
	<div class="mb-3">
		<label class="form-label colorTwo">Picture URL</label> <input
			id="pictureUrlUser" type="text" name="picture" class="form-control"
			required>
	</div>

	<div class="mb-3">
		<label class="form-label colorTwo">First Name</label> <input
			name="firstName" type="text" class="form-control" required>
	</div>

	<div class="mb-3">
		<label class="form-label colorTwo">Last Name</label> <input
			name="lastName" type="text" class="form-control" required>
	</div>

	<div class="mb-3">
		<label class="form-label colorTwo">Email Address</label> <input
			name="emailAddress" type="email" class="form-control" required>
	</div>

	<div class="mb-3">
		<label class="form-label colorTwo">Password</label> <input
			name="password" type="password" class="form-control" required>
	</div>

	<input name="role" type="hidden" value="ROLE_USER"> <input
		type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

	<button id="signUpBtn" type="submit" class="btn btn-style mb-3">Submit</button>

</form>

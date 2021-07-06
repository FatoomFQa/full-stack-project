<jsp:include page="../shared/layout.jsp"></jsp:include>


<p class="h3 colorTwo">Login</p>

<form action="${appName}login" method="post" class="color2">

	<div class="mb-3">
		<label class="form-label colorTwo">Email Address</label> <input
			name="username" type="text" class="form-control" required>
	</div>

	<div class="mb-3">
		<label class="form-label colorTwo">Password</label> <input
			name="password" type="password" class="form-control" required>
	</div>

	<input type="hidden" name="${_csrf.parameterName}"
		value="${_csrf.token}" />

	<button type="submit" class="btn btn-style mb-3">Submit</button>

</form>

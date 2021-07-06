<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<jsp:include page="../shared/layout.jsp" />


<p class="h2 color1"
	style="margin-top: 2%; margin-bottom: 1%; margin-left: 5%;">Chefs</p>

<div class="row row-cols-1 row-cols-md-3 chefsContainer">
	<c:forEach items="${chefs}" var="chef">
		<div class="col mb-4">
			<div class="card h-100">
				<img src="${chef[2]}" class="card-img-top" alt="...">

				<div class="card-footer colorOne">
					<h5 class="card-title colorOne" style="text-align: center;">
						<a style="text-decoration: none; color: inherit;"
							href="${appName}user/detail?email=${chef[1]}">${chef[0] }</a>
					</h5>
				</div>
				<security:authorize access="isAuthenticated()">
					<security:authorize access="hasRole('ADMIN')">

						<div class="card-footer colorOne" style="text-align: center">
							<a href="${appName}chefs/delete?id=${chef[3]}"><button
									class="btn btn-style">Delete</button></a>

						</div>
					</security:authorize>
				</security:authorize>
			</div>
		</div>
	</c:forEach>
</div>
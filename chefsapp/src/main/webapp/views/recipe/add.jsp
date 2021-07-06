<jsp:include page="../shared/layout.jsp" />


<p class="h3 colorTwo">Add Recipe</p>


<form id="addRecipe" action="${appName}recipe/add" method="post">


	<img class="img-fluid img-thumbnail" id="recipeImg"
		src="../images/placeholder-image.png">
	<div class="mb-3">
		<label class="form-label colorTwo">Picture URL</label> <input
			id="pictureUrl" type="text" name="picture" class="form-control">
	</div>

	<div class="mb-3">
		<label class="form-label colorTwo">Name </label> <input type="text"
			name="name" class="form-control" required>
	</div>

	<div class="mb-3">
		<label class="form-label colorTwo">Description</label> <input
			type="text" name="description" class="form-control" required>
	</div>

	<div class="mb-3">
		<label class="form-label colorTwo">Ingredients</label>
		<hr>
		<div id="ingContainer"></div>
	</div>

	<div class="container-fluid"
		style="margin-left: -1.5%; margin-bottom: 1%;">
		<div class="row">
			<div class="col">
				<label class="form-label colorTwo">Amount</label>
			</div>
			<div class="col">
				<label class="form-label colorTwo">Measurement</label>
			</div>
			<div class="col">
				<label class="form-label colorTwo">Item</label>
			</div>
			<div class="col">
				<label class="form-label colorTwo">Action</label>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<input id="amount" type="number" step=".25" class="form-control">
			</div>
			<div class="col">
				<select class="form-control" id="measurement">
					<option value="--">--</option>
					<option value="cup">cup</option>
					<option value="tsp">tsp</option>
					<option value="tbsp">tbsp</option>
					<option value="gram">gram</option>
					<option value="mL">mL</option>
				</select>
			</div>
			<div class="col">
				<input id="item" type="text" class="form-control">
			</div>
			<div class="col">
				<button style="width: 100%" class="btn btn-style" type="button"
					id="addIng">Add Ingredient</button>
			</div>
		</div>
	</div>

	<input id="ingredients" type="hidden" name="ingredients">

	<div class="mb-3">
		<label class="form-label colorTwo">Allergy Warnings</label>
		<div class="form-text" style="color: #B3B6B7;">Press control
			then click to be able to select multiple values.</div>
		<select class="form-control" name="allergyWarnings"
			multiple="multiple" required>
			<option value="None">None</option>
			<option value="Milk">Milk</option>
			<option value="Eggs">Eggs</option>
			<option value="Soy">Soy</option>
			<option value="yeast">yeast</option>
			<option value="peanuts">peanuts</option>
			<option value="Wheat">Wheat</option>
			<option value="Fish">Fish</option>
		</select>
	</div>



	<div class="mb-3">
		<label class="form-label colorTwo">Instructions </label>
		<hr>
		<div id="instructionsCon"></div>
		<div class="input-group mb-3">
			<input id="instructionsText" type="text" class="form-control">
			<button class="btn btn-style" type="button" id="addIns">add
				Instructions</button>
		</div>
		<input id="instructions" type="hidden" name="instructions">
	</div>

	<div class="mb-3">
		<label class="form-label colorTwo">Cuisine</label> <select
			class="form-control" name="cuisine">
			<option value="General">General</option>
			<option value="Arabic">Arabic</option>
			<option value="Indian">Indian</option>
			<option value="Chinese">Chinese</option>
			<option value="Italian">Italian</option>
			<option value="Greek">Greek</option>
			<option value="Japanese">Japanese</option>
		</select>
	</div>

	<div class="mb-3">
		<label class="form-label colorTwo">Type</label> <select
			class="form-control" name="type">
			<option value="soup">Soup</option>
			<option value="appetizer">Appetizer</option>
			<option value="salad">Salad</option>
			<option value="main course">Main Course</option>
			<option value="dessert">Dessert</option>
		</select>
	</div>

	<div class="mb-3">
		<label class="form-label colorTwo">Duration </label>
	</div>

	<div class="container-fluid"
		style="margin-left: -1.5%; margin-bottom: 1%; margin-top: -1.5%;">
		<div class="row">
			<div class="col">
				<label class="form-label colorTwo">Time </label>
			</div>
			<div class="col">
				<label class="form-label colorTwo">Minute or Hour</label>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<input id="durationNumber" type="number" step=".25"
					class="form-control" required>
			</div>
			<div class="col">
				<select class="form-control" id="durationType">
					<option value="Hour(s)">Hour(s)</option>
					<option value="Minute(s)">Minute(s)</option>
				</select>
			</div>
		</div>
	</div>
	<input id="duration" type="hidden" name="duration">

	<div class="mb-3">
		<label class="form-label colorTwo">Servings </label> <input
			type="number" name="servings" class="form-control" required>
	</div>

	<div class="mb-3">
		<label class="form-label colorTwo">Calories</label> <input
			type="number" name="calories" class="form-control" required>
	</div>

	<input type="hidden" name="user" value="${userId}"> <input
		type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

	<button id="submit" type="submit" class="btn btn-style">Submit</button>

</form>
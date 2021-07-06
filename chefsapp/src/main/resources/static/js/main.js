$(document).ready(function() {

	// for loading the image in navbar correctly
	if ($(location).attr("href").endsWith("/")) {
		$("#logo").attr("src", "images/chefs.svg");
		$("#favIcon").attr("href", "images/chefIcon.png");

	}
	else {
		$("#logo").attr("src", "../images/chefs.svg");
		$("#favIcon").attr("href", "../images/chefIcon.png");

	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// FOR ADD RECIPE 

	$("#addIng").on("click", function() {
		var amount = $("#amount").val();
		var measurement = $("#measurement").children("option:selected").val();
		var item = $("#item").val();

		if (amount != "" && item != "") {
			if (measurement != "--")
				var ingredient = amount + " " + measurement + " of " + item;
			else
				var ingredient = amount + " " + item;
			$("#ingContainer").append("<div class='ingItem'><p class='ingText' style='display: inline;'>" + ingredient + "</p><span class='deleteIng' style='display:  none; text-align: right; float: right;'><b>Delete</b></span></div>");
		}
		else {
			alert("please enter amount and item");
		}
	});

	$("#ingContainer").on("mouseenter", ".ingItem", function() {
		$(this).children(".deleteIng").css("display", "inline");
		$(this).css({ "background-color": "#7d0633", "color": "white" });
	});

	$("#ingContainer").on("mouseleave", ".ingItem", function() {
		$(this).children(".deleteIng").css("display", "none");
		$(this).css({ "background-color": "white", "color": "#31112c" });
	});

	$("#ingContainer").on("click", ".deleteIng", function() {
		$(this).parent().remove();
	});

	$("#addIns").on("click", function() {
		var step = $("#instructionsText").val();
		$("#instructionsText").val("");

		if (step != "") {
			$("#instructionsCon").append("<div class='insItem'><p class='insText' style='display: inline;'>" + step + "</p><br><span class='deleteIns' style='display:  none; text-align: right; float: right;'><b >- Delete</b></span><span class='moveDown' style='display:  none; text-align: right; float: right;'><b>- Move Down -</b></span><span class='moveUp' style='display:  none; text-align: right; float: right;'><b>Move Up -</b></span></div>");
		}
		else {
			alert("please enter an instruction");
		}
	});

	$("#instructionsCon").on("mouseenter", ".insItem", function() {
		$(this).children(".deleteIns").css("display", "inline");
		$(this).children(".moveUp").css("display", "inline");
		$(this).children(".moveDown").css("display", "inline");
		$(this).css({ "background-color": "#7d0633", "color": "white", "height": "15vh" });
	});

	$("#instructionsCon").on("mouseleave", ".insItem", function() {
		$(this).children(".deleteIns").css("display", "none");
		$(this).children(".moveUp").css("display", "none");
		$(this).children(".moveDown").css("display", "none");
		$(this).css({ "background-color": "white", "color": "#31112c", "height": "" });
	});

	$("#instructionsCon").on("click", ".deleteIns", function() {
		$(this).parent().remove();
	});

	$("#instructionsCon").on("click", ".moveUp", function() {
		($(this).parent()).insertBefore($(this).parent().prev());
	});

	$("#instructionsCon").on("click", ".moveDown", function() {
		($(this).parent()).insertAfter($(this).parent().next());
	});

	$("#pictureUrl").on('change', function() {
		var newUrl = $(this).val();
		if (newUrl == "") {
			$("#recipeImg").attr("src", "../images/placeholder-image.png");
		} else {
			$("#recipeImg").attr("src", newUrl);
		}

	});

	function inputValidation(event) {
		if (!$.trim($('#ingContainer').html()).length) {
			event.preventDefault();
			alert("please add at least 1 step and 1 ingredient");
		}
		else {
			var ingredients = "";
			$(".ingItem").each(function() {
				ingredients += $(this).children(".ingText").text() + ", ";
			});

			var instructions = "";
			$(".insItem").each(function() {
				instructions += $(this).children(".insText").text() + "^ ";
			});

			ingredients = ingredients.substring(0, ingredients.length - 2);
			instructions = instructions.substring(0, instructions.length - 2);
			$("#ingredients").val(ingredients);
			$("#instructions").val(instructions);
			var duration = $("#durationNumber").val() + " " + $("#durationType").children("option:selected").val();
			$("#duration").val(duration);
		}
	}

	$("#addRecipe").submit(inputValidation);

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// FOR USER DETAILS

	$("#editInfo").on('click', function() {
		$("#userInfo").css("display", "none");
		$("#title").css("display", "none");
		$("#editUser").css("display", "block");
	});

	$("#shareUserButton").on('click', function() {
		console.log("clicked")
		$("#shareUserDiv").toggle();
	});

	$("#pictureUrlUser").on('change', function() {
		var newUrl = $(this).val();
		if (newUrl == "") {
			$("#userProfileImage").attr("src", "../images/profile.png");
		} else {
			$("#userProfileImage").attr("src", newUrl);
		}
	});

	// FOR USER EDIT IN USER DETAILS

	$("#pictureUrlUserEdit").on('change', function() {
		var newUrl = $(this).val();
		if (newUrl == "") {
			$("#userProfileImageEdit").attr("src", "../images/profile.png");
		} else {
			$("#userProfileImageEdit").attr("src", newUrl);
		}
	});

	$("#shareRecipeButton").on('click', function() {
		console.log("clicked")
		$("#shareUserDiv").toggle();
	});

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// FOR Edit RECIPE 

	$("#editRecipe").ready(function() {
		console.log("form loaded");
		var ingredients = $("#ingredientsTemp").val().split(',');
		for (var i in ingredients) {
			$("#ingContainerEdit").append("<div class='ingItem'><p class='ingText' style='display: inline;'>" + ingredients[i] + "</p><span class='deleteIng' style='display:  none; text-align: right; float: right;'><b>Delete</b></span></div>");
		}
		
		var warning = $("#allergyWarningTemp").val().split(',');
		for (var i in warning) {
			$('#aWarnings option[value='+warning[i]+']').attr('selected','selected');
		}
		
		var instructions = $("#instructionsTemp").val().split('^');
		for (var i in instructions) {
			$("#instructionsConEdit").append("<div class='insItem'><p class='insText' style='display: inline;'>" + instructions[i] + "</p><br><span class='deleteIns' style='display:  none; text-align: right; float: right;'><b >- Delete</b></span><span class='moveDown' style='display:  none; text-align: right; float: right;'><b>- Move Down -</b></span><span class='moveUp' style='display:  none; text-align: right; float: right;'><b>Move Up -</b></span></div>");
		}
		
		$('#aCuisine option[value='+$("#cuisineTemp").val()+']').attr('selected','selected');
		
		$('#aType option[value='+$("#typeTemp").val()+']').attr('selected','selected');
		
		var duration = $("#durationTemp").val().split(' ');
		$("#durationNumberEdit").val(duration[0]);
		$('#durationTypeEdit option[value='+duration[1]+']').attr('selected','selected');
		
		
		

	});

	$("#addIngEdit").on("click", function() {
		var amount = $("#amountEdit").val();
		var measurement = $("#measurementEdit").children("option:selected").val();
		var item = $("#itemEdit").val();

		if (amount != "" && item != "") {
			if (measurement != "--")
				var ingredient = amount + " " + measurement + " of " + item;
			else
				var ingredient = amount + " " + item;
			$("#ingContainerEdit").append("<div class='ingItem'><p class='ingText' style='display: inline;'>" + ingredient + "</p><span class='deleteIng' style='display:  none; text-align: right; float: right;'><b>Delete</b></span></div>");
		}
		else {
			alert("please enter amount and item");
		}
	});

	$("#ingContainerEdit").on("mouseenter", ".ingItem", function() {
		$(this).children(".deleteIng").css("display", "inline");
		$(this).css({ "background-color": "#7d0633", "color": "white" });
	});

	$("#ingContainerEdit").on("mouseleave", ".ingItem", function() {
		$(this).children(".deleteIng").css("display", "none");
		$(this).css({ "background-color": "white", "color": "#31112c" });
	});

	$("#ingContainerEdit").on("click", ".deleteIng", function() {
		$(this).parent().remove();
	});

	$("#addInsEdit").on("click", function() {
		var step = $("#instructionsTextEdit").val();
		$("#instructionsTextEdit").val("");

		if (step != "") {
			$("#instructionsConEdit").append("<div class='insItem'><p class='insText' style='display: inline;'>" + step + "</p><br><span class='deleteIns' style='display:  none; text-align: right; float: right;'><b >- Delete</b></span><span class='moveDown' style='display:  none; text-align: right; float: right;'><b>- Move Down -</b></span><span class='moveUp' style='display:  none; text-align: right; float: right;'><b>Move Up -</b></span></div>");
		}
		else {
			alert("please enter an instruction");
		}
	});

	$("#instructionsConEdit").on("mouseenter", ".insItem", function() {
		$(this).children(".deleteIns").css("display", "inline");
		$(this).children(".moveUp").css("display", "inline");
		$(this).children(".moveDown").css("display", "inline");
		$(this).css({ "background-color": "#7d0633", "color": "white", "height": "15vh"});
	});

	$("#instructionsConEdit").on("mouseleave", ".insItem", function() {
		$(this).children(".deleteIns").css("display", "none");
		$(this).children(".moveUp").css("display", "none");
		$(this).children(".moveDown").css("display", "none");
		$(this).css({ "background-color": "white", "color": "#31112c", "height": "" });
	});

	$("#instructionsConEdit").on("click", ".deleteIns", function() {
		$(this).parent().remove();
	});

	$("#instructionsConEdit").on("click", ".moveUp", function() {
		($(this).parent()).insertBefore($(this).parent().prev());
	});

	$("#instructionsConEdit").on("click", ".moveDown", function() {
		($(this).parent()).insertAfter($(this).parent().next());
	});

	$("#pictureUrlEdit").on('change', function() {
		var newUrl = $(this).val();
		if (newUrl == "") {
			$("#recipeImgEdit").attr("src", "../images/placeholder-image.png");
		} else {
			$("#recipeImgEdit").attr("src", newUrl);
		}

	});

	function inputValidationEdit(event) {
		if (!$.trim($('#ingContainerEdit').html()).length) {
			event.preventDefault();
			alert("please add at least 1 step and 1 ingredient");
		}
		else {
			var ingredients = "";
			$(".ingItem").each(function() {
				ingredients += $(this).children(".ingText").text() + ",";
			});

			var instructions = "";
			$(".insItem").each(function() {
				instructions += $(this).children(".insText").text() + "^";
			});

			ingredients = ingredients.substring(0, ingredients.length - 2);
			instructions = instructions.substring(0, instructions.length - 2);
			$("#ingredientsEdit").val(ingredients);
			$("#instructionsEdit").val(instructions);
			var duration = $("#durationNumberEdit").val() + " " + $("#durationTypeEdit").children("option:selected").val();
			$("#durationEdit").val(duration);
		}
	}

	$("#editRecipe").submit(inputValidationEdit);
	
	$("#recipeFilter").ready(function() {
		var indexOfType = $(location).attr("href").indexOf("first");
		var indexOfAnd = $(location).attr("href").indexOf("&");
		type="";
		if(indexOfAnd == -1){
			type = $(location).attr("href").substring(indexOfType+6, $(location).attr("href").length);
		}else{
			type = $(location).attr("href").substring(indexOfType+6, indexOfAnd);
		}
		console.log('type='+type);
		if (type == "All") {
			$("#All").attr("checked", "checked");
		}
		else if (type == "Soup") {
			$("#Soup").attr("checked", "checked");
		}
		else if (type == "Appetizer") {
			$("#Appetizer").attr("checked", "checked");
		}
		else if (type == "Salad") {
			$("#Salad").attr("checked", "checked");
		}
		else if (type == "Main Course") {
			$("#MainCourse").attr("checked", "checked");
		}
		else if (type == "Dessert") {
			$("#Dessert").attr("checked", "checked");
		}
	});

});
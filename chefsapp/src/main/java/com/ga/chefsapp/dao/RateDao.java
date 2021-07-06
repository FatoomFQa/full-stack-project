package com.ga.chefsapp.dao;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.ga.chefsapp.model.Rate;
import com.ga.chefsapp.model.Recipe;
import com.ga.chefsapp.model.User;

public interface RateDao extends CrudRepository<Rate, Integer> {

	public Rate findByUserAndRecipe(User userId, Recipe recipeId);

	@Query(value = "SELECT avg(rating) FROM rate WHERE recipe = :recipeId", nativeQuery = true)
	public Integer findByRecipeAvg(Recipe recipeId);
}

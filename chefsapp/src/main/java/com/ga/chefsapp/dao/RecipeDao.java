package com.ga.chefsapp.dao;

import com.ga.chefsapp.model.Recipe;
import com.ga.chefsapp.model.User;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface RecipeDao extends CrudRepository<Recipe, Integer> {

	@Query(value = "SELECT * FROM recipe order by\n" + "(\n"
			+ "                                    select avg(rating)\n"
			+ "                                    from rate \n"
			+ "                                    where recipe.id =  recipe\n"
			+ "                                    group by recipe\n" + "\n"
			+ "                                ) DESC", nativeQuery = true)

	public Iterable<Recipe> findByOrderedRating();

	@Query(value = "SELECT * FROM recipe WHERE type = :type", nativeQuery = true)
	public Iterable<Recipe> findByTypeParams(@Param("type") String type);

	public Recipe findById(int id);

	public int countByUser(User user);

	public Iterable<Recipe> findAllByUser(User user);
}

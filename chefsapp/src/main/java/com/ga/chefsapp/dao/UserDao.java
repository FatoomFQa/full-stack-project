package com.ga.chefsapp.dao;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.ga.chefsapp.model.User;

import java.util.List;

public interface UserDao extends CrudRepository<User, Integer> {
	public User findByEmailAddress(String emailAddress);

	public User findById(int id);

	@Query(value = "Select distinct first_name, email_address, u.picture ,user_id From user u\r\n"
			+ "			INNER JOIN  recipe r on u.user_id = r.fk_user_id;", nativeQuery = true)
	public List<Object[]> findByFKuserId();
}

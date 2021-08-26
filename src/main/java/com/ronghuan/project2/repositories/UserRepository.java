package com.ronghuan.project2.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.ronghuan.project2.models.User;


public interface UserRepository extends CrudRepository<User, Long>{
	List<User> findAll();
	
	// GET USER OBJECT BY A PARTICULAR EMAIL
	User findByEmail(String email);
}

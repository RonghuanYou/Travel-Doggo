package com.ronghuan.project2.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ronghuan.project2.models.City;
import com.ronghuan.project2.models.User;

@Repository
public interface CityRepository extends CrudRepository<City, Long> {
	List<City> findAll();
	
    // GET A LIST OF CITIES BY A PARTICULAR CREATOR
	List<City> findAllByCreator(User user);
}




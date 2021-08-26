package com.ronghuan.project2.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.ronghuan.project2.models.City;


public interface CityRepository extends CrudRepository<City, Long> {
	List<City> findAll();
}

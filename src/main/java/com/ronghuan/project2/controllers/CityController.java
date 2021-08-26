package com.ronghuan.project2.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ronghuan.project2.models.City;
import com.ronghuan.project2.services.MainService;

@RestController
public class CityController {
	@Autowired
	private MainService mainServ;

    @GetMapping("/cities")
    public List<City> allCities() {
    	return mainServ.getAllCities();
    }
}

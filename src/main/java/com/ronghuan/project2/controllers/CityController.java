package com.ronghuan.project2.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ronghuan.project2.models.City;
import com.ronghuan.project2.models.User;
import com.ronghuan.project2.services.MainService;

@RestController
public class CityController {
	@Autowired
	private MainService mainServ;

    @GetMapping("/cities")
    public List<City> getTargetedCities(HttpSession session) {
    	User oneUser = mainServ.findUserById((Long)session.getAttribute("user_id"));
    	return mainServ.getAllMarkedCitiesByUser(oneUser);
    }
    
    
    @GetMapping("/location")
    public User getUserLocation(HttpSession session) {
    	Long user_id = (Long)session.getAttribute("user_id");
    	return mainServ.findUserById(user_id);
    }
}

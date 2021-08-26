package com.ronghuan.project2.services;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ronghuan.project2.models.City;
import com.ronghuan.project2.models.User;
import com.ronghuan.project2.repositories.CityRepository;
import com.ronghuan.project2.repositories.UserRepository;

@Service
public class MainService {
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private CityRepository cityRepo;
	
	// --------------------- CRUD USERS ---------------------
	// (CREATE) register user and hash their password
    public User registerUser(User user) {
    	// GET PLAIN TEXT PASSWORD AND TURNING INTO HASHED PASSWORD
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepo.save(user);
    }
    
    // find user by email
    public User findByEmail(String email) {
        return userRepo.findByEmail(email);
    }
    
    // find user by id
    public User findUserById(Long id) {
    	return userRepo.findById(id).orElse(null);
    }
    
    // authenticate user
    public boolean authenticateUser(String email, String password) {
        // first find the user by email
        User user = userRepo.findByEmail(email);
        // if we can't find it by email, return false
        if(user == null) {
            return false;
        } else {
            // if the passwords match, return true, else, return false
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }
    
    
	// --------------------- CRUD CITY  ---------------------
    // CREAET & UPDATE
    public City saveCity(City c) {
    	return cityRepo.save(c);
    }
    
    // READ ONE CITY
    public City getCity(Long id) {
    	return cityRepo.findById(id).orElse(null);
    }
    
    
    // READ ALL CITIES
    public List<City> getAllCities(){
    	return cityRepo.findAll();
    }
    
    
    // DELETE ONE CITY
    public void deleteCity(Long city_id) {
    	 cityRepo.deleteById(city_id);
    }
        
}

package com.ronghuan.project2.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ronghuan.project2.models.City;
import com.ronghuan.project2.models.User;
import com.ronghuan.project2.services.MainService;
import com.ronghuan.project2.validators.UserValidator;



@Controller
public class MainController {
	@Autowired
	private MainService mainServ;
	
	@Autowired
	private UserValidator userValidator;
	
	// ----------------------- Registration/Login Page --------------------------------------
	// SHOW REGISTRATION/LOGIN IN THE SAME PAGE
	@GetMapping("/")
	public String loginPage(@ModelAttribute("userObj") User emptyUser) {
		return "index.jsp";
	}
	
	// PERFORM THE ACTION OF CERATING USER
	@PostMapping("/registration")
	public String login(
		@Valid @ModelAttribute("userObj") User filledUser,
		BindingResult result,
		HttpSession session) {
		
		// CUSTOM VALIDATION: UNIQUE/PASSWORD MATCH CHECK
		userValidator.validate(filledUser, result);
		
		if (result.hasErrors()) {
			return "index.jsp";
		} else {
			// save user info in db and save user_id in session
			User newUser = mainServ.registerUser(filledUser);
			session.setAttribute("user_id", newUser.getId());
			return "redirect:/dashboard";
		}
	}
	
	
	// PERFORM THE ACTION OF LOGIN
    @PostMapping("/login")
    public String loginUser(
    	@RequestParam("email") String email, @RequestParam("password") String password, 
    	Model model, 
    	HttpSession session,
    	RedirectAttributes flashMessages) {
        // if the user is authenticated, save their user id in session
    	// else, add error messages and return the login page
    	if (mainServ.authenticateUser(email, password)) {
    		User loggedUser = mainServ.findByEmail(email);
    		session.setAttribute("user_id", loggedUser.getId());
    		return "redirect:/dashboard";
    	} else {
    		flashMessages.addFlashAttribute("error", "INVALID LOGIN");
    		return "redirect:/";
    	}
    }
	
	
	// LOGOUT AND CLEAR SESSION
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // invalidate session and redirect to login page
    	session.invalidate();
    	return "redirect:/";
    }
    
    // -----
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
    	
    	// get current user object and pass it to jsp
		model.addAttribute("user", mainServ.findUserById((Long)session.getAttribute("user_id")));
    	return "dashboard.jsp";
    }
    
    // display form to create city
    @GetMapping("/traveldoggos")
    public String newCity(Model model, HttpSession session, @ModelAttribute("cityObj") City emptyCity) {
    	
    	// get current user object and pass it to jsp
		model.addAttribute("user", mainServ.findUserById((Long)session.getAttribute("user_id")));
		model.addAttribute("cities", mainServ.getAllCities());

    	return "city.jsp";
    }
    
    @PostMapping("/traveldoggos")
    public String createCity(Model model, HttpSession session, 
    	@Valid @ModelAttribute("cityObj") City filledCity, BindingResult result) {
    	if (result.hasErrors()) {
    		model.addAttribute("user", mainServ.findUserById((Long)session.getAttribute("user_id")));
    		model.addAttribute("cities", mainServ.getAllCities());
        	return "city.jsp";
    	} else {
    		mainServ.saveCity(filledCity);
    		return "redirect:/traveldoggos";
    	}
    }
    
    // READ ONE CITY
//    @GetMapping("/traveldoggos/{id}/city")
//    public String readCity() {
//    	return "cityinfo.jsp";
//    }
//    
    
    // SHOW FROM TO UPDATE CITY
    @GetMapping("/traveldoggos/{id}/updatecity")
    public String editCity(Model model, @PathVariable("id") Long city_id) {
    	// login check
    	
    	// PASS A PARTICULAR CITY TO JSOP
    	model.addAttribute("cityObj", mainServ.getCity(city_id));
    	return "edit.jsp";
    }

    
    // PERFORM THE ACTION OF UPDATING CITY INFO
    @PutMapping("/traveldoggos/{id}/updatecity")
    public String udpateCity(@Valid @ModelAttribute("cityObj") City filledCity, BindingResult results) {
    	if (results.hasErrors()){
    		return "edit.jsp";
    	} else {
    		mainServ.saveCity(filledCity);
    		return "redirect:/traveldoggos";
    	}
    }
    
    
    // DELETE AN CITY
    @GetMapping("/traveldoggos/{id}/delete")
    public String deleteCity(@PathVariable("id") Long city_id) {
    	// Login check
    	
    	// DELETE A PARTICULAR CITY
    	mainServ.deleteCity(city_id);
		return "redirect:/traveldoggos";
    }
    
    
    
    
    
    
    
    
    
}
    


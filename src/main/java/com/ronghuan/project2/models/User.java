package com.ronghuan.project2.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

@Entity
@Table(name="users")
public class User {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    
    // MEMBER VARIABLES
    @NotEmpty(message = "Name must be present")
    private String name;
    
    
    @NotEmpty(message = "Email must be present")
    @Email(message = "Must have valid email format")
    private String email;
    
    @NotEmpty(message = "Password must be present")
    @Size(min=8, message = "Password must be at least 8 characters long")
    private String password;
    
    
    @NotEmpty(message="Location must be present")
    private String location;
    
    
    
	// dummy variable(not store in db)
    @Transient
    private String passwordConfirmation;
    
    
    // --------------------- RELATIONSHIPS ---------------------    

    // CONSTRUCTORS
    // EMPTY
    public User() {
    	
    }
    
    // FULL
    public User(String name, String email, String password, String location, String passwordConfirmation) {
    	this.name = name;
    	this.email = email;
    	this.password = password;
    	this.location = location;
    	this.passwordConfirmation = passwordConfirmation;
    }
    
    
    // GETTERS/SETTERS
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getPasswordConfirmation() {
		return passwordConfirmation;
	}

	public void setPasswordConfirmation(String passwordConfirmation) {
		this.passwordConfirmation = passwordConfirmation;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	
	// -------

	@Column(updatable=false)
    private Date createdAt;

	private Date updatedAt;
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
}

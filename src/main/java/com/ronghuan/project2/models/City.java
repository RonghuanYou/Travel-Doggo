package com.ronghuan.project2.models;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="visited_cities")
public class City {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    
    // MEMBER VARIABLES
    @NotEmpty(message = "Name must be present")
    private String name;
    
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @NotNull(message = "Date must be present")
    private Date date;
    
    @NotEmpty(message = "Comment must be present")
    private String comment;
    
    @NotNull(message = "Rating must be present")
    private Integer rating;
    
    // --------------------- RELATIONSHIPS ---------------------    
    // MANY TO ONE (CITIES ARE CREATED BY ONE USER)
    @JsonIgnore
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User creator;
    
    
    // MANY TO MANY(CITY-REVIEWS)
    @JsonIgnore
    @OneToMany(mappedBy="city", fetch=FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Comment> comments;
    
    
    // MANY TO MANY WITHOUT MIDDLE MODEL (CITIES CAN BE ADDED BY MANY USERS)
    @JsonIgnore
    @ManyToMany(fetch=FetchType.LAZY)
    @JoinTable(
    	name = "users_cities",
    	joinColumns = @JoinColumn(name = "city_id"),
    	inverseJoinColumns = @JoinColumn(name = "user_id")    		
    )
    private List<User> loggingUsers;    
        
    
    // CONSTRUCTORS
    // EMPTY
    public City() {
    	
    }
    
    // FULL
    public City(String name, Date date, String comment, Integer rating) {
    	this.name = name;
    	this.date = date;
    	this.comment = comment;
    	this.rating = rating;
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
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Integer getRating() {
		return rating;
	}
	public void setRating(Integer rating) {
		this.rating = rating;
	}
	
	
	// ---- RELNS -----
	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}
	
	public List<Comment> getComments() {
		return comments;
	}


	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	

	public List<User> getLoggingUsers() {
		return loggingUsers;
	}

	public void setLoggingUsers(List<User> loggingUsers) {
		this.loggingUsers = loggingUsers;
	}

	// ------- 
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

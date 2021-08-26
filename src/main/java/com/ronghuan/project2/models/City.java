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
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

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

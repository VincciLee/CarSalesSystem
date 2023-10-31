/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.time.LocalDate;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 *
 * @author Vincci
 */
@Entity
public class Sales implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private Integer car_id;
    private Integer customer_id;
    private Integer salesman_id;
    private LocalDate booked_date; 
    private LocalDate accepted_date; 
    private LocalDate completed_date; 
    private LocalDate canceled_date; 
    private String salesman_comment;
    private Integer customer_rating;
    private String customer_feedback;
    private String status;

    public Sales(Integer car_id, Integer customer_id, LocalDate date) {
        this.car_id = car_id;
        this.customer_id = customer_id;
        this.booked_date = date;
        this.customer_rating = 0;
        this.status = "Pending Acceptance";
    }
    
    public Sales() {
        
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCar_id() {
        return car_id;
    }

    public void setCar_id(Integer car_id) {
        this.car_id = car_id;
    }

    public Integer getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(Integer customer_id) {
        this.customer_id = customer_id;
    }

    public Integer getSalesman_id() {
        return salesman_id;
    }

    public void setSalesman_id(Integer salesman_id) {
        this.salesman_id = salesman_id;
    }

    public LocalDate getBooked_date() {
        return booked_date;
    }

    public void setBooked_date(LocalDate booked_date) {
        this.booked_date = booked_date;
    }

    public LocalDate getAccepted_date() {
        return accepted_date;
    }

    public void setAccepted_date(LocalDate accepted_date) {
        this.accepted_date = accepted_date;
    }

    public LocalDate getCompleted_date() {
        return completed_date;
    }

    public void setCompleted_date(LocalDate completed_date) {
        this.completed_date = completed_date;
    }

    public LocalDate getCanceled_date() {
        return canceled_date;
    }

    public void setCanceled_date(LocalDate canceled_date) {
        this.canceled_date = canceled_date;
    }

    public String getSalesman_comment() {
        return salesman_comment;
    }

    public void setSalesman_comment(String salesman_comment) {
        this.salesman_comment = salesman_comment;
    }

    public Integer getCustomer_rating() {
        return customer_rating;
    }

    public void setCustomer_rating(Integer customer_rating) {
        this.customer_rating = customer_rating;
    }

    public String getCustomer_feedback() {
        return customer_feedback;
    }

    public void setCustomer_feedback(String customer_feedback) {
        this.customer_feedback = customer_feedback;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Sales)) {
            return false;
        }
        Sales other = (Sales) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Sales[ id=" + id + " ]";
    }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 *
 * @author Vincci
 */
@Entity
public class Cars implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String brand;
    private String model;
    private Integer publish_year;
    private String description;
    private String body_type;
    private String transmission;
    private String fuel;
    private Integer seat;
    private String image;
    private int price;
    private String status;

    public Cars(String brand, String model, Integer publish_year, String description, String body_type, String transmission, String fuel, Integer seat, int price, String image) {
        this.brand = brand;
        this.model = model;
        this.publish_year = publish_year;
        this.description = description;
        this.body_type = body_type;
        this.transmission = transmission;
        this.fuel = fuel;
        this.seat = seat;
        this.price = price;
        this.image = image;
        this.status = "Available";
    }

    public Cars(){
        
    }
    
    public Cars updateCar(String brand, String model, Integer publish_year, String description, String body_type, String transmission, String fuel, Integer seat, int price, String image) {
        this.brand = brand;
        this.model = model;
        this.publish_year = publish_year;
        this.description = description;
        this.body_type = body_type;
        this.transmission = transmission;
        this.fuel = fuel;
        this.seat = seat;
        this.price = price;
        this.image = image;
        
        return this;
    }
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public Integer getPublishYear() {
        return publish_year;
    }

    public void setPublishYear(Integer year) {
        this.publish_year = year;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBody_type() {
        return body_type;
    }

    public void setBody_type(String body_type) {
        this.body_type = body_type;
    }

    public String getTransmission() {
        return transmission;
    }

    public void setTransmission(String transmission) {
        this.transmission = transmission;
    }

    public String getFuel() {
        return fuel;
    }

    public void setFuel(String fuel) {
        this.fuel = fuel;
    }

    public Integer getSeat() {
        return seat;
    }

    public void setSeat(Integer seat) {
        this.seat = seat;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
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
        if (!(object instanceof Cars)) {
            return false;
        }
        Cars other = (Cars) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Cars[ id=" + id + " ]";
    }
    
}

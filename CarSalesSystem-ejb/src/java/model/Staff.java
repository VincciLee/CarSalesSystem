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
public class Staff implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String name;
    private String username;
    private String password;
    private String email;
    private String ic;
    private String dob;
    private String phone;
    private String gender;
    private String profile;

    public Staff(String name, String username, String password, String email, String ic, String dob, String phone, String gender, String profile) {
        this.name = name;
        this.username = username;
        this.password = password;
        this.email = email;
        this.ic = ic;
        this.dob = dob;
        this.phone = phone;
        this.gender = gender;
        this.profile = profile;
    }
    
    public Staff(String name, String username, String password, String email, String ic, String dob, String phone, String gender) {
        this.name = name;
        this.username = username;
        this.password = password;
        this.email = email;
        this.ic = ic;
        this.dob = dob;
        this.phone = phone;
        this.gender = gender;
    }
    
    public Staff(String username, String email, String password){
        this.username = username;
        this.email = email;
        this.password = password;
    }
    
    public Staff() {
        
    }
    
    public Staff updateDetails(String name, String username, String ic, String dob, String phone, String gender, String profile) {
        this.name = name;
        this.username = username;
        this.ic = ic;
        this.dob = dob;
        this.phone = phone;
        this.gender = gender;
        this.profile = profile;
        
        return this;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getIc() {
        return ic;
    }

    public void setIc(String ic) {
        this.ic = ic;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
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
        if (!(object instanceof Staff)) {
            return false;
        }
        Staff other = (Staff) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Staff[ id=" + id + " ]";
    }
    
}

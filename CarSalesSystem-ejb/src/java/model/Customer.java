/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.TypedQuery;

/**
 *
 * @author Vincci
 */
@Entity
public class Customer implements Serializable {
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
    private String approval_status;

    public Customer(String username, String password, String email) {
//        this.name = ";";
        this.username = username;
        this.password = password;
        this.email = email;
//        this.ic = ";";
//        this.dob = ";";
//        this.phone = ";";
//        this.gender = ";";
//        this.profile = ";";
        this.approval_status = "Pending";
    }
    
    public Customer(){
        
    }
    
    public Customer updateDetails(String name, String username, String ic, String dob, String phone, String gender, String profile) {
        this.name = name;
        this.username = username;
        this.ic = ic;
        this.dob = dob;
        this.phone = phone;
        this.gender = gender;
        this.profile = profile;
        this.approval_status = "Completed";
        
        return this;
    }

//    public Customer updateDetails(String name, String username, String ic, String dob, String phone, String gender, String profile) {
//        if (this.name.split(";").length == 0){
//            this.name = ";" + name;
//        }
//        else{
//            this.name = this.name.split(";")[1] + ";" + name;               
//        }
//
//        if (this.username.split(";").length == 0){
//            this.username = ";" + username;
//        }
//        else{
//            this.username = this.username.split(";")[1] + ";" + username;             
//        }
//        
//        if (this.ic.split(";").length == 0){
//            this.ic = ";" + ic;
//        }
//        else{
//            this.ic = this.ic.split(";")[1] + ";" + ic;       
//        }
//        
//        if (this.dob.split(";").length == 0){
//            this.dob = ";" + dob;
//        }
//        else{
//            this.dob = this.dob.split(";")[1] + ";" + dob;       
//        }
//        
//        if (this.phone.split(";").length == 0){
//            this.phone = ";" + phone;
//        }
//        else{
//            this.phone = this.phone.split(";")[1] + ";" + phone;       
//        }
//        
//        if (this.gender.split(";").length == 0){
//            this.gender = ";" + gender;
//        }
//        else{
//            this.gender = this.gender.split(";")[1] + ";" + gender;             
//        }
//        
//        if (this.profile.split(";").length == 0){
//            this.profile = ";" + profile;
//        }
//        else{
//            this.profile = this.profile.split(";")[1] + ";" + profile;             
//        }
//        
//        this.approval_status = "Pending";
//        
//        return this;
//    }
//    
//    public Customer cleanDetails(){
//        if (this.name.split(";").length == 0){
//            this.name = "";
//        }
//        else{
//            this.name = this.name.split(";")[1];                
//        }
//        
//        if (this.username.split(";").length == 0){
//            this.username = "";
//        }
//        else{
//            this.username = this.username.split(";")[1];                
//        }
//        
//        if (this.ic.split(";").length == 0){
//            this.ic = "";
//        }
//        else{
//            this.ic = this.ic.split(";")[1];                
//        }
//        
//        if (this.dob.split(";").length == 0){
//            this.dob = "";
//        }
//        else{
//            this.dob = this.dob.split(";")[1];                
//        }
//        
//        if (this.phone.split(";").length == 0){
//            this.phone = "";
//        }
//        else{
//            this.phone = this.phone.split(";")[1];                
//        }
//        
//        if (this.gender.split(";").length == 0){
//            this.gender = "";
//        }
//        else{
//            this.gender = this.gender.split(";")[1];                
//        }
//        
//        if (this.profile.split(";").length == 0){
//            this.profile = "";
//        }
//        else{
//            this.profile = this.profile.split(";")[1];                
//        }
//        
//        return this;
//    }
//    
//    public Customer oldDetails(){
//        if (this.name.split(";").length == 0){
//            this.name = "";
//        }
//        else{
//            this.name = this.name.split(";")[0];                
//        }
//        
//        if (this.username.split(";").length == 0){
//            this.username = "";
//        }
//        else{
//            this.username = this.username.split(";")[0];                
//        }
//        
//        if (this.ic.split(";").length == 0){
//            this.ic = "";
//        }
//        else{
//            this.ic = this.ic.split(";")[0];                
//        }
//        
//        if (this.dob.split(";").length == 0){
//            this.dob = "";
//        }
//        else{
//            this.dob = this.dob.split(";")[0];                
//        }
//        
//        if (this.phone.split(";").length == 0){
//            this.phone = "";
//        }
//        else{
//            this.phone = this.phone.split(";")[0];                
//        }
//        
//        if (this.gender.split(";").length == 0){
//            this.gender = "";
//        }
//        else{
//            this.gender = this.gender.split(";")[0];                
//        }
//        
//        if (this.profile.split(";").length == 0){
//            this.profile = "";
//        }
//        else{
//            this.profile = this.profile.split(";")[0];                
//        }
//        
//        return this;
//    }
    
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public String getApproval_status() {
        return approval_status;
    }

    public void setApproval_status(String approval_status) {
        this.approval_status = approval_status;
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
        if (!(object instanceof Customer)) {
            return false;
        }
        Customer other = (Customer) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Customer[ id=" + id + " ]";
    }

}

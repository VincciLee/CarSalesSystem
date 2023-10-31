/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

/**
 *
 * @author Vincci
 */
@Stateless
public class CustomerFacade extends AbstractFacade<Customer> {

    @PersistenceContext(unitName = "CarSalesSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CustomerFacade() {
        super(Customer.class);
    } 
    
    public Customer findEmail(String email){
        try{
            TypedQuery<Customer> query = em.createQuery("SELECT a from Customer a where a.email = :email", Customer.class);
            query.setParameter("email", email);
            Customer found = query.getSingleResult(); 
            
            return found;
        }catch(Exception e){
            return null;
        }
    }
    
    public List<Customer> getAllAccounts(String status){
        String type_query = "SELECT a from Customer a where a.approval_status != :filtered";
        if(!status.equals("All")){
            type_query += " and a.approval_status = :status";
        }
        
        try{
            TypedQuery<Customer> query = em.createQuery(type_query, Customer.class);
                query.setParameter("filtered", "Deleted");
 
            if(!status.equals("All")){
                query.setParameter("status", status);
            }
            
            List<Customer> found = query.getResultList();
        
            return found;
        }catch (Exception e){
            return null;
        }
    }     
    
}

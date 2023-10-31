/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;
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
public class SalesmenFacade extends AbstractFacade<Salesmen> {

    @PersistenceContext(unitName = "CarSalesSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public SalesmenFacade() {
        super(Salesmen.class);
    }
    
    public Salesmen findEmail(String email){
        try{
            TypedQuery<Salesmen> query = em.createQuery("SELECT a from Salesmen a where a.email = :email", Salesmen.class);
            query.setParameter("email", email);
            Salesmen found = query.getSingleResult(); 
            
            return found;
        }catch(Exception e){
            return null;
        }
    }
    
    public List<Salesmen> getAllAccounts(String status){
        String type_query = "SELECT a from Salesmen a where a.approval_status != :filtered";
        if(!status.equals("All")){
            type_query += " and a.approval_status = :status";
        }
        
        try{
            TypedQuery<Salesmen> query = em.createQuery(type_query, Salesmen.class);
                query.setParameter("filtered", "Deleted");
 
            if(!status.equals("All")){
                query.setParameter("status", status);
            }
            
            List<Salesmen> found = query.getResultList();
        
            return found;
        }catch (Exception e){
            return null;
        }
    }  
    
}

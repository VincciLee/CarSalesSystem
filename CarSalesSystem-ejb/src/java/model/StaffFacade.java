/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

/**
 *
 * @author Vincci
 */
@Stateless
public class StaffFacade extends AbstractFacade<Staff> {

    @PersistenceContext(unitName = "CarSalesSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public StaffFacade() {
        super(Staff.class);
    }
    
    public Staff findEmail(String email){
        try{
            TypedQuery<Staff> query = em.createQuery("SELECT a from Staff a where a.email = :email", Staff.class);
            query.setParameter("email", email);
            Staff found = query.getSingleResult(); 
            
            return found;
        }catch(Exception e){
//            System.out.println("StaffFacade:" + );
            return null;
        }
    }
}

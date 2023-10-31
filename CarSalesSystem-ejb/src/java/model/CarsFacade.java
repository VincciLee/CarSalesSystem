/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

/**
 *
 * @author Vincci
 */
@Stateless
public class CarsFacade extends AbstractFacade<Cars> {

    @PersistenceContext(unitName = "CarSalesSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CarsFacade() {
        super(Cars.class);
    }
    
    public List<Cars> getCarList(String status) {
        try{
            if(status ==  null || status.equals("")){
                status = "Available";
            }
            
            TypedQuery<Cars> query = em.createQuery("SELECT a from Cars a where a.status = :status", Cars.class);
            query.setParameter("status", status);
            List<Cars> found = query.getResultList();
            
            return found;
        }catch(Exception e){
            return null;
        }
    }
    
    public List<String> getCarModels(List<String> models){
        if (models ==  null){
            models = new ArrayList<>();
        }

        try{
            TypedQuery<Cars> query = em.createQuery("SELECT a from Cars a", Cars.class);
            List<Cars> found = query.getResultList();
            
            if (models.size() == 0){
                for (Cars c: found){
                    models.add(c.getModel());
                }
            }
            
            List<String> unique_models = models.stream().distinct().collect(Collectors.toList());
            
            return unique_models;
        }catch(Exception e){
            return null;
        }        
    }

    public List<Cars> getByColumn(String column, String data, String status) {
        String typed_query = "SELECT a from Cars a where a.status = :status";
        if(column.equals("brand")){
            typed_query += " and a.brand like :data";
        }else if(column.equals("model")){
            typed_query += " and a.model like :data";
        }
        data = "%" + data + "%";
        if(status ==  null || status.equals("")){
            status = "Available";
        }
        
        try{
            TypedQuery<Cars> query = em.createQuery(typed_query, Cars.class);
            query.setParameter("data", data);
            query.setParameter("status", status);
            List<Cars> found = query.getResultList();
            
            return found;
        }catch(Exception e){
            return null;
        }
    }
    
}

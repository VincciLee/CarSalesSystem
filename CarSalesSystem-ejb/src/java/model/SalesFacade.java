/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;
import java.util.Collections;
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
public class SalesFacade extends AbstractFacade<Sales> {

    @PersistenceContext(unitName = "CarSalesSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public SalesFacade() {
        super(Sales.class);
    }
    
    public Sales get_by_carId(Integer id, String status) {
        TypedQuery<Sales> query = em.createQuery("SELECT a from Sales a where a.car_id = :id and a.status = :status", Sales.class);
        query.setParameter("id", id);
        query.setParameter("status", status);
        Sales found = query.getSingleResult(); 
        
        return found;
    }
    
    public List<Sales> getAllPurchases(Integer id, String status){
        String type_query = "SELECT a from Sales a where a.customer_id = :id";
        if(!status.equals("All")){
            type_query += " and a.status = :status";
        }
        
        try{
            TypedQuery<Sales> query = em.createQuery(type_query, Sales.class);
            query.setParameter("id", id);
            
            if(!status.equals("All")){
                query.setParameter("status", status);
            }
            
            List<Sales> found = query.getResultList();
        
            return found;
        }catch (Exception e){
            return null;
        }
    }
    
    public List<Sales> getAllSales(Integer id, String status){
        String type_query = "SELECT a from Sales a where a.salesman_id = :id";
        if(!status.equals("All")){
            type_query += " and a.status = :status";
        }
        
        try{
            TypedQuery<Sales> query = em.createQuery(type_query, Sales.class);
            query.setParameter("id", id);
            
            if(!status.equals("All")){
                query.setParameter("status", status);
            }
            
            List<Sales> found = query.getResultList();
        
            return found;
        }catch (Exception e){
            return null;
        }
    }   
    
    public List<Sales> getSalesReports(String year, String month){
        List<Sales> sales = new ArrayList<>();
        String date = year;
        String type_query = "SELECT a from Sales a where a.completed_date IS NOT NULL";

        try{
            TypedQuery<Sales> query = em.createQuery(type_query, Sales.class);
            List<Sales> found = query.getResultList();
            
            if (!month.equals("0")){
                date += "-" + month;
            }
            
            for (Sales f: found){
                String sales_date = f.getCompleted_date().toString();
                if(sales_date.contains(date)){
                    sales.add(f);
                }
            }
        
            return sales;
        }catch (Exception e){
            return null;
        }
    }
        
    public List<Sales> getSalesmanReports(String year, String month, int id, String status){
        List<Sales> sales = new ArrayList<>();
        String date = year;
        String type_query = "SELECT a from Sales a where a.status = :status and a.salesman_id = :id";

        try{
            TypedQuery<Sales> query = em.createQuery(type_query, Sales.class);
            query.setParameter("id", id);
            query.setParameter("status", status);
            List<Sales> found = query.getResultList();
            
            if (!month.equals("0")){
                date += "-" + month;
            }
            
            for (Sales f: found){
                String compare_date = "";
                if(status.equals("Completed")){
                    compare_date = f.getCompleted_date().toString();
                }else if(status.equals("Canceled")){
                    compare_date = f.getCanceled_date().toString();
                }
                if(compare_date.contains(date)){
                    sales.add(f);
                }
            }
        
            return sales;
        }catch (Exception e){
            return null;
        }
    }
    
    public List<Object> getModelsRatings(){
        String type_query = "SELECT a.id, a.customer_rating, b.model from Sales a "
                + "LEFT JOIN Cars b ON b.id = a.car_id "
                + "WHERE a.completed_date IS NOT NULL";
        
        try{
            TypedQuery<Object> query = em.createQuery(type_query, Object.class);
            List<Object> found = query.getResultList();
            
            return found;
        }catch (Exception e){
            return null;
        }
    }

    public List<Sales> getCompletedPurchases(){
        String type_query = "SELECT a from Sales a where a.status = :status";
        
        try{
            TypedQuery<Sales> query = em.createQuery(type_query, Sales.class);
            query.setParameter("status", "Completed");
            
            List<Sales> found = query.getResultList();
        
            return found;
        }catch (Exception e){
            return null;
        }
    }
    
    public List<Sales> getRatedPurchases(){
        String type_query = "SELECT a from Sales a where a.status = :status and a.customer_rating > 0";
        
        try{
            TypedQuery<Sales> query = em.createQuery(type_query, Sales.class);
            query.setParameter("status", "Completed");
            
            List<Sales> found = query.getResultList();
        
            return found;
        }catch (Exception e){
            return null;
        }
    }
    
    public List<Sales> getRatedSales(String year, String month){
        String date = year;
        String type_query = "SELECT a from Sales a where a.status = :status and a.customer_rating > 0";
        List<Sales> sales = new ArrayList<>();
        
        try{
            TypedQuery<Sales> query = em.createQuery(type_query, Sales.class);
            query.setParameter("status", "Completed");
            List<Sales> found = query.getResultList();
            
            if (!month.equals("0")){
                date += "-" + month;
            }
            
            for (Sales f: found){
                String sales_date = f.getCompleted_date().toString();
                if(sales_date.contains(date)){
                    sales.add(f);
                }
            }
        
            return sales;
        }catch (Exception e){
            return null;
        }
    }
    
    public List<Sales> getCarRecords(int id){
        String type_query = "SELECT a from Sales a where a.car_id = :id";
        
        try{
            TypedQuery<Sales> query = em.createQuery(type_query, Sales.class);
            query.setParameter("id", id);
            
            List<Sales> found = query.getResultList();
        
            return found;
        }catch (Exception e){
            return null;
        }
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;
import model.CustomerFacade;
import model.Sales;
import model.SalesFacade;
import model.Staff;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Customer_Reports", urlPatterns = {"/Customer_Reports"})
public class Customer_Reports extends HttpServlet {

    @EJB
    private SalesFacade salesFacade;

    @EJB
    private CustomerFacade customerFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(false);
            try{
                Staff user = (Staff)session.getAttribute("login_user");
            }catch(Exception e){
                request.setAttribute("error", "Please login the system!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            } 
            
            String type = request.getParameter("type");
            
            List<Sales> sales = salesFacade.getCompletedPurchases();
            List<Sales> rated_sales = salesFacade.getRatedPurchases();
            List<Customer> customers = customerFacade.getAllAccounts("Completed");
            List<Customer> purchased_customers = new ArrayList<>();
            for(Sales s:sales){
                purchased_customers.add(customerFacade.find(s.getCustomer_id()));
            }
            List<String> customer_ids = new ArrayList<>();
            List<String> unique_customers = new ArrayList<>();
            for(Customer c: purchased_customers){
                customer_ids.add(Integer.toString(c.getId()));
            }
            unique_customers = customer_ids.stream().distinct().collect(Collectors.toList());
               
            DecimalFormat df = new DecimalFormat("#.##");
            int total_sales = sales.size();
            int total_rated_sales = rated_sales.size();
            double avg_feedback = Double.valueOf(df.format(rated_sales.size()*100/sales.size()));
            double avg_purchase = Double.valueOf(df.format(unique_customers.size()*100/customers.size()));
            
            Map<String, Integer> ages = new HashMap<>();
            ages.put("21-30", 0);
            ages.put("31-40", 0);
            ages.put("41-50", 0);
            ages.put(">50", 0);
            int[] min = {21, 31, 41};
            int[] max = {30, 40, 50};
            
            int current_year = LocalDate.now().getYear();
            for(Customer c: customers){
                int birth_year = Integer.valueOf(c.getDob().split("-")[0]);
                int age = current_year - birth_year;
                boolean above_50 = true;
                
                for(int i=0; i<min.length; i++){
                    if(age>=min[i] && age<=max[i]){
                        String key = Integer.toString(min[i]) + "-" + Integer.toString(max[i]);
                        ages.put(key, ages.get(key)+1);
                        above_50 = false;
                    }
                }
                
                if(above_50){
                    ages.put(">50", ages.get(">50")+1);
                }
            }
            
            String biggest_age = "None";
            if(ages.size() > 0){
                biggest_age = Collections.max(ages.entrySet(), Comparator.comparingInt(Map.Entry::getValue)).getKey();
            }else{
                ages.put("None", 0);
            }

            Map<String, Integer> genders = new HashMap<>();
            genders.put("Male", 0);
            genders.put("Female", 0);
            
            for(Customer c: customers){
                for(Map.Entry<String, Integer> g: genders.entrySet()){
                    String key = g.getKey();
                    if(key.equals(c.getGender())){
                        genders.put(key, genders.get(key)+1);
                    }
                }
            }
            String biggest_gender = "None";
            if(genders.size() > 0){
                biggest_gender = Collections.max(genders.entrySet(), Comparator.comparingInt(Map.Entry::getValue)).getKey();
            }else{
                genders.put("None", 0);
            }
            
            request.setAttribute("customers", customers);
            request.setAttribute("unique_customers", unique_customers);
            request.setAttribute("total_sales", total_sales);
            request.setAttribute("total_rated_sales", total_rated_sales);
            request.setAttribute("ages", ages);
            request.setAttribute("genders", genders);
            request.setAttribute("biggest_age", biggest_age);
            request.setAttribute("biggest_gender", biggest_gender);
            request.setAttribute("avg_purchase", avg_purchase);
            request.setAttribute("avg_feedback", avg_feedback);
            request.setAttribute("type", type);
            request.getRequestDispatcher("customer_reports.jsp").forward(request, response);
        
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

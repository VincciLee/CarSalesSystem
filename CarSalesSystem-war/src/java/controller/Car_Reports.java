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
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cars;
import model.CarsFacade;
import model.Sales;
import model.SalesFacade;
import model.Staff;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Car_Reports", urlPatterns = {"/Car_Reports"})
public class Car_Reports extends HttpServlet {

    @EJB
    private SalesFacade salesFacade;

    @EJB
    private CarsFacade carsFacade;

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
            
            String year = request.getParameter("year");
            String month = request.getParameter("month"); 
            
            List<Sales> sales = salesFacade.getSalesReports(year, month);
            List<Cars> cars =  new ArrayList<>();
            List<String> models = new ArrayList<>();
            Map<String, Integer> model_counts = new HashMap<String, Integer>();
            
            for(Sales s:sales){
                Cars found = carsFacade.find(s.getCar_id());
                cars.add(found);
                models.add(found.getModel());
            }
            List<String> unique_models = carsFacade.getCarModels(models);
            List<Sales> rated_sales = salesFacade.getRatedSales(year, month);
            Map<String, Integer> model_reviews = new HashMap<String, Integer>();
            Map<String, Double> model_ratings = new HashMap<String, Double>();
            
            String highest_count = "None";
            String lowest_count = "None";
            String highest_ratings = "None";
            String lowest_ratings = "None";
            
            for(String m: unique_models){
                DecimalFormat df = new DecimalFormat("#.##");
                int count = 0;
                List<Sales> model_rates = new ArrayList<>();
                double total_ratings = 0;
                int total_reviews = 0;
                double avg_ratings = 0;
                
                for(Cars c: cars){
                    if(m.equals(c.getModel())){
                        count++;
                    }
                }
                if (count > 0){
                    model_counts.put(m, count);
                }
                
                for(Sales s: rated_sales){
                    Cars car = carsFacade.find(s.getCar_id());
                    if(m.equals(car.getModel())){
                        model_rates.add(s);
                        total_ratings += s.getCustomer_rating();
                    }
                }
                if (model_rates.size() > 0){
                    total_reviews = model_rates.size();
                    total_ratings = Double.valueOf(total_ratings);
                    avg_ratings = Double.valueOf(df.format(total_ratings/Double.valueOf(model_rates.size())));
                    model_reviews.put(m, total_reviews);
                    model_ratings.put(m, avg_ratings);
                } 
            }
            if(model_counts.size() > 0){
                highest_count = Collections.max(model_counts.entrySet(), Comparator.comparingInt(Map.Entry::getValue)).getKey();
                lowest_count = Collections.min(model_counts.entrySet(), Comparator.comparingInt(Map.Entry::getValue)).getKey();
            }
            else{
                model_counts.put("None", 0);
            }
            if(model_ratings.size() > 0){
                highest_ratings = Collections.max(model_ratings.entrySet(), Comparator.comparingDouble(Map.Entry::getValue)).getKey();
                lowest_ratings = Collections.min(model_ratings.entrySet(), Comparator.comparingDouble(Map.Entry::getValue)).getKey();
            }else{
                model_ratings.put("None", 0.0);
            }
            
            System.out.println("highest_count: "+highest_count);
            System.out.println("lowest_count: "+lowest_count);
                       
            if(month.equals("0")){
                request.setAttribute("display_type", "year");
                request.setAttribute("month", "0");
            }else{
                request.setAttribute("display_type", "month");
                request.setAttribute("month", month);
            }
            
            request.setAttribute("year", year);
            request.setAttribute("cars", cars);
            request.setAttribute("sales", sales);
            request.setAttribute("unique_models", unique_models);
            request.setAttribute("model_counts", model_counts);
            request.setAttribute("model_reviews", model_reviews);
            request.setAttribute("model_ratings", model_ratings);
            request.setAttribute("highest_count", highest_count);
            request.setAttribute("highest_ratings", highest_ratings);
            request.setAttribute("lowest_count", lowest_count);
            request.setAttribute("lowest_ratings", lowest_ratings);
            request.getRequestDispatcher("car_reports.jsp").forward(request, response);
        
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

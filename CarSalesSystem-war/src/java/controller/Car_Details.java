/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cars;
import model.CarsFacade;
import model.Customer;
import model.CustomerFacade;
import model.Sales;
import model.SalesFacade;
import model.Salesmen;
import model.SalesmenFacade;
import model.Staff;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Car_Details", urlPatterns = {"/Car_Details"})
public class Car_Details extends HttpServlet {

    @EJB
    private SalesmenFacade salesmenFacade;

    @EJB
    private CustomerFacade customerFacade;

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
            Integer user_id = null;

            try{
                if(session.getAttribute("login_role").equals("customer")){
                    Customer user = (Customer)session.getAttribute("login_user");
                    user_id = user.getId();
                }else if(session.getAttribute("login_role").equals("salesman")){
                    Salesmen user = (Salesmen)session.getAttribute("login_user");
                    user_id = user.getId();
                }else if(session.getAttribute("login_role").equals("staff")) {
                    Staff user = (Staff)session.getAttribute("login_user");
                    user_id = user.getId();
                }
            }catch(Exception e){
                request.setAttribute("error", "Please login the system!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            Integer car_id = Integer.valueOf(request.getParameter("id"));
            String car_status = request.getParameter("car_status");
            
            Cars found = carsFacade.find(car_id);
            request.setAttribute("car", found);
            
            String model = found.getModel();
            List<Sales> rated_sales = salesFacade.getRatedPurchases();
            List<Sales> model_rates = new ArrayList<>();
            int total_ratings = 0;
            int total_reviews = 0;
            int avg_ratings = 0;
            for(Sales s: rated_sales){
                Cars car = carsFacade.find(s.getCar_id());
                if(model.equals(car.getModel())){
                    model_rates.add(s);
                    total_ratings += s.getCustomer_rating();
                }
            }
            if (model_rates.size() > 0){
                total_reviews = model_rates.size();
                avg_ratings = total_ratings/total_reviews;
            } 
            
            if(!car_status.equals("Available")){
                
                if(car_status.equals("Completed")){
                    Sales sales = salesFacade.get_by_carId(car_id, "Completed");
                    Customer customer = customerFacade.find(sales.getCustomer_id());
                    Salesmen salesman = salesmenFacade.find(sales.getSalesman_id());
                    
                    request.setAttribute("sales", sales);
                    request.setAttribute("customer", customer);
                    request.setAttribute("salesman", salesman);
                }else if(car_status.equals("Booked_a")){
                    Sales sales = salesFacade.get_by_carId(car_id, "Pending Acceptance");
                    Customer customer = customerFacade.find(sales.getCustomer_id());
                    request.setAttribute("sales", sales);
                    request.setAttribute("customer", customer);
                }
                
            }
            
            request.setAttribute("car_status", car_status);
            request.setAttribute("avg_ratings", avg_ratings);
            request.setAttribute("total_reviews", total_reviews);
            request.getRequestDispatcher("car_details.jsp").forward(request, response);
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

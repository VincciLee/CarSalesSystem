/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
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

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Book_Car", urlPatterns = {"/Book_Car"})
public class Book_Car extends HttpServlet {

    @EJB
    private CustomerFacade customerFacade;

    @EJB
    private CarsFacade carsFacade;

    @EJB
    private SalesFacade salesFacade;

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
            Customer user = (Customer)session.getAttribute("login_user");
            if(user == null){
                request.setAttribute("error", "Please login the system!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            if (user.getApproval_status().equals("Incomplete")){
                request.setAttribute("error", "Please complete yout account details!");
                request.getRequestDispatcher("Edit_Profile").forward(request, response);
                return;
            }
                    
            Integer user_id = user.getId();
            Integer car_id = Integer.valueOf(request.getParameter("id"));
            LocalDate date = LocalDate.now();
            
            Sales new_sales = new Sales(car_id, user_id, date);
            salesFacade.create(new_sales);
            
            Cars car = carsFacade.find(car_id);
            car.setStatus("Booked_a");
            carsFacade.edit(car);
            
            request.setAttribute("car_status", "Available");
            request.setAttribute("success", "Car Booked! Salesman will contact you after accepting the booking.");
            request.getRequestDispatcher("View_Car_List").forward(request, response);
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

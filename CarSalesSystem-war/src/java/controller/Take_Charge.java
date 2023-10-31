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
import model.Sales;
import model.SalesFacade;
import model.Salesmen;
import model.SalesmenFacade;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Take_Charge", urlPatterns = {"/Take_Charge"})
public class Take_Charge extends HttpServlet {

    @EJB
    private SalesmenFacade salesmenFacade;

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
            Salesmen user = (Salesmen)session.getAttribute("login_user");
            
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
            Integer sales_id = Integer.valueOf(request.getParameter("id"));
            LocalDate date = LocalDate.now();
            
            Sales sales = salesFacade.find(sales_id);
            sales.setSalesman_id(user_id);
            sales.setAccepted_date(date);
            sales.setStatus("Pending Payment");
            salesFacade.edit(sales);
            
            Cars car = carsFacade.find(sales.getCar_id());
            car.setStatus("Booked_b");
            carsFacade.edit(car);
            
            request.getRequestDispatcher("View_Car_List?car_status=Booked_a").forward(request, response);
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

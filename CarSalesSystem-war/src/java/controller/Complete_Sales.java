/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
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
import model.Sales;
import model.SalesFacade;
import model.Salesmen;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Complete_Sales", urlPatterns = {"/Complete_Sales"})
public class Complete_Sales extends HttpServlet {

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
                Salesmen user = (Salesmen)session.getAttribute("login_user");
                user_id = user.getId();
            }catch(Exception e){
                request.setAttribute("error", "Please login the system!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            String status = request.getParameter("status");
            Integer sales_id = Integer.valueOf(request.getParameter("id"));
            LocalDate date = LocalDate.now();
            
            Sales new_sales = salesFacade.find(sales_id);
            new_sales.setCompleted_date(date);
            new_sales.setStatus("Completed");
            salesFacade.edit(new_sales);
            
            Cars car = carsFacade.find(new_sales.getCar_id());
            car.setStatus("Completed");
            carsFacade.edit(car);
            
            List<Sales> sales = salesFacade.getAllSales(user_id, status);
            System.out.println("sales: "+sales);
            request.setAttribute("sales", sales);
            request.setAttribute("status", status);
            request.setAttribute("success", "Payment completed!");
            request.getRequestDispatcher("Sales_History").forward(request, response);
            
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

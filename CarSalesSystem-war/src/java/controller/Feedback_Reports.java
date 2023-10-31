/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "Feedback_Reports", urlPatterns = {"/Feedback_Reports"})
public class Feedback_Reports extends HttpServlet {

    @EJB
    private CustomerFacade customerFacade;

    @EJB
    private SalesFacade salesFacade;

    @EJB
    private SalesmenFacade salesmenFacade;

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
            
            List<Sales> sales = salesFacade.getRatedPurchases();
            Map<Integer, String> salesmen = new HashMap<Integer, String>();
            Map<Integer, String> customers = new HashMap<Integer, String>();
            
            for (Sales s: sales){
                Salesmen salesman = salesmenFacade.find(s.getSalesman_id());
                salesmen.put(s.getSalesman_id(), salesman.getName());
                Customer customer = customerFacade.find(s.getCustomer_id());
                customers.put(s.getCustomer_id(), customer.getName());
            }
            System.out.println("sales: "+sales);
            System.out.println("salesmen: "+salesmen);
            System.out.println("customers: "+customers);
            
            request.setAttribute("sales", sales);
            request.setAttribute("salesmen", salesmen);
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("feedback_reports.jsp").forward(request, response);
            
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

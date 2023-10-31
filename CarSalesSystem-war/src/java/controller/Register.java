/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.ejb.EJB;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Customer;
import model.CustomerFacade;
import model.Salesmen;
import model.SalesmenFacade;
import model.Staff;
import model.StaffFacade;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {

    @EJB
    private StaffFacade staffFacade;

    @EJB
    private SalesmenFacade salesmenFacade;

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
            String role = request.getParameter("role");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String password2 = request.getParameter("password2");
            
            if(!password.equals(password2)){
                request.setAttribute("error", "The passwords are different. Please try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }else{
                if(role.equals("Customer")){
                    Customer found = customerFacade.findEmail(email);
                    System.out.println("Customer found: "+found);
                    
                    if(found != null){
                        request.setAttribute("error", "The email has been registered.");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                    }else{
                        Customer new_acc = new Customer(name, password, email);
                        customerFacade.create(new_acc);
                        System.out.println("Customer Registering");
                        request.setAttribute("success", "Account registred! Please wait for managing staff to approve.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                }
                else if(role.equals("Salesman")){
                    Salesmen found = salesmenFacade.findEmail(email);
                    System.out.println("Salesman found: "+found);
                    
                    if(found != null){
                        request.setAttribute("error", "The email has been registered.");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                    }else{
                        Salesmen new_acc = new Salesmen(name, password, email);
                        salesmenFacade.create(new_acc);
                        System.out.println("Salesman Registering");
                        request.setAttribute("success", "Account registred! Please wait for managing staff to approve.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                }else{
                    System.out.println("Account created failed!");
                        request.setAttribute("error", "The account cannot be created!");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }
            }
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

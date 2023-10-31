/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
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
import model.Salesmen;
import model.SalesmenFacade;
import model.Staff;
import model.StaffFacade;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    @EJB
    private CarsFacade carsFacade;

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
            HttpSession session = null;
            String role = request.getParameter("role");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            System.out.println("role" + role);
            
            try{
                System.out.println("User role "+role+" logging in!");
                
                if(role.equals("customer")){
                    Customer found = customerFacade.findEmail(email);
                    
                    if(found != null){
                        if(password.equals(found.getPassword())){
                            if(found.getApproval_status().equals("Pending")){
                                request.setAttribute("error", "This account is not activated. Please contact managing staff to approve!");
                                request.getRequestDispatcher("login.jsp").forward(request, response); 
                            }else if (found.getApproval_status().equals("Deleted")){
                                throw new Exception();
                            }else{
                                session = request.getSession();
                                session.setAttribute("login_user", found);
                                session.setAttribute("login_role", role);
                                System.out.println("Customer has login!");
                            }
                        }else{
                            throw new Exception();
                        }
                    }else{
                        throw new Exception();
                    }
                }else if(role.equals("salesman")){
                    Salesmen found = salesmenFacade.findEmail(email);
                    
                    if(found != null){
                        if(password.equals(found.getPassword())){
                            if(found.getApproval_status().equals("Pending")){
                                request.setAttribute("error", "This account is not activated. Please contact managing staff to approve!");
                                request.getRequestDispatcher("login.jsp").forward(request, response); 
                            }else if (found.getApproval_status().equals("Deleted")){
                                throw new Exception();
                            }else{
                                session = request.getSession();
                                session.setAttribute("login_user", found);
                                session.setAttribute("login_role", role);
                                System.out.println("Salesmen has login!");
                            }

                        }else{
                            throw new Exception();
                        }
                    }else{
                        throw new Exception();
                    }
                }else{
                    Staff found = staffFacade.findEmail(email);
                    
                    if(found != null){
                        if(password.equals(found.getPassword())){
                            session = request.getSession();
                            session.setAttribute("login_user", found);
                            session.setAttribute("login_role", role);
                            System.out.println("Managing Staff has login!");
                        }else{
                            throw new Exception();
                        }
                    }else{
                        throw new Exception();
                    }
                }
                
                System.out.println("Session added: "+ session.getAttribute("login_user")+ session.getAttribute("login_role"));
                request.setAttribute("success", "Login successfully! "); 
                request.getRequestDispatcher("Home").forward(request, response);   
            }
            catch(Exception e){
                System.out.println(e.getMessage());
                System.out.println("Wrong credentials!");
                request.setAttribute("error", "The login credentials are incorrect. Please try again. ");
                request.getRequestDispatcher("login.jsp").forward(request, response);   
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

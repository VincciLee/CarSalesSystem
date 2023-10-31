/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
@WebServlet(name = "Update_Password", urlPatterns = {"/Update_Password"})
public class Update_Password extends HttpServlet {

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
            String type = request.getParameter("type");
            String role = request.getParameter("role");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String password2 = request.getParameter("password2");
            String redirect_success = "";
            String redirect_failed = "";
            
            System.out.println("type: "+type);
            System.out.println("role: "+role);
            System.out.println("email: "+email);
            System.out.println("password: "+password);
            System.out.println("password2: "+password2);
            
            if(type.equals("login")){
                HttpSession session = request.getSession(false);
                try{
                    Staff user = (Staff)session.getAttribute("login_user");
                }catch(Exception e){
                    request.setAttribute("error", "Please login the system!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                } 
                
                
                int id = Integer.valueOf(request.getParameter("id"));
                String status = request.getParameter("status");
                
                redirect_success = "Manage_Accounts?role="+role+"&status="+status;
                redirect_failed = "Change_Password?id="+id+"&role="+role+"&type=login&status="+status;
            }else if(type.equals("default")){
                redirect_success = "login.jsp";
                redirect_failed = "change_password.jsp?type="+type;
            }
            
            if(!password.equals(password2)){
                request.setAttribute("error", "The passwords are different. Please try again.");
                request.getRequestDispatcher(redirect_failed).forward(request, response);
                return;
            }else{
                if(role.equals("customer")){
                    Customer found = customerFacade.findEmail(email);
                    System.out.println("Customer found: "+found);
                    
                    if(found == null){
                        request.setAttribute("error", "The customer email does not exist!");
                        request.getRequestDispatcher(redirect_failed).forward(request, response);
                        return;
                    }else{
                        found.setPassword(password);
                        customerFacade.edit(found);
                    }
                }
                else if(role.equals("salesman")){
                    Salesmen found = salesmenFacade.findEmail(email);
                    System.out.println("Salesman found: "+found);
                    
                    if(found == null){
                        request.setAttribute("error", "The salesman email does not exist!");
                        request.getRequestDispatcher(redirect_failed).forward(request, response);
                        return;
                    }else{
                        found.setPassword(password);
                        salesmenFacade.edit(found);
                    }
                }else if(role.equals("staff")){
                    Staff found = staffFacade.findEmail(email);
                    System.out.println("Staff found: "+found);
                    
                    if(found == null){
                        request.setAttribute("error", "The staff email does not exist!");
                        request.getRequestDispatcher(redirect_failed).forward(request, response);
                        return;
                    }else{
                        found.setPassword(password);
                        staffFacade.edit(found);
                    }
                }
            }
            
            request.setAttribute("success", "Password updated!");
            request.getRequestDispatcher(redirect_success).forward(request, response);
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

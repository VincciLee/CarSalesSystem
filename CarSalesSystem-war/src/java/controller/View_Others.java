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
@WebServlet(name = "View_Others", urlPatterns = {"/View_Others"})
public class View_Others extends HttpServlet {

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
            HttpSession session = request.getSession(false);
            
            try{
                if(session.getAttribute("login_role").equals("customer")){
                    Customer user = (Customer)session.getAttribute("login_user");
                }else if (session.getAttribute("login_role").equals("salesman")){
                    Salesmen user = (Salesmen)session.getAttribute("login_user");
                }else if (session.getAttribute("login_role").equals("staff")){
                    Staff user = (Staff)session.getAttribute("login_user");
                }
            }catch(Exception e){
                request.setAttribute("error", "Please login the system!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            Integer id = Integer.valueOf(request.getParameter("id"));
            String role = request.getParameter("role");
            request.setAttribute("role", role);
            
            if (role.equals("customer")){
                Customer user = customerFacade.find(id);
                request.setAttribute("user", user);
            }else if (role.equals("salesman")){
                Salesmen user = salesmenFacade.find(id);
                request.setAttribute("user", user);
            }else if (role.equals("staff")){
                Staff user = staffFacade.find(id);
                request.setAttribute("user", user);
            }

            request.getRequestDispatcher("view_others.jsp").forward(request, response);
            
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

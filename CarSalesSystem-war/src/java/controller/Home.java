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
import model.Customer;
import model.CustomerFacade;
import model.Sales;
import model.SalesFacade;
import model.Salesmen;
import model.SalesmenFacade;
import model.Staff;
import model.StaffFacade;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Home", urlPatterns = {"/Home"})
public class Home extends HttpServlet {

    @EJB
    private CarsFacade carsFacade;

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
            Integer user_id = null;

            try{
                if(session.getAttribute("login_role").equals("customer")){
                    Customer user = (Customer)session.getAttribute("login_user");
                    user_id = user.getId();
                    
                    Customer found = customerFacade.find(user_id);
                    if (found.getApproval_status().equals("Incomplete")){
                        request.setAttribute("error", "Please complete yout account details!");
                        request.getRequestDispatcher("Edit_Profile").forward(request, response);
                        return;
                    }
                }else if(session.getAttribute("login_role").equals("salesman")){
                    Salesmen user = (Salesmen)session.getAttribute("login_user");
                    user_id = user.getId();
                    
                    Salesmen found = salesmenFacade.find(user_id);
                    if (found.getApproval_status().equals("Incomplete")){
                        request.setAttribute("error", "Please complete yout account details!");
                        request.getRequestDispatcher("Edit_Profile").forward(request, response);
                        return;
                    }
                }else if(session.getAttribute("login_role").equals("staff")){
                    Staff user = (Staff)session.getAttribute("login_user");
                }
            }catch(Exception e){
                System.out.println("[Home]:: Unauthorised access detected.");
                request.setAttribute("error", "Please login the system!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            List<Cars> cars = carsFacade.getCarList("");
            if (cars.size() < 4){
                session.setAttribute("size", cars.size()-1); 
            }else{
                session.setAttribute("size", 2);
            }
            session.setAttribute("cars", cars); 
            System.out.println("[cars]:: "+cars);
            
            int current_year = LocalDate.now().getYear();
            session.setAttribute("current_year", current_year); 
            request.setAttribute("success", request.getParameter("success")); 
            request.getRequestDispatcher("home.jsp").forward(request, response);
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

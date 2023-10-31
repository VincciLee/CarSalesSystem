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
import model.StaffFacade;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Manage_Accounts", urlPatterns = {"/Manage_Accounts"})
public class Manage_Accounts extends HttpServlet {

    @EJB
    private SalesFacade salesFacade;

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
                Staff user = (Staff)session.getAttribute("login_user");
            }catch(Exception e){
                request.setAttribute("error", "Please login the system!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }  
            
            String role = request.getParameter("role");
            String status = request.getParameter("status");

            request.setAttribute("role", role);
            request.setAttribute("status", status);

            if (role.equals("customer")){
                List<Customer> accounts = customerFacade.getAllAccounts(status);
                Map<Integer, Integer> acc_sales = new HashMap<Integer, Integer>();
                for(Customer acc: accounts){
                    List<Sales> data = salesFacade.getAllPurchases(acc.getId(), "All");
                    acc_sales.put(acc.getId(), data.size());
                }
                
                request.setAttribute("accounts", accounts);
                request.setAttribute("acc_sales", acc_sales);
                System.out.println("acc_sales: "+acc_sales);
                request.getRequestDispatcher("manage_accounts.jsp").forward(request, response);
            }else if (role.equals("salesman")){
                List<Salesmen> accounts = salesmenFacade.getAllAccounts(status);
                Map<Integer, Integer> acc_sales = new HashMap<Integer, Integer>();
                for(Salesmen acc: accounts){
                    List<Sales> data = salesFacade.getAllSales(acc.getId(), "All");
                    acc_sales.put(acc.getId(), data.size());
                }
                
                request.setAttribute("accounts", accounts);
                request.setAttribute("acc_sales", acc_sales);
                System.out.println("acc_sales: "+acc_sales);
                request.getRequestDispatcher("manage_accounts.jsp").forward(request, response);
            }else if (role.equals("staff")){
                List<Staff> accounts = staffFacade.findAll();
                request.setAttribute("accounts", accounts);
                request.getRequestDispatcher("manage_accounts.jsp").forward(request, response);
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

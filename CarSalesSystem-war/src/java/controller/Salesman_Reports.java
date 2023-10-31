/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.Month;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Sales;
import model.SalesFacade;
import model.Salesmen;
import model.SalesmenFacade;
import model.Staff;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Salesman_Reports", urlPatterns = {"/Salesman_Reports"})
public class Salesman_Reports extends HttpServlet {

    @EJB
    private SalesmenFacade salesmenFacade;

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
            try{
                Staff user = (Staff)session.getAttribute("login_user");
            }catch(Exception e){
                request.setAttribute("error", "Please login the system!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            } 
            
            String year = request.getParameter("year");
            String month = request.getParameter("month"); 
            
            List<Salesmen> salesmen = salesmenFacade.getAllAccounts("Completed");
            Map<String, Integer> sales_count = new HashMap<String, Integer>();
            Map<String, Integer> cancel_count = new HashMap<String, Integer>();
            int total_sales = 0;
            String highest_sales = "None"; 
            String lowest_sales = "None"; 
            String highest_cancel = "None";
            
            for (Salesmen s: salesmen){
                List<Sales> sales = salesFacade.getSalesmanReports(year, month, s.getId(), "Completed");
                List<Sales> cancel = salesFacade.getSalesmanReports(year, month, s.getId(), "Canceled");
                if(sales.size() > 0){
                    sales_count.put(s.getName(), sales.size());
                    total_sales += sales.size();
                }
                    
                if (cancel.size() > 0){
                    cancel_count.put(s.getName(), cancel.size());
                }
            }
            
            if(sales_count.size() > 0){
                highest_sales = Collections.max(sales_count.entrySet(), Comparator.comparingInt(Map.Entry::getValue)).getKey();
                lowest_sales = Collections.min(sales_count.entrySet(), Comparator.comparingInt(Map.Entry::getValue)).getKey();
            }else{
                sales_count.put("None", 0);
            }
            if(cancel_count.size() > 0){
                highest_cancel = Collections.max(cancel_count.entrySet(), Comparator.comparingInt(Map.Entry::getValue)).getKey();
            }else{
                cancel_count.put("None", 0);
            }
            int avg_sales = total_sales/salesmen.size();
            
            if(month.equals("0")){
                request.setAttribute("display_type", "year");
                request.setAttribute("month", "0");
            }else{
                int days = LocalDate.of(Integer.valueOf(year), Integer.valueOf(month), 1).lengthOfMonth();
                request.setAttribute("display_type", "month");
                request.setAttribute("month", month);
                request.setAttribute("days", days);
                System.out.println("days: "+days);
            }
            
            request.setAttribute("year", year);
            request.setAttribute("sales_count", sales_count);
            request.setAttribute("cancel_count", cancel_count);
            request.setAttribute("highest_sales", highest_sales);
            request.setAttribute("lowest_sales", lowest_sales);
            request.setAttribute("highest_cancel", highest_cancel);
            request.setAttribute("avg_sales", avg_sales);
            request.getRequestDispatcher("salesman_reports.jsp").forward(request, response);
        
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

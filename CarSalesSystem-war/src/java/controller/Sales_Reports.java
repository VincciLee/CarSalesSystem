/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
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
import model.Staff;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Sales_Reports", urlPatterns = {"/Sales_Reports"})
public class Sales_Reports extends HttpServlet {

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
            try{
                Staff user = (Staff)session.getAttribute("login_user");
            }catch(Exception e){
                request.setAttribute("error", "Please login the system!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            } 
            
            String year = request.getParameter("year");
            String month = request.getParameter("month"); 
            
            List<Sales> sales = salesFacade.getSalesReports(year, month);
            System.out.println("completed sales: "+sales);
            Hashtable<String, Cars> cars = new Hashtable<String, Cars>();
            float total_sales = 0;
            
            for(Sales s: sales){
                cars.put(s.getCar_id().toString(), carsFacade.find(s.getCar_id()));
                total_sales += cars.get(s.getCar_id().toString()).getPrice();
            }
            
            
            int current_year = LocalDate.now().getYear();
            int current_month = LocalDate.now().getMonthValue();
            int current_day = LocalDate.now().getDayOfMonth();
            
            if(month.equals("0")){
                int max_month = 12;
                if(Integer.valueOf(year) == current_year){
                    max_month = current_month;
                }
                
                request.setAttribute("display_type", "year");
                request.setAttribute("month", "0");
                request.setAttribute("max_month", max_month);
                System.out.println("max_month: "+max_month);
            }else{
                int days = LocalDate.of(Integer.valueOf(year), Integer.valueOf(month), 1).lengthOfMonth();
                if (Integer.valueOf(year) == current_year && Integer.valueOf(month) == current_month){
                    days = current_day;
                }
                
                request.setAttribute("display_type", "month");
                request.setAttribute("month", month);
                request.setAttribute("days", days);
            }
            
            request.setAttribute("year", year);
            request.setAttribute("cars", cars);
            request.setAttribute("sales", sales);
            request.setAttribute("total_sales", total_sales);
            request.getRequestDispatcher("sales_reports.jsp").forward(request, response);
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

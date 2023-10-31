/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Cars;
import model.CarsFacade;
import model.Salesmen;
import model.Staff;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Register_Car", urlPatterns = {"/Register_Car"})
@MultipartConfig
public class Register_Car extends HttpServlet {

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
            
            try{
                if(session.getAttribute("login_role").equals("salesman")){
                    Salesmen user = (Salesmen)session.getAttribute("login_user");
                }else if(session.getAttribute("login_role").equals("staff")) {
                    Staff user = (Staff)session.getAttribute("login_user");
                }
            }catch(Exception e){
                request.setAttribute("error", "Please login the system!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            String rootpath = System.getProperty("catalina.base") + "/docroot/";
            String path = rootpath + "CarSalesSystem\\images";
            Part img = request.getPart("car_img");
            String img_name = img.getSubmittedFileName();
            String brand = request.getParameter("brand");
            String model = request.getParameter("model");
            String description = request.getParameter("description");
            Integer publish_year = Integer.valueOf(request.getParameter("year"));
            String body_type = request.getParameter("body_type");
            String transmission = request.getParameter("transmission");
            String fuel = request.getParameter("fuel");
            Integer seat = Integer.valueOf(request.getParameter("seat"));
            int price = Integer.valueOf(request.getParameter("price"));
            
            File file =  new File(path);
            if(!file.exists()){
                file.mkdirs();
            }
            
            OutputStream outstr = null;
            InputStream filecontent = null;

            try {
                outstr = new FileOutputStream(new File(path + File.separator + img_name));
                filecontent = img.getInputStream();
                StringBuilder sb = new StringBuilder();
                int read = 0;
                final byte[] bytes = new byte[1024];

                while ((read = filecontent.read(bytes)) != -1) {
                    sb.append(bytes);
                    outstr.write(bytes, 0, read);
                }
                
                outstr.close();
                filecontent.close();
                
                Cars new_car = new Cars(brand, model, publish_year, description, body_type, transmission, fuel, seat, price, img_name);
                carsFacade.create(new_car);
            } catch (Exception e) {
                System.out.println("Failed to add car due to: "+e);
                request.setAttribute("error", "Failed to add car!");
                request.getRequestDispatcher("Add_Car").forward(request, response);
            }
                
            System.out.println("New car added!");
            request.setAttribute("success", "New car added successfully!");
            request.getRequestDispatcher("View_Car_List?car_status=Available").forward(request, response);
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

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
import java.time.LocalDate;
import java.util.regex.Pattern;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
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
@WebServlet(name = "Save_Profile", urlPatterns = {"/Save_Profile"})
@MultipartConfig
public class Save_Profile extends HttpServlet {

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
            Integer user_id = null;

            try{
                if(session.getAttribute("login_role").equals("customer")){
                    Customer user = (Customer)session.getAttribute("login_user");
                    user_id = user.getId();
                }else if(session.getAttribute("login_role").equals("salesman")){
                    Salesmen user = (Salesmen)session.getAttribute("login_user");
                    user_id = user.getId();
                }else if(session.getAttribute("login_role").equals("staff")) {
                    Staff user = (Staff)session.getAttribute("login_user");
                    user_id = user.getId();
                }
            }catch(Exception e){
                System.out.println("[Edit_Profile]:: Authorised access detected.");
                System.out.println("ERROR:: "+e);
                request.setAttribute("error", "Please login the system!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            String rootpath = System.getProperty("catalina.base") + "/docroot/";
            String path = rootpath + "CarSalesSystem\\images";
            System.out.println("path: "+path);
            Part img = request.getPart("image");
            String img_name = img.getSubmittedFileName();
            String name = request.getParameter("full_name");
            String username = request.getParameter("username");
            String ic = request.getParameter("ic");
            String dob = request.getParameter("dob");            
            String phone = request.getParameter("phone");            
            String gender = request.getParameter("gender");

            LocalDate bday = LocalDate.parse(dob);
            int byear = bday.getYear();
            int current_year = LocalDate.now().getYear();
            int age = current_year - byear;
            char[] ch = name.toCharArray();
            
            for (char c : ch) {
               if(Character.isDigit(c)) {
                    request.setAttribute("error", "Full name must not contain numbers!");
                    request.getRequestDispatcher("Edit_Profile").forward(request, response);
                    return;
               }
            }
            
            if (!Pattern.matches("[0-9]{6}-[0-9]{2}-[0-9]{4}", ic)){
                request.setAttribute("error", "IC number must follow the format 123456-12-1234!");
                request.getRequestDispatcher("Edit_Profile").forward(request, response);
                return;
            }
                     
            if (age < 21){
                request.setAttribute("error", "User must be at least 21 years old!");
                request.getRequestDispatcher("Edit_Profile").forward(request, response);
                return;
            }
            
            if (!Pattern.matches("[0-9]{3}-[0-9]{7,8}", phone)){
                request.setAttribute("error", "Phone number must follow the format 012-1234567 or 012-12345678!");
                request.getRequestDispatcher("Edit_Profile").forward(request, response);
                return;
            }
               
            if (img_name == null || img_name.equals("")){
                if(session.getAttribute("login_role").equals("customer")){
                    Customer user = (Customer)session.getAttribute("login_user");
                    img_name = user.getProfile();
                }else if(session.getAttribute("login_role").equals("salesman")){
                    Salesmen user = (Salesmen)session.getAttribute("login_user");
                    img_name = user.getProfile();
                }else if(session.getAttribute("login_role").equals("staff")) {
                    Staff user = (Staff)session.getAttribute("login_user");
                    img_name = user.getProfile();
                }
            }
            else {
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
                } catch (Exception e) {
                    System.out.println("Failed to update details due to: "+e);
                    request.setAttribute("error", "Failed to update details!");
                    request.getRequestDispatcher("Edit_Profile").forward(request, response);
                    return;
                } 
            }
            
            if(session.getAttribute("login_role").equals("customer")){
                Customer user = (Customer)session.getAttribute("login_user");
                user.updateDetails(name, username, ic, dob, phone, gender, img_name);
                customerFacade.edit(user);
            }else if(session.getAttribute("login_role").equals("salesman")){
                Salesmen user = (Salesmen)session.getAttribute("login_user");
                user.updateDetails(name, username, ic, dob, phone, gender, img_name);
                salesmenFacade.edit(user);
            }else if(session.getAttribute("login_role").equals("staff")) {
                Staff user = (Staff)session.getAttribute("login_user");
                user.updateDetails(name, username, ic, dob, phone, gender, img_name);
                staffFacade.edit(user);
            }
            
            request.setAttribute("success", "Information updated!");
            request.getRequestDispatcher("User_Profile").forward(request, response);
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

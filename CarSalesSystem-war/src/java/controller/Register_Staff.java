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
import model.Staff;
import model.StaffFacade;

/**
 *
 * @author Vincci
 */
@WebServlet(name = "Register_Staff", urlPatterns = {"/Register_Staff"})
@MultipartConfig
public class Register_Staff extends HttpServlet {

    @EJB
    private StaffFacade staffFacade;

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
             
            String rootpath = System.getProperty("catalina.base") + "/docroot/";
            String path = rootpath + "CarSalesSystem\\images";
            Part img = request.getPart("image");
            String img_name = img.getSubmittedFileName();
            String name = request.getParameter("full_name");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String password2 = request.getParameter("password2");
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
                    request.getRequestDispatcher("Add_Staff").forward(request, response);
                    return;
               }
            }
            
            if (!Pattern.matches("[0-9]{6}-[0-9]{2}-[0-9]{4}", ic)){
                request.setAttribute("error", "IC number must follow the format 123456-12-1234!");
                    request.getRequestDispatcher("Add_Staff").forward(request, response);
                return;
            }
                        
            if (age < 21){
                request.setAttribute("error", "User must be at least 21 years old!");
                request.getRequestDispatcher("Add_Staff").forward(request, response);
                return;
            }
            
            if (!Pattern.matches("[0-9]{3}-[0-9]{7,8}", phone)){
                request.setAttribute("error", "Phone number must follow the format 012-1234567 or 012-12345678!");
                    request.getRequestDispatcher("Add_Staff").forward(request, response);
                return;
            }
              
            if(!password.equals(password2)){
                request.setAttribute("error", "The passwords are different. Please try again.");
                request.getRequestDispatcher("Add_Staff").forward(request, response);
            }else{
                Staff found = staffFacade.findEmail(email);
                
                if(found != null){
                    request.setAttribute("error", "The email has been registered.");
                    request.getRequestDispatcher("Add_Staff").forward(request, response);
                }
                
                if(!img_name.equals("") && img_name != null){
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
                        System.out.println("Failed to register staff due to: "+e);
                        request.setAttribute("error", "Failed to register staff!");
                        request.getRequestDispatcher("Add_Staff").forward(request, response);
                        return;
                    } 
                }
                if(img_name.equals("") || img_name != null){
                    Staff new_acc = new Staff(name, username, password, email, ic, dob, phone, gender);
                    staffFacade.create(new_acc);
                }else{
                    Staff new_acc = new Staff(name, username, password, email, ic, dob, phone, gender, img_name);
                    staffFacade.create(new_acc);
                }
                System.out.println("Staff Registering");
                request.setAttribute("success", "Staff added!");
                request.getRequestDispatcher("Manage_Accounts?role=staff&status=All").forward(request, response);
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

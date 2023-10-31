<%-- 
    Document   : banner
    Created on : Feb 26, 2023, 11:45:14 AM
    Author     : Vincci
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script> 
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light" style="background-color: #85cfce; height: 10vh">
          <div class="container-fluid">
            <a class="navbar-brand" href="Home">
                <img src="images/logo.png" alt="Logo" width="70" height="60" class="d-inline-block align-text-top">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
              <ul class="navbar-nav">
                <li class="nav-item ">
                  <a class="nav-link fs-5" href="Home">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fs-5" href="User_Profile">Profile</a>
                </li>
                <c:if test="${ sessionScope.login_role eq 'customer' }">
                    <li class="nav-item">
                      <a class="nav-link fs-5" href="View_Car_List?car_status=Available">Cars</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link fs-5" href="View_Purchases?status=All">Purchases</a>
                    </li>                
                </c:if>
                <c:if test="${ sessionScope.login_role ne 'customer' }">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle fs-5" href="view_car_list.jsp" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                          Cars
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                          <li><a class="dropdown-item" href="View_Car_List?car_status=Available">Available Cars</a></li>
                          <li><a class="dropdown-item" href="View_Car_List?car_status=Booked_a">Booked Cars</a></li>
                          <li><a class="dropdown-item" href="View_Car_List?car_status=Completed">Paid Cars</a></li>
                        </ul>
                    </li>                    
                </c:if>
                <c:if test="${ sessionScope.login_role eq 'salesman' }">
                    <li class="nav-item">
                      <a class="nav-link fs-5" href="Sales_History?status=All">Sales</a>
                    </li>
                </c:if>
                <c:if test="${ sessionScope.login_role eq 'staff' }">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle fs-5" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                          Reports
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                          <li><a class="dropdown-item" href="Sales_Reports?year=${sessionScope.current_year}&month=0">Sales Reports</a></li>
                          <li><a class="dropdown-item" href="Car_Reports?year=${sessionScope.current_year}&month=0">Car Reports</a></li>
                          <li><a class="dropdown-item" href="Salesman_Reports?year=${sessionScope.current_year}&month=0">Salesman Reports</a></li>
                          <li><a class="dropdown-item" href="Customer_Reports?type=All">Customer Reports</a></li>
                          <li><a class="dropdown-item" href="Feedback_Reports">Feedback Reports</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle fs-5" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                          Users
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                          <li><a class="dropdown-item" href="Manage_Accounts?role=staff&status=All">Staff Accounts</a></li>
                          <li><a class="dropdown-item" href="Manage_Accounts?role=salesman&status=All">Salesman Accounts</a></li>
                          <li><a class="dropdown-item" href="Manage_Accounts?role=customer&status=All">Customer Accounts</a></li>
                        </ul>
                    </li>
                </c:if>
                <li class="nav-item">
                  <a class="nav-link fs-5" href="Logout">Logout</a>
                </li>
              </ul>
            </div>
          </div>
        </nav>
                    
        
           
    </body>
</html>

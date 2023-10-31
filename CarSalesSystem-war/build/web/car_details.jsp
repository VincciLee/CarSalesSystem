<%-- 
    Document   : car_details
    Created on : Feb 26, 2023, 10:38:10 PM
    Author     : Vincci
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.css" rel="stylesheet"  type='text/css'>
        
        <style>
            table, th, td {
                border: 1px solid white;
            }
            table {
                border-spacing: 10px;
            }
        </style>
        
        <title>VCars Corp</title>
    </head>
    <body>
        <jsp:include page="banner.jsp" />  
        
        <section class="vh-100" style="background-color: #eee;">
            <div class="container h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                  <div class="col-lg-12 col-xl-11">
                    <div class="card text-black" style="border-radius: 25px;">
                            <div class="card-body p-md-5">
                              <div class="row justify-content-around">
                                <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1 position-relative">
                                    <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">${car.getBrand()} ${car.getModel()}</p>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                      <img class="card-img" src="CarSalesSystem/images/<c:out value="${car.getImage()}"/>" alt="<c:out value="${car.getImage()}"/>" style="width: 100%; height: 100%; object-fit: contain">
                                    </div>

                                    <p class="text-center h2 mb-5 mx-1 mx-md-4 mt-4">RM ${car.getPrice()}</p>
                                    <p class="text-center mb-5 mx-1 mx-md-4 mt-4">${car.getDescription()}</p>
                                </div>

                                  <div class="col-md-10 col-lg-6 col-xl-5 order-1 order-lg-2 position-relative">
                                      <div class="d-flex flex-row justify-content-end mb-5 mx-1 mx-md-4 mt-4">
                                            <c:forEach begin="1" end="${avg_ratings}">
                                              <span style="font-size: 3em; color: gold"><i class="fa fa-star"></i></span>
                                            </c:forEach>
                                            <c:forEach begin="1" end="${5-avg_ratings}">
                                                <span style="font-size: 3em; color: gray"><i class="fa fa-star"></i></span> 
                                            </c:forEach>
                                            <p class="h5 mb-5 mx-1 mx-md-4 mt-4">(${total_reviews} Reviews)</p>
                                      </div>

                                  <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                      <table style="width: 100%;">
                                          <tr>
                                              <th style="width: 50%;">Body Type</th>
                                              <th style="width: 50%;">${car.getBody_type()}</th>
                                          </tr>
                                          <tr>
                                              <th style="width: 50%;">Transmission</th>
                                              <th style="width: 50%;">${car.getTransmission()}</th>
                                          </tr>
                                          <tr>
                                              <th style="width: 50%;">Fuel Type</th>
                                              <th style="width: 50%;">${car.getFuel()}</th>
                                          </tr> 
                                          <tr>
                                              <th style="width: 50%;">Seat Capacity</th>
                                              <th style="width: 50%;">${car.getSeat()}</th>
                                          </tr>
                                          <tr>
                                              <th style="width: 50%;">Publish Year</th>
                                              <th style="width: 50%;">${car.getPublishYear()}</th>
                                          </tr>  
                                      </table>
                                  </div>
                                          
                                <c:if test="${car_status eq 'Booked_a' || car_status eq 'Completed'}">
                                    <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                        <table style="width: 100%;">
                                          <tr>
                                              <th style="width: 50%;">Booked By</th>
                                              <th style="width: 50%;">${customer.getUsername()}</th>
                                          </tr> 
                                          <tr>
                                              <th style="width: 50%;">Booked At</th>
                                              <th style="width: 50%;">${sales.getBooked_date()}</th>
                                          </tr>
                                        </table>
                                    </div>
                                </c:if>
                                      
                                <c:if test="${car_status eq 'Completed'}">
                                    <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                        <table style="width: 100%;">
                                          <tr>
                                              <th style="width: 50%;">Accepted By</th>
                                              <th style="width: 50%;">${salesman.getUsername()}</th>
                                          </tr>
                                          <tr>
                                              <th style="width: 50%;">Accepted At</th>
                                              <th style="width: 50%;">${sales.getAccepted_date()}</th>
                                          </tr> 
                                          <tr>
                                              <th style="width: 50%;">Paid At</th>
                                              <th style="width: 50%;">${sales.getCompleted_date()}</th>
                                          </tr>
                                        </table>
                                    </div>
                                </c:if>
                                    <br>
                                    <div class="d-flex justify-content-between mx-4 mb-3 mb-lg-4">
                                        <c:if test="${ sessionScope.login_role eq 'customer' }">
                                            <a class="btn btn-primary btn-lg" href="Book_Car?id=<c:out value="${car.getId()}"/>" role="button">Book Car</a>
                                        </c:if>
                                        <c:if test="${ sessionScope.login_role ne 'customer' }">
                                            <c:if test="${car_status eq 'Available'}">
                                                <a class="btn btn-danger btn-lg" href="Delete_Car?id=${car.getId()}" role="button">Delete Car</a>
                                                <a class="btn btn-primary btn-lg" href="Edit_Car?id=${car.getId()}&car_status=${car_status}" role="button">Edit Car</a>
                                            </c:if>
                                                
                                            <c:if test="${car_status eq 'Booked_a' && sessionScope.login_role eq 'salesman' }">
                                                <a class="btn btn-primary btn-lg" href="Take_Charge?id=<c:out value="${sales.getId()}"/>" role="button">Take Charge</a>
                                            </c:if>
                                        </c:if>
                                    </div>
                                  </div>

                              </div>

                              <c:if test="${not empty error }">
                                  <div class="d-flex alert alert-danger alert-dismissible fade show position-absolute" role="alert" style="bottom: 50px; left: 50%; transform: translateX(-50%)">
                                      ${error}
                                      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                  </div>
                              </c:if>
                              <c:if test="${not empty success }">
                                    <div class="d-flex alert alert-success alert-dismissible fade show position-absolute" role="alert" style="bottom: 10px; left: 50%; transform: translateX(-50%)">
                                        ${success}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                              </c:if>

                            </div>
                    </div>
                  </div>
                </div>
            </div>
        </section>
        
        <script>
            if (performance.navigation.type === performance.navigation.TYPE_RELOAD) {
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Car_Details?id=${car.getId()}&car_status=${car_status}");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>

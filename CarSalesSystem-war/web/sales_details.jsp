<%-- 
    Document   : sales_details
    Created on : Feb 28, 2023, 4:48:05 PM
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
                                    <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4" style="color: white">Sales Details</p>

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
                                    
                                    <c:if test="${sessionScope.login_role eq 'customer'}">
                                        <br>
                                        <p class="fw-bold mx-4">Customer Feedback</p>
                                        <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                            <form action="Give_Feedback" method="post">
                                                <div class="input-group"">
                                                        <input type="hidden" id="salesId" name="sales_id" value="${sales.getId()}">
                                                        <select name="rating" class="form-control rounded" style="width: 30%" <c:if test="${sales.getStatus() ne 'Completed'}">disabled</c:if>>
                                                            <option value="0">Car Rating</option>
                                                            <option value="1" <c:if test="${sales.getCustomer_rating() eq 1}"> selected="true" </c:if>>1</option>
                                                            <option value="2" <c:if test="${sales.getCustomer_rating() eq 2}"> selected="true" </c:if>>2</option>
                                                            <option value="3" <c:if test="${sales.getCustomer_rating() eq 3}"> selected="true" </c:if>>3</option>
                                                            <option value="4" <c:if test="${sales.getCustomer_rating() eq 4}"> selected="true" </c:if>>4</option>
                                                            <option value="5" <c:if test="${sales.getCustomer_rating() eq 5}"> selected="true" </c:if>>5</option>
                                                        </select>
                                                        <input type="text" name="feedback" class="form-control rounded" placeholder="Purchase experience" style="width: 50%" value="${sales.getCustomer_feedback()}" required <c:if test="${sales.getStatus() ne 'Completed'}">disabled</c:if>/>
                                                        <button type="submit" class="btn btn-outline-primary" style="width: 20%" <c:if test="${sales.getStatus() ne 'Completed'}">disabled</c:if>>Rate</button>
                                                </div>
                                            </form>
                                        </div>
                                    </c:if>
                                       
                                    <c:if test="${sessionScope.login_role eq 'salesman'}">
                                        <br>
                                        <p class="fw-bold mx-4">Customer Feedback</p>
                                        <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                            <div class="input-group" style="width: 30vw">
                                                <input type="text" class="form-control rounded " value="${sales.getCustomer_rating() > 0 ? sales.getCustomer_rating() : '-'}" style="width: 20%" disabled />
                                                <input type="text" class="form-control rounded " value="${not empty sales.getCustomer_feedback() ? sales.getCustomer_feedback() : 'No feedback given'}" placeholder="No Feedback given" style="width: 80%" disabled />           
                                            </div>
                                        </div>
                                        
                                        <br>
                                        <p class="fw-bold mx-4">Salesman Comment</p>
                                        <form action="Give_Comment" method="post">
                                            <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                                <div class="input-group" style="width: 30vw">
                                                    <input type="hidden" id="salesId" name="sales_id" value="${sales.getId()}">
                                                    <textarea class="form-control rounded" placeholder="Comments" name="comment" required>${sales.getSalesman_comment()}</textarea>
                                                    <button type="submit" class="btn btn-outline-primary">Save</button>
                                                </div>
                                            </div>
                                        </form>
                                    </c:if>
                                        
                                    <c:if test="${sessionScope.login_role eq 'staff'}">
                                        <br>
                                        <p class="fw-bold mx-4">Customer Feedback</p>
                                        <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                            <div class="input-group" style="width: 30vw">
                                                <input type="text" class="form-control rounded " value="${sales.getCustomer_rating() > 0 ? sales.getCustomer_rating() : '-'}" style="width: 20%" disabled />
                                                <input type="text" class="form-control rounded " value="${not empty sales.getCustomer_feedback() ? sales.getCustomer_feedback() : 'No feedback given'}" placeholder="No Feedback given" style="width: 80%" disabled />           
                                            </div>
                                        </div>
                                        
                                        <br>
                                        <p class="fw-bold mx-4">Salesman Comment</p>
                                            <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                                <div class="input-group" style="width: 30vw">
                                                    <textarea class="form-control rounded" placeholder="Comments" name="comment" disabled>${not empty sales.getSalesman_comment() ? sales.getSalesman_comment() : 'No comment given'}</textarea>
                                                </div>
                                            </div>                                        
                                    </c:if>
                                    <br>
            
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
        </section>
        
        <script>
            if (performance.navigation.type === performance.navigation.TYPE_RELOAD) {
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Sales_Details?id=${sales.getId()}");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>

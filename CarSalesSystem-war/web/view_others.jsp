<%-- 
    Document   : view_others
    Created on : Mar 2, 2023, 3:31:35 PM
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
        
        <title>VCars Corp</title>
    </head>
    <body>
        <jsp:include page="banner.jsp" />  
    
        <section class="vh-100" style="background-color: #eee;">
            <div class="container rounded bg-white">
                    <div class="row justify-content-around">
                        <div class="col-md-3 border-right">
                            <div class="d-flex flex-column align-items-center text-center p-3 py-5 form-outline">
                                <c:if test="${not empty user.getProfile()}">
                                    <img class="rounded-circle mt-5" width="150px" height="150px" src="CarSalesSystem/images/<c:out value="${user.getProfile()}"/>">                                 
                                </c:if>
                                <c:if test="${empty user.getProfile()}">
                                    <img class="rounded-circle mt-5" width="150px" height="150px" src="images/default.png">
                                </c:if>
                                <br>
                                <span class="h4">${user.getUsername()}</span>
                                <span class="text-black-70">${user.getEmail()}</span>
                                
                            </div>
                        </div>
                        <div class="col-md-5 border-right">
                            <div class="p-3 py-5">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h1 class="text-right">Profile Settings</h4>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">Full Name</label>
                                        <p class="fs-6">${not empty user.getName() ? user.getName() : '[To be completed]'}</p>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">IC Number</label>
                                        <p class="fs-6">${not empty user.getIc() ? user.getIc() : '[To be completed]'} </p>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">Date of Birth</label>
                                        <p class="fs-6">${not empty user.getDob() ? user.getDob() : '[To be completed]'}</p>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">Phone Number</label>
                                        <p class="fs-6">${not empty user.getPhone() ? user.getPhone() : '[To be completed]'}</p>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">Gender</label>
                                        <p class="fs-6">${not empty user.getGender() ? user.getGender() : '[To be completed]'}</p>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
            </div>
        </section>
        
        <script>
            if (performance.navigation.type === performance.navigation.TYPE_RELOAD) {
                window.location.replace("http://localhost:8080/CarSalesSystem-war/View_Others?id=${user.getId()}&role=${role}");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>

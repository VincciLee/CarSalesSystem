<%-- 
    Document   : user_profile
    Created on : Mar 1, 2023, 4:15:53 PM
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
    
        <c:set var="user" scope="request" value="${sessionScope.login_user}"></c:set>
    
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
                                <span class="h6">${user.getUsername()}</span>
                                <span class="text-black-50">${user.getEmail()}</span>
                                
                                <div class="mt-5 text-center" style="position: relative; bottom: 0px;">
                                    <a class="btn btn-primary btn-lg" href="Edit_Profile" role="button" >Edit Profile</a>
                                </div>
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
                                        <p class="fs-6">${user.getName()}</p>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">IC Number</label>
                                        <p class="fs-6">${user.getIc()}</p>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">Date of Birth</label>
                                        <p class="fs-6">${user.getDob()}</p>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">Phone Number</label>
                                        <p class="fs-6">${user.getPhone()}</p>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">Gender</label>
                                        <p class="fs-6">${user.getGender()}</p>
                                    </div>
                                </div>
                                
                            </div>
                                
                            <c:if test="${not empty success }">
                                <div class="d-flex alert alert-success alert-dismissible fade show position-absolute" role="alert" style="bottom: 15px; left: 50%; transform: translateX(-50%)">
                                    ${success}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>
                        </div>
                    </div>
            </div>
        </section>
        
        <script>
            if (performance.navigation.type === performance.navigation.TYPE_RELOAD) {
                window.location.replace("http://localhost:8080/CarSalesSystem-war/User_Profile");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>

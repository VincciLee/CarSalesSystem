<%-- 
    Document   : change_password
    Created on : Mar 5, 2023, 1:15:38 AM
    Author     : Vincci
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        
        <title>VCars Corp</title>
    </head>
    <body>
        <c:if test="${type eq 'login'}">
            <jsp:include page="banner.jsp" />  
        </c:if>
        <c:if test="${type eq 'default'}">
            <jsp:include page="banner_default.jsp" /> 
        </c:if>
        
        <section class="vh-100" style="background-color: #eee;">
            <div class="container h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                  <div class="col-lg-12 col-xl-11">
                    <div class="card text-black" style="border-radius: 25px;">
                      <div class="card-body p-md-5">
                        <div class="row justify-content-center">
                          <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1 position-relative">

                            <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Change Password</p>


                            <form id="Update_Password" class="mx-1 mx-md-4" role="form" action="Update_Password" method="post">
                                <input type="hidden" name="type" value="${type}">
                                <input type="hidden" name="status" value="${status}">
                                <c:if test="${type eq 'login'}"><input type="hidden" name="id" value="${user.getId()}"></c:if>
                                
                                <div class="d-flex flex-row align-items-center mb-4">
                                    <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                                    <div class="form-outline flex-fill mb-0">
                                        <select name="role" class="form-control">
                                            <option value="customer" <c:if test="${type eq 'login'}"><c:if test="${role eq 'customer'}">selected="true"</c:if></c:if>>Customer</option>
                                            <option value="salesman" <c:if test="${type eq 'login'}"><c:if test="${role eq 'salesman'}">selected="true"</c:if></c:if>>Salesman</option>
                                            <c:if test="${type eq 'login'}"><option value="staff" <c:if test="${role eq 'staff'}">selected="true"</c:if>>Managing Staff</option></c:if>
                                         </select>
                                    </div>
                                </div>

                                <div class="d-flex flex-row align-items-center mb-4">
                                    <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                                    <div class="form-outline flex-fill mb-0">
                                        <input type="email" id="form3Example3c" class="form-control" name="email" <c:if test="${type eq 'login'}">value="${user.getEmail()}"</c:if> placeholder="Email" ${type eq 'login' ? 'readonly' : 'required'}/>
                                    </div>
                                </div>

                                <div class="d-flex flex-row align-items-center mb-4">
                                  <i class="fas fa-lock fa-lg me-3 fa-fw"></i>
                                  <div class="form-outline flex-fill mb-0">
                                      <input type="password" id="form3Example4c" class="form-control" name="password" placeholder="New Password" required/>
                                    <!--<label class="form-label" for="form3Example4c">Password</label>-->
                                  </div>
                                </div>

                                <div class="d-flex flex-row align-items-center mb-4">
                                  <i class="fas fa-key fa-lg me-3 fa-fw"></i>
                                  <div class="form-outline flex-fill mb-0">
                                    <input type="password" id="form3Example4cd" class="form-control" name="password2" placeholder="Confirm Password" required/>
                                    <!--<label class="form-label" for="form3Example4cd">Repeat your password</label>-->
                                  </div>
                                </div>

                                <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                    <button type="submit" class="btn btn-primary btn-lg">Change</button>
                                </div>

                            </form>

                            </div>
                            <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">

                              <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-registration/draw1.webp"
                                class="img-fluid" alt="Sample image">

                            </div>
                        </div>
                        <c:if test="${not empty error }">
                            <div class="alert alert-danger position-absolute" role="alert" style="bottom: 50px; left: 50%; transform: translateX(-50%)">
                                ${error}
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
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Change_Password?type=${type}");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>

<%-- 
    Document   : login
    Created on : Feb 20, 2023, 4:26:44 PM
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

        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.3.1/css/all.min.css" rel="stylesheet">
        <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
        
        <script>
            function showHidePassword(){
                event.preventDefault();
                var input = document.getElementById("show_hide_input");
                var icon = document.getElementById("show_hide_icon");

                if(input.type === "text"){
                    input.type = 'password';
                    icon.classList.add( "fa-eye-slash" );
                    icon.classList.remove( "fa-eye" );
                }else if(input.type === "password"){
                    input.type = 'text';
                    icon.classList.remove( "fa-eye-slash" );
                    icon.classList.add( "fa-eye" );
                }       
            }
        </script>
        
        <title>VCars Corp</title>
    </head>
    <body>
        <jsp:include page="banner_default.jsp" /> 
        
        <section class="vh-100" style="background-color: #eee;">
            <div class="container h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                  <div class="col-lg-12 col-xl-11">
                    <div class="card text-black" style="border-radius: 25px;">
                      <div class="card-body p-md-5">
                        <div class="row justify-content-center">
                          <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1 position-relative">

                            <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Login</p>


                            <form action="Login" method="post" id="Register" class="mx-1 mx-md-4" role="form" >

                                <div class="d-flex flex-row align-items-center mb-4">
                                  <div class="form-outline flex-fill mb-0">
                                    <input type="email" id="form3Example3c" class="form-control" name="email" placeholder="Email" required/>
                                  </div>
                                </div>

                                <div class="d-flex flex-row align-items-center mb-4">
                                    <div class="form-outline flex-fill mb-0">
                                            <div class="input-group form-outline flex-fill mb-0">
                                                <input type="password" id="show_hide_input" class="form-control" name="password" placeholder="Password" required/>
                                                <button class="input-group-text" type="button" onclick="showHidePassword()">
                                                    <i class="fa fa-eye-slash" aria-hidden="true"  id="show_hide_icon"></i>
                                                </button>
                                            </div>
                                    </div>
                                </div>
                                
                                <div class="d-flex flex-row align-items-center mb-4">
                                    <div class="form-outline flex-fill mb-0">
                                        <select name="role" class="form-control">
                                            <option value="customer">Customer</option>
                                            <option value="salesman">Salesman</option>
                                            <option value="staff">Managing Staff</option>
                                         </select>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                  <button type="submit" class="btn btn-primary btn-lg">Login</button>
                                </div>

                            </form>
                            
                            <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                <a class="pwd-forget" href="Change_Password?type=default" id="open_forgotPassword">Forget Password</a>
                            </div>
                            <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">Not registered yet?<a href="register.jsp">click here</a></div>

                            </div>
                            <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
                              <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-registration/draw1.webp"
                                class="img-fluid" alt="Sample image">
                            </div>
                        </div>
                          
                        <c:if test="${not empty error }">
                            <div class="d-flex alert alert-danger alert-dismissible fade show position-absolute" role="alert" style="bottom: 50px; left: 50%; transform: translateX(-50%)">
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                <%--<c:remove var="error" ></c:remove>--%>
                            </div>
                        </c:if>
                        <c:if test="${not empty success }">
                            <div class="d-flex alert alert-success alert-dismissible fade show position-absolute" role="alert" style="bottom: 50px; left: 50%; transform: translateX(-50%)">
                                ${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                <%--<c:remove var="success" scope="request"></c:remove>--%>
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
                window.location.replace("http://localhost:8080/CarSalesSystem-war/login.jsp");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>

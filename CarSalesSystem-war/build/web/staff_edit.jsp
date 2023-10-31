<%-- 
    Document   : staff_edit
    Created on : Mar 4, 2023, 11:28:37 PM
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
        
        <style>
            body {
                background: rgb(99, 39, 120)
            }

            .form-control:focus {
                box-shadow: none;
                border-color: #BA68C8
            }

            .profile-button {
                background: rgb(99, 39, 120);
                box-shadow: none;
                border: none
            }

            .profile-button:hover {
                background: #682773
            }

            .profile-button:focus {
                background: #682773;
                box-shadow: none
            }

            .profile-button:active {
                background: #682773;
                box-shadow: none
            }

            .back:hover {
                color: #682773;
                cursor: pointer
            }

            .labels {
                font-size: 11px
            }

            .add-experience:hover {
                background: #BA68C8;
                color: #fff;
                cursor: pointer;
                border: solid 1px #BA68C8
            }
        </style>
    </head>
    <body>
        <jsp:include page="banner.jsp" />  
        
        <section class="vh-100" style="background-color: #eee;">
            <div class="container rounded bg-white">
                <form action="Staff_Save" method="post" enctype="multipart/form-data">
                    <div class="row justify-content-around">
                        <div class="col-md-3 border-right">
                            <div class="d-flex flex-column align-items-center text-center p-3 py-5 form-outline">
                                <input type="hidden" name="status" value="${status}">
                                <c:if test="${not empty user.getProfile()}">
                                    <img class="rounded-circle mt-5" width="150px" height="150px" src="CarSalesSystem/images/<c:out value="${user.getProfile()}"/>">                                    
                                </c:if>
                                <c:if test="${empty user.getProfile()}">
                                    <img class="rounded-circle mt-5" width="150px" height="150px" src="images/default.png">
                                </c:if>
                                <br><br>
                                <input type="file" name="image" id="form3Example3c" class="form-control" name="car_img" accept="image/*" />
                                
                                <input type="hidden" name="id" value="${id}">
                                <input type="hidden" name="role" value="${role}">
                                <input type="hidden" name="status" value="${status}">
                                <div class="mt-5 text-center" style="position: absolute; bottom: 0px;">
                                    <button class="btn btn-primary btn-lg" type="submit">Save Profile</button>
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
                                        <input type="text" name="full_name" class="form-control" placeholder="Full Name" value="${not empty user.getName() ? user.getName() : ''}" required>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">Username</label>
                                        <input type="text" name="username" class="form-control" placeholder="Username" value="${not empty user.getUsername() ? user.getUsername() : ''}" required>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">Email Address</label>
                                        <input type="text" name="email" class="form-control" placeholder="Email Address" value="${user.getEmail()}" disabled>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">IC Number</label>
                                        <input type="text" name="ic" class="form-control" placeholder="e.g: 123456-12-1234" value="${user.getIc()}">
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">Date of Birth</label>
                                        <input type="date" name="dob" class="form-control" <c:if test="${not empty user.getDob()}"> value="${user.getDob()}"</c:if>>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">Phone Number</label>
                                        <input type="text" name="phone" class="form-control" placeholder="e.g: 012-1234567 / 012-12345678" value="${not empty user.getPhone() ? user.getPhone() : ''}" required>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels h6">Gender</label>
                                        <select name="gender" class="form-control">
                                            <option value="Male" <c:if test="${user.getGender() eq 'Male'}"> selected="true" </c:if>>Male</option>
                                            <option value="Female" <c:if test="${user.getGender() eq 'Female'}"> selected="true" </c:if>>Female</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                                    
                        <c:if test="${not empty error }">
                            <div class="d-flex alert alert-danger alert-dismissible fade show position-absolute" role="alert" style="bottom: 15px; left: 50%; transform: translateX(-50%)">
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        </div>
                    </div>
                </form>
            </div>
        </section>
        
        <script>
            if (performance.navigation.type === performance.navigation.TYPE_RELOAD) {
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Staff_Edit?id=${id}&role=${role}");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    
    </body>
</html>

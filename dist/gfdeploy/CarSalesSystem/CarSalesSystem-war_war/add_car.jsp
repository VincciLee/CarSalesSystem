<%-- 
    Document   : add_car
    Created on : Feb 26, 2023, 11:43:57 AM
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
        <jsp:include page="banner.jsp" />   
        
        <section class="vh-100" style="background-color: #eee;">
            <div class="container h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                  <div class="col-lg-12 col-xl-11">
                    <div class="card text-black" style="border-radius: 25px;">
                        <form action="Register_Car" method="post" enctype="multipart/form-data" id="Register" class="mx-1 mx-md-4" role="form" >
                            <div class="card-body p-md-5">
                              <div class="row justify-content-around">
                                <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1 position-relative">

                                  <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Add New Car</p>
                                          <div class="d-flex flex-row align-items-center mb-4">
                                            <div class="form-outline flex-fill mb-0">
                                              Car Image
                                              <input type="file" id="form3Example3c" class="form-control" name="car_img" accept="image/*" required/>
                                            </div>
                                          </div>

                                          <div class="d-flex flex-row align-items-center mb-4">
                                            <div class="form-outline flex-fill mb-0">
                                              Car Brand
                                              <input type="text" id="form3Example3c" class="form-control" name="brand" placeholder="Brand" required/>
                                            </div>
                                          </div>

                                          <div class="d-flex flex-row align-items-center mb-4">
                                            <div class="form-outline flex-fill mb-0">
                                              Car Model
                                              <input type="text" id="form3Example4c" class="form-control" name="model" placeholder="Model" required/>
                                            </div>
                                          </div>

                                          <div class="d-flex flex-row align-items-center mb-4">
                                              <div class="form-outline flex-fill mb-0">
                                                  Car Description
                                                  <textarea id="form3Example4c" class="form-control" name="description" placeholder="Description" required></textarea>
                                              </div>
                                          </div>

                                  </div>

                                  <div class="col-md-10 col-lg-6 col-xl-5 order-1 order-lg-2 position-relative">
                                  <!--<div class="col-md-10 col-lg-6 col-xl-7 d-flex flex-column align-items-center order-1 order-lg-2">-->
                                      <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4" style="color: white">Add New Car</p>

                                      <div class="d-flex justify-content-between mb-4">
                                        <div class="form-outline mb-0" style="width: 50%">
                                          Body Type
                                          <select name="body_type" class="form-control">
                                              <option value="Hatchback">Hatchback</option>
                                              <option value="Sedan">Sedan</option>
                                              <option value="MUV">MUV</option>
                                              <option value="SUV">SUV</option>
                                              <option value="Coupe">Coupe</option>
                                              <option value="Convertible">Convertible</option>
                                              <option value="Wagon">Wagon</option>
                                              <option value="Van">Van</option>
                                              <option value="Jeep">Jeep</option>
                                          </select>
                                        </div>
                                          
                                        <div class="form-outline mb-0" style="width: 40%">
                                          Publish Year
                                          <input type="number" id="form3Example4c" class="form-control" name="year" value="2023" min="1900" required/>
                                        </div>
                                      </div>

                                      <div class="d-flex justify-content-between mb-4">
                                        <div class="form-outline mb-0" style="width: 50%">
                                          Transmission
                                          <select name="transmission" class="form-control">
                                              <option value="Automatic Transmission">Automatic Transmission</option>
                                              <option value="Manual Transmission">Manual Transmission</option>
                                          </select>
                                        </div>
                                      
                                        <div class="form-outline mb-0" style="width: 40%">
                                          Seat Capacity
                                          <input type="number" id="form3Example4c" class="form-control" name="seat" value="2" min="2" max="50" required/>
                                        </div>
                                      </div>
                                      
                                      <div class="d-flex justify-content-between mb-4">
                                        <div class="form-outline mb-0" style="width: 50%">
                                          Fuel
                                          <select name="fuel" class="form-control">
                                              <option value="Petrol">Petrol</option>
                                              <option value="Diesel">Diesel</option>
                                              <option value="Bio-Diesel">Bio-Diesel</option>
                                              <option value="CNG">CNG</option>
                                              <option value="LPS">LPS</option>
                                              <option value="Ethanol">Ethanol</option>
                                          </select>
                                        </div>
                                          
                                        <div class="form-outline mb-0" style="width: 40%">
                                          Price (RM)
                                          <input type="number" id="form3Example4c" class="form-control" name="price" value="0" min="0" required/>
                                        </div>
                                      </div>
                                    <br>
                                    <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                      <button type="submit" class="btn btn-primary btn-lg">Add Car</button>
                                    </div>
                                  </div>

                              </div>

                              <c:if test="${not empty error }">
                                  <div class="d-flex alert alert-danger alert-dismissible fade show position-absolute" role="alert" style="bottom: 50px; left: 50%; transform: translateX(-50%)">
                                      ${error}
                                      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                  </div>
                              </c:if>

                            </div>
                        </form>
                    </div>
                  </div>
                </div>
            </div>
        </section>
        
        <script>
            if (performance.navigation.type === performance.navigation.TYPE_RELOAD) {
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Add_Car");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>        
    </body>
</html>

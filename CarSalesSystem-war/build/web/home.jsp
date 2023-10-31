<%-- 
    Document   : home
    Created on : Feb 24, 2023, 3:15:14 PM
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
        
        <section id="header" class="jumbotron text-center" style="background-image: url('CarSalesSystem/images/home_bg.jpg'); padding-top: 20px; padding-bottom: 50px;">
            <h1 class="display-3">VCARS CORP</h1>
            <p class="lead">Find the best car vendor in town!</p>
            <form action="View_Car_List">
                <div class="input-group mx-auto" style="width: 30vw">
                    <input type="hidden" name="car_status" value="Available">
                    <select name="filter" class="form-control rounded" style="width: 20%">
                        <option value="brand">Brand</option>
                        <option value="model">Model</option>
                    </select>
                    <input type="search" name="search" class="form-control rounded" placeholder="Search" style="width: 50%" aria-label="Search" aria-describedby="search-addon" required />
                    <button type="submit" class="btn btn-outline-primary">Search</button>
                </div>
            </form>
        </section>

        <section id="gallery" style="padding-top: 40px;">
            <div class="container">
                <div class="row">
                    <c:forEach begin="0" end="${size}" var="i">
                        <div class="col-lg-4 mb-4">
                            <div class="card">
                                <img src="CarSalesSystem/images/${cars[i].getImage()}" alt="${cars[i].getImage()}" class="card-img-top" style="height: 50%; overflow: hidden">
                                <div class="card-body">
                                    <h3 class="card-title">${cars[i].getBrand()} ${cars[i].getModel()}</h5>
                                    <h5 class="card-text">RM ${cars[i].getPrice()}</h5>
                                    <p class="card-text">${cars[i].getDescription()}</p>
                                    <a href="Car_Details?id=${cars[i].getId()}&car_status=Available" class="btn btn-outline-success btn-sm">View Details</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
           </div>
        </section>

        <c:if test="${not empty success }">
            <div class="d-flex alert alert-success alert-dismissible fade show position-absolute" role="alert" style="bottom: 10px; left: 50%; transform: translateX(-50%)">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                
                <c:remove var="success" scope="session"></c:remove>
            </div>
        </c:if>
        
        <script>
            if (performance.navigation.type === performance.navigation.TYPE_RELOAD) {
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Home");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>

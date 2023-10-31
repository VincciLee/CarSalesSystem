<%-- 
    Document   : view_car_list
    Created on : Feb 24, 2023, 4:57:34 PM
    Author     : Vincci
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Cars"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <title>VCars Corp</title>
    </head>
    <body>
        <jsp:include page="banner.jsp" />   
        
        <br><br><br> 
        <div class="container bcontent">
            <div class="d-flex justify-content-between">
                <div>
                    <c:if test="${sessionScope.login_role ne 'customer'}">
                        <a class="btn btn-primary" href="Add_Car" role="button" style="width: 10vw">Add Car</a>
                    </c:if>
                </div>
                <div></div>
                <form action="View_Car_List">
                    <div class="input-group" style="width: 30vw">
                        <input type="hidden" name="car_status" value="${car_status}">
                        <select name="filter" class="form-control rounded">
                            <option value="brand">Brand</option>
                            <option value="model">Model</option>
                        </select>
                        <input type="search" name="search" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon" required />
                        <button type="submit" class="btn btn-outline-primary">Search</button>
                    </div>
                </form>
            </div>
            <hr />
            
            <c:forEach items="${cars}" var="car">
                <div class="card" style="width: 100%">
                    <div class="row no-gutters" style="height: 30vh">
                        <div class="col-4" style="overflow: hidden; height: 100%">
                            <img class="card-img" src="CarSalesSystem/images/<c:out value="${car.getImage()}"/>" alt="<c:out value="${car.getImage()}"/>" style="width: 100%; height: 100%; object-fit: contain">
                        </div>
                        <div class="col-8">
                            <div class="card-body">
                                <div class="d-flex justify-content-between" style="width: 90%">
                                    <h5 class="card-title"><c:out value="${car.getBrand()}"/> <c:out value="${car.getModel()}"/></h5>
                                    <h5 class="card-title">RM <c:out value="${car.getPrice()}"/></h5>
                                </div>
                                <p class="card-text"><c:out value="${car.getDescription()}"/></p>
                                
                                <a href="Car_Details?id=<c:out value="${car.getId()}"/>&car_status=${car_status}" class="btn btn-primary">View Details</a>
                                <c:if test="${ sessionScope.login_role eq 'customer' }">
                                    <a href="Book_Car?id=<c:out value="${car.getId()}"/>" class="btn btn-success">Book Car</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                <br>
            </c:forEach>
        </div>
        
        <c:if test="${not empty success }">
            <div class="d-flex alert alert-success alert-dismissible fade show position-absolute" role="alert" style="bottom: 10px; left: 50%; transform: translateX(-50%)">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                <c:remove var="success" scope="request"></c:remove>
            </div>
        </c:if>
        
        <script>
            if (performance.navigation.type === performance.navigation.TYPE_RELOAD) {
                window.location.replace("http://localhost:8080/CarSalesSystem-war/View_Car_List?car_status=${car_status}");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>

<%-- 
    Document   : sales_history
    Created on : Feb 28, 2023, 1:41:13 PM
    Author     : Vincci
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Sales"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        
        <jsp:include page="banner.jsp" /> 
        <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery.fancytable/dist/fancyTable.min.js"></script>
        <title>VCars Corp</title>
        
        <script>
            $(document).ready(function() {
                $("#my_table").fancyTable({
                        sortColumn:5,
                        sortOrder: 'descending',
                        pagination: true,
                        perPage:5,
                        globalSearch:true
                });		
            });  
        </script>
    </head>
    <body>
        
        <br><br><br>
        
        <div class="container bcontent">
            <div class="d-flex justify-content-between">
                <div style="width: 25vw">
                    <p class="text-center h1 fw-bold mb-1 mx-1 mx-md-4 mt-4">Sales Records</p>
                </div>
                <form action="Sales_History" method="post" id="Register" class="mx-1 mx-md-4" role="form" >
                    <div class="input-group mb-1 mx-1 mx-md-4 mt-4" style="width: 20vw">
                            <select name="status" class="form-control rounded">
                                <option value="All" <c:if test="${status eq 'All'}"> selected="true" </c:if>>All</option>
                                <option value="Pending Payment" <c:if test="${status eq 'Pending Payment'}"> selected="true" </c:if>>Pending Payment</option>
                                <option value="Completed" <c:if test="${status eq 'Completed'}"> selected="true" </c:if>>Completed</option>
                                <option value="Canceled" <c:if test="${status eq 'Canceled'}"> selected="true" </c:if>>Canceled</option>
                            </select>
                            <button type="submit" class="btn btn-outline-primary">Filter</button>
                    </div>
                </form>
            </div>
            <hr />
    
            <table class="table table-hover table-lg" id="my_table">
                <thead class="thead-light" style="background-color: #85cfce">
                    <tr>
                        <th scope="col">Sales Id</th>
                        <th scope="col">Customer Id</th>
                        <th scope="col">Booked Date</th>
                        <th scope="col">Accepted Date</th>
                        <th scope="col">Paid Date</th>
                        <th scope="col">Status</th>
                        <th scope="col">My Comments</th>
                        <th scope="col">Complete</th>
                        <th scope="col">Cancel</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${sales}" var="s">
                    <tr>
                        <td><a href="Sales_Details?id=${s.getId()}">${s.getId()}</a></td>
                        <c:if test="${not empty s.getCustomer_id()}">
                            <td><a href="View_Others?id=${s.getCustomer_id()}&role=customer">${s.getCustomer_id()}</a></td>
                        </c:if>
                        <c:if test="${empty s.getCustomer_id()}">
                            <td>-</td>
                        </c:if>
                        <td>${s.getBooked_date()}</td>
                        <td>${not empty s.getAccepted_date() ? s.getAccepted_date() : '-'}</td>
                        <td>${not empty s.getCompleted_date() ? s.getCompleted_date() : '-'}</td>
                        <td>${s.getStatus()}</td>
                        <td>${not empty s.getSalesman_comment() ? s.getSalesman_comment() : '-'}</td>
                        <td><a href="Complete_Sales?id=${s.getId()}&status=${status}" class="btn btn-success <c:if test="${s.getStatus() eq 'Completed' || s.getStatus() eq 'Canceled'}"> disabled </c:if>">Complete</a></td>
                        <td><a href="Cancel_Sales?id=${s.getId()}&status=${status}" class="btn btn-danger <c:if test="${s.getStatus() eq 'Completed' || s.getStatus() eq 'Canceled'}"> disabled </c:if>">Cancel</a></td>                        
                    </tr>
                </c:forEach>
                </tbody>
            </table>
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
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Sales_History?status=${status}");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>  
    </body>
</html>

<%-- 
    Document   : feedback_reports
    Created on : Mar 5, 2023, 5:12:51 PM
    Author     : Vincci
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <jsp:include page="banner.jsp" /> 
        <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery.fancytable/dist/fancyTable.min.js"></script>
        <title>VCars Corp</title>
        
        <script>
            $(document).ready(function() {
                    $("#my_table").fancyTable({
                            sortColumn:1,
                            sortOrder: 'ascending',
                            pagination: true,
                            perPage:10,
                            globalSearch:true
                    });		
            });            
        </script>
    </head>
    <body>
        
        <br><br><br>
        
        <div class="container bcontent">
            <div class="d-flex justify-content-between">
                <div style="width: 30vw">
                    <p class="text-center h1 fw-bold">Customer Feedbacks</p>
                </div>
            </div>
            <hr />

            <table class="table table-hover table-lg" id="my_table">
                <thead class="thead-light" style="background-color: #85cfce">
                    <tr>
                        <th scope="col">Sales Id</th>
                        <th scope="col">Salesman Name</th>
                        <th scope="col">Customer Name</th>
                        <th scope="col">Feedback</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${sales}" var="s">
                    <tr>
                        <td><a href="Sales_Details?id=${s.getId()}">${s.getId()}</a></td>
                        <td>${salesmen.get(s.getSalesman_id())}</td>
                        <td>${customers.get(s.getCustomer_id())}</td>
                        <td>${s.getCustomer_feedback()}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        
        <script>
            if (performance.navigation.type === performance.navigation.TYPE_RELOAD) {
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Feedback_Reports");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>  
    
    </body>
</html>

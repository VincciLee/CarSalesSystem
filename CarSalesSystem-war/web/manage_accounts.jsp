<%-- 
    Document   : manage_accounts
    Created on : Mar 2, 2023, 1:23:49 PM
    Author     : Vincci
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                            sortColumn:0,
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
                    <c:if test="${role eq 'customer'}"><p class="text-center h1 fw-bold">Customer Accounts</p></c:if>
                    <c:if test="${role eq 'salesman'}"><p class="text-center h1 fw-bold">Salesman Accounts</p></c:if>
                    <c:if test="${role eq 'staff'}"><p class="text-center h1 fw-bold">Staff Accounts</p></c:if>
                </div>
                <c:if test="${role ne 'staff'}">
                    <form action="Manage_Accounts" method="post" id="Register" class="mx-1 mx-md-4" role="form" >
                        <div class="input-group" style="width: 20vw">
                                <input type="hidden" name="role" value="${role}">
                                <select name="status" class="form-control rounded">
                                    <option value="All" <c:if test="${status eq 'All'}"> selected="true" </c:if>>All</option>
                                    <option value="Pending" <c:if test="${status eq 'Pending'}"> selected="true" </c:if>>Pending</option>
                                    <option value="Incomplete" <c:if test="${status eq 'Incomplete'}"> selected="true" </c:if>>Incomplete</option>
                                    <option value="Completed" <c:if test="${status eq 'Completed'}"> selected="true" </c:if>>Completed</option>
                                </select>
                                <button type="submit" class="btn btn-outline-primary">Filter</button>
                        </div>
                    </form>
                </c:if>
                <c:if test="${role eq 'staff'}">
                    <div>
                        <a class="btn btn-primary" href="Add_Staff" role="button" style="width: 10vw">Add Staff</a>
                    </div>
                </c:if>
            </div>
            <hr />

            <table class="table table-hover table-lg" id="my_table">
                <thead class="thead-light" style="background-color: #85cfce">
                    <tr>
                        <th scope="col">User Id</th>
                        <th scope="col">Username</th>
                        <th scope="col">Full Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Contact Number</th>
                        <th scope="col">IC Number</th>
                        <c:if test="${role ne 'staff'}">
                            <th scope="col">Account Status</th>
                            <th scope="col"></th>
                        </c:if>
                        <th scope="col"></th>
                        <th scope="col"></th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${accounts}" var="acc">
                    <tr>
                        <td><a href="View_Others?id=${acc.getId()}&role=${role}">${acc.getId()}</a></td>
                        <td>${acc.getUsername()}</td>
                        <td>${not empty acc.getName() ? acc.getName() : '-'}</td>
                        <td>${acc.getEmail()}</td>
                        <td>${not empty acc.getPhone() ? acc.getPhone() : '-'}</td>
                        <td>${not empty acc.getIc() ? acc.getIc() : '-'}</td>
                        <c:if test="${role ne 'staff'}">
                            <td>${acc.getApproval_status()}</td>
                            <td><a href="Staff_Edit?id=${acc.getId()}&role=${role}&status=${status}" class="btn btn-warning <c:if test="${acc.getApproval_status() eq 'Pending'}"> disabled </c:if>">Edit</a></td>
                            <td><a href="Staff_Delete?id=${acc.getId()}&role=${role}&status=${status}" class="btn btn-danger <c:if test="${acc_sales.get(acc.getId()) > 0}"> disabled </c:if>">Delete</a></td>                        
                            <td><a href="Staff_Approve?id=${acc.getId()}&role=${role}&status=${status}" class="btn btn-success <c:if test="${acc.getApproval_status() ne 'Pending'}"> disabled </c:if>">Approve</a></td>   
                        </c:if>
                        <c:if test="${role eq 'staff'}">
                            <td><a href="Staff_Edit?id=${acc.getId()}&role=${role}&status=${status}" class="btn btn-warning">Edit</a></td>
                            <td><a href="Staff_Delete?id=${acc.getId()}&role=${role}&status=${status}" class="btn btn-danger <c:if test="${sessionScope.login_user.getId() eq acc.getId()}"> disabled </c:if>">Delete</a></td> 
                        </c:if>                                            
                        <td><a href="Change_Password?id=${acc.getId()}&role=${role}&status=${status}&type=login" class="btn btn-info">Change Password</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        
        <c:if test="${not empty success }">
              <div class="d-flex alert alert-success alert-dismissible fade show position-absolute" role="alert" style="bottom: 10px; left: 50%; transform: translateX(-50%)">
                  ${success}
                  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
              </div>
        </c:if>
        <script>
            if (performance.navigation.type === performance.navigation.TYPE_RELOAD) {
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Manage_Accounts?role=${role}&status=${status}");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>  
    </body>
</html>

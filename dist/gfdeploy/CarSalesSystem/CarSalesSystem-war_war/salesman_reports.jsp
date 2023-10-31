<%-- 
    Document   : salesman_reports
    Created on : Mar 3, 2023, 3:49:40 PM
    Author     : Vincci
--%>

<%@page import="java.util.stream.Stream"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>

<%
    Gson gsonObj = new Gson();
    Map<Object,Object> map = null;
    List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
    List<Map<Object,Object>> list2 = new ArrayList<Map<Object,Object>>();
    Map<String, Integer> sales = (Map<String, Integer>)request.getAttribute("sales_count");
    Map<String, Integer> cancel = (Map<String, Integer>)request.getAttribute("cancel_count");
    String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    String[] full_months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "Octocber", "November", "December"};
    String[] int_months = {"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"};
    int int_month = Integer.valueOf(request.getParameter("month"));
    String full_month = "";
    if (request.getAttribute("display_type").equals("month")){
        full_month = full_months[int_month-1];
    };
    
    
    for(Map.Entry<String, Integer> s: sales.entrySet()){
        map = new HashMap<Object,Object>(); 
        map.put("label", s.getKey()); 
        map.put("y", s.getValue()); 
        map.put("count", s.getValue());
        list.add(map);
    }

    for(Map.Entry<String, Integer> c: cancel.entrySet()){
        map = new HashMap<Object,Object>(); 
        map.put("label", c.getKey()); 
        map.put("y", c.getValue()); 
        map.put("count", c.getValue());
        list2.add(map);
    }
    
    String dataPoints = gsonObj.toJson(list);
    String dataPoints2 = gsonObj.toJson(list2);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.css" rel="stylesheet"  type='text/css'>

        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.3.1/css/all.min.css" rel="stylesheet">
        <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
        
        <style>
            .row .col{
                padding: 0!important;
            }
            
            .card-body .row{
                padding-left: 10px!important;
            }
            
            .icon {
                width: 3rem;
                height: 3rem;
            }

            .icon i {
                font-size: 2.25rem;
            }

            .icon-shape {
                display: inline-flex;
                padding: 20px;
                text-align: center;
                border-radius: 50%;
                align-items: center;
                justify-content: center;
            }
        </style>
        
        <script type="text/javascript">
            window.onload = function() { 
                var display_type = document.getElementById("display_type").value;
                var year = document.getElementById("year").value;
                var month = "";
                var subtitle = "";
                
                if (display_type === "month"){
                    month = document.getElementById("full_month").value;
                    subtitle = year + " - " + month;
                }else{
                    subtitle = year;
                }
                
                var chart = new CanvasJS.Chart("barchartContainer", {
                    theme: "light2",
                    title: {
                            text: "Salesman Performance"
                    },
                    subtitles: [{
                            text: subtitle
                    }],
                    axisY: {
                            title: "Number of Transactions"
                    },
                    data: [{
                            type: "bar",
                            indexLabel: "{y}",
                            indexLabelFontColor: "#444",
                            indexLabelPlacement: "inside",
                            toolTipContent: "{label}: <strong> {count} transactions</strong>",
                            dataPoints: <%out.print(dataPoints);%>
                    }]
                });
                chart.render();

                var chart = new CanvasJS.Chart("bar2chartContainer", {
                    theme: "light2",
                    title: {
                            text: "Transaction Cancellations"
                    },
                    subtitles: [{
                            text: subtitle
                    }],
                    axisY: {
                            title: "Number of Transactions"
                    },
                    data: [{
                            type: "bar",
                            indexLabel: "{y}",
                            indexLabelFontColor: "#444",
                            indexLabelPlacement: "inside",
                            dataPoints: <%out.print(dataPoints2);%>
                    }]
                });
                chart.render();

            }
        </script>
        <title>VCars Corp</title>
    </head>
    <body>
        <jsp:include page="banner.jsp" />  
        <input type="hidden" name="display_type" id="display_type" value="${display_type}">
        <input type="hidden" name="year" id="year" value="${year}">
        <input type="hidden" name="full_month" id="full_month" value="<%=full_month%>">
        

        <section class="" style="background-color: #eee; height: 100%;">
            <div class= "d-flex flex-column align-items-center mx-auto" style="width: 90%;">
                <div class="d-flex align-items-start align-items-center" style="width: 100%; height: 100%; padding-top: 20px; padding-bottom: 20px;">
                    <div class="card" style="width: 100%; height: 100%">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">${display_type eq 'year' ? 'Annual' : 'Monthly'} Salesman Statistics</h5>
                                <form action="Salesman_Reports" method="post">
                                    <div class="input-group" style="width: 30vw">
                                        <input type="number" id="form3Example4c" class="form-control" name="year" value="2023" min="1900" max="2023" required/>
                                        <select name="month" class="form-control rounded">
                                            <option value="0">Month</option>
                                            <c:forEach begin="1" end="12" var="val">
                                                <c:choose>
                                                    <c:when test="${val < 10}">
                                                        <option value="0${val}" <c:if test="${Integer.parseInt(month) eq val}"> selected="true" </c:if>>0${val}</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${val}" <c:if test="${month eq val}"> selected="true" </c:if>>${val}</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                        <button type="submit" class="btn btn-outline-primary">Filter</button>                                    
                                    </div>
                                </form>
                            </div><br>
                            <div class="d-flex justify-content-between" style="height: 300px;">
                                <div class="card-text" id="barchartContainer" style="width: 45%"></div>
                                <div class="card-text" id="bar2chartContainer" style="width: 45%"></div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row row-cols-2" style="width: 100%; padding-bottom: 20px;">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="card-title text-uppercase text-muted mb-0">Highest Performance</h5>
                                        <span class="h2 font-weight-bold mb-0">${highest_sales}</span>
                                    </div>
                                    <div class="col">
                                        <p class="mt-4 mb-0 text-muted text-sm">${sales_count.get(highest_sales)} Transactions</p>
                                    </div>
                                    <div class="col-auto">
                                        <div class="icon icon-shape bg-danger text-white rounded-circle shadow">
                                            <i class="fas fa-chart-bar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="card-title text-uppercase text-muted mb-0">Most Cancellations</h5>
                                        <span class="h2 font-weight-bold mb-0">${highest_cancel}</span>
                                    </div>
                                    <div class="col">
                                        <p class="mt-4 mb-0 text-muted text-sm">${cancel_count.get(highest_cancel)} Transactions</p>
                                    </div>
                                    <div class="col-auto">
                                        <div class="icon icon-shape bg-danger text-white rounded-circle shadow">
                                            <i class="fas fa-chart-bar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                                    
                    <div class="col">
                        <div  class="card" >
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="card-title text-uppercase text-muted mb-0">Lowest Performance</h5>
                                        <span class="h2 font-weight-bold mb-0">${lowest_sales}</span>
                                    </div>
                                    <div class="col">
                                        <p class="mt-4 mb-0 text-muted text-sm">${sales_count.get(lowest_sales)} Transactions</p>
                                    </div>                                   
                                    <div class="col-auto">
                                        <div class="icon icon-shape bg-danger text-white rounded-circle shadow">
                                            <i class="fas fa-chart-bar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>  </div>
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="card-title text-uppercase text-muted mb-0">Average Performance</h5>
                                        <span class="h2 font-weight-bold mb-0">${avg_sales} Transactions</span>
                                    </div>
                                    
                                    <div class="col-auto">
                                        <div class="icon icon-shape bg-danger text-white rounded-circle shadow">
                                            <i class="fas fa-chart-bar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>  
                </div>
            </div>
        </section>

        <script>
            if (performance.navigation.type === performance.navigation.TYPE_RELOAD) {
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Salesman_Reports?year=${year}&month=${month}");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

   </body>
</html>

<%-- 
    Document   : car_reports
    Created on : Mar 3, 2023, 2:33:17 PM
    Author     : Vincci
--%>

<%@page import="model.Sales"%>
<%@page import="model.Cars"%>
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
    List<Sales> sales = (List<Sales>)request.getAttribute("sales");
    List<Cars> cars = (List<Cars>)request.getAttribute("cars");
    List<String> models = (List<String>)request.getAttribute("unique_models");
    Map<String, Integer> model_reviews = (Map<String, Integer>)request.getAttribute("model_reviews");
    Map<String, Integer> model_ratings = (Map<String, Integer>)request.getAttribute("model_ratings");
    String[] full_months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "Octocber", "November", "December"};
    int int_month = Integer.valueOf(request.getParameter("month"));
    String full_month = "";
    if (request.getAttribute("display_type").equals("month")){
        full_month = full_months[int_month-1];
    };
    int percentage = 0;

        for(String model: models){
            int count = 0;
            for (Cars c: cars){
                String found_model = c.getModel();
                if (found_model.equals(model)){
                    count++;
                }
            }
            if(sales.size() > 0){
                percentage = count*100/sales.size();
            
                map = new HashMap<Object,Object>(); 
                map.put("label", model); 
                map.put("y", percentage); 
                map.put("count", count);
                list.add(map);
            }
        }
        
        for(String model: models){
            map = new HashMap<Object,Object>(); 
            map.put("label", model); 
            map.put("y", model_ratings.get(model)); 
            map.put("count", model_reviews.get(model));
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
                var title = "";
                var title2 = "";
                var subtitle = "";
                
                if (display_type === "month"){
                    month = document.getElementById("full_month").value;
                    title = "Monthly Car Transaction";
                    title2 = "Monthly Bought Car Ratings";
                    subtitle = year + " - " + month;
                }else{
                    title = "Annual Car Transaction";
                    title2 = "Annual Bought Car Ratings";
                    subtitle = year;
                }

                var chart = new CanvasJS.Chart("piechartContainer", {
                    theme: "light2",
                    animationEnabled: true,
                    title:{
                            text: title
                    },
                    subtitles: [{
                            text: subtitle
                    }],
                    data: [{
                            type: "pie",
                            showInLegend: true,
                            legendText: "{label}",
                            toolTipContent: "{label}: <strong> {count} transactions</strong>",
                            indexLabel: "{label} {y}%",
                            dataPoints : <%out.print(dataPoints);%>
                    }]
                });
                chart.render();

                var chart = new CanvasJS.Chart("barchartContainer", {
                    theme: "light2",
                    title: {
                            text: title2
                    },
                    subtitles: [{
                            text: subtitle
                    }],
                    axisY: {
                            title: "Ratings"
                    },
                    data: [{
                            type: "bar",
                            indexLabel: "{y}",
                            indexLabelFontColor: "#444",
                            indexLabelPlacement: "inside",
                            toolTipContent: "<strong> {count} Reviews</strong>",
                            dataPoints: <%out.print(dataPoints2);%>
                    }]
                });
                chart.render();

            }
        </script>
        <title>VCars Corp</title>
    </head>
    <body style="background-color: #eee;">
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
                                <h5 class="card-title">${display_type eq 'year' ? 'Annual' : 'Monthly'} Car Statistics</h5>
                                <form action="Car_Reports" method="post">
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
                                <div class="card-text" id="piechartContainer" style="width: 50%"></div>
                                <div class="card-text" id="barchartContainer" style="width: 50%"></div>
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
                                        <h5 class="card-title text-uppercase text-muted mb-0">Most Popular Model</h5>
                                        <span class="h2 font-weight-bold mb-0">${highest_count}</span>
                                    </div>
                                    <div class="col">
                                        <p class="mt-4 mb-0 text-muted text-sm">${model_counts.get(highest_count)} Transactions</p>
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
                                        <h5 class="card-title text-uppercase text-muted mb-0">Highest Rating Model</h5>
                                        <span class="h2 font-weight-bold mb-0">${highest_ratings}</span>
                                    </div>
                                    <div class="col">
                                        <p class="mt-3 mb-0 text-muted text-sm">${model_ratings.get(highest_ratings)} Stars</p>
                                        <p class="mb-0 text-muted text-sm">(${model_reviews.get(highest_ratings)} Reviews)</p>
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
                                        <h5 class="card-title text-uppercase text-muted mb-0">Least Popular Model</h5>
                                        <span class="h2 font-weight-bold mb-0">${lowest_count}</span>
                                    </div>
                                    <div class="col">
                                        <p class="mt-4 mb-0 text-muted text-sm">${model_counts.get(lowest_count)} Transactions</p>
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
                                        <h5 class="card-title text-uppercase text-muted mb-0">Lowest Rating Model</h5>
                                        <span class="h2 font-weight-bold mb-0">${lowest_ratings}</span>
                                    </div>
                                    <div class="col">
                                        <p class="mt-3 mb-0 text-muted text-sm">${model_ratings.get(lowest_ratings)} Stars </p>
                                        <p class="mb-0 text-muted text-sm">(${model_reviews.get(lowest_ratings)} Reviews)</p>
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
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Car_Reports?year=${year}&month=${month}");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    </body>
</html>

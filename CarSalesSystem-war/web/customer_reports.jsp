<%-- 
    Document   : customer_reports
    Created on : Mar 3, 2023, 4:09:24 PM
    Author     : Vincci
--%>

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
    Map<String, Integer> ages = (Map<String, Integer>)request.getAttribute("ages");
    Map<String, Integer> genders = (Map<String, Integer>)request.getAttribute("genders");
    List<String> total_customer = (List<String>)request.getAttribute("customers");

    for(Map.Entry<String, Integer> a: ages.entrySet()){
        int percentage = a.getValue()*100/total_customer.size();
        
        map = new HashMap<Object,Object>(); 
        map.put("label", a.getKey()); 
        map.put("y", percentage); 
        map.put("count", a.getValue());
        list.add(map);
    }
    
    for(Map.Entry<String, Integer> g: genders.entrySet()){
        int percentage = g.getValue()*100/total_customer.size();
        
        map = new HashMap<Object,Object>(); 
        map.put("label", g.getKey()); 
        map.put("y", percentage); 
        map.put("count", g.getValue());
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

                var chart = new CanvasJS.Chart("piechartContainer", {
                    theme: "light2",
                    animationEnabled: true,
                    title:{
                            text: "Age Groups"
                    },
                    subtitles: [{
                            text: "Users (All)"
                    }],
                    data: [{
                        type: "pie",
                        showInLegend: true,
                        legendText: "{label}",
                        toolTipContent: "{label}: <strong> {count} users</strong>",
                        indexLabel: "{label} {y}%",
                        dataPoints : <%out.print(dataPoints);%>
                    }]
                });
                chart.render();

                var chart = new CanvasJS.Chart("pie2chartContainer", {
                    theme: "light2",
                    animationEnabled: true,
                    title:{
                            text: "Gender Groups"
                    },
                    subtitles: [{
                            text: "Users (All)"
                    }],
                    data: [{
                        type: "pie",
                        showInLegend: true,
                        legendText: "{label}",
                        toolTipContent: "{label}: <strong> {count} users</strong>",
                        indexLabel: "{label} {y}%",
                        dataPoints : <%out.print(dataPoints2);%>
                    }]
                });
                chart.render();

            }
        </script>
        <title>VCars Corp</title>
    </head>
    <body>
        <jsp:include page="banner.jsp" />  

        <section class="" style="background-color: #eee; height: 100%;">
            <div class= "d-flex flex-column align-items-center mx-auto" style="width: 90%;">
                <div class="d-flex align-items-start align-items-center" style="width: 100%; height: 100%; padding-top: 20px; padding-bottom: 20px;">
                    <div class="card" style="width: 100%; height: 100%">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="card-title">Customer Statistics</h5>
                            </div><br>
                            <div class="d-flex justify-content-between" style="height: 300px;">
                                <div class="card-text" id="piechartContainer" style="width: 50%"></div>
                                <div class="card-text" id="pie2chartContainer" style="width: 50%"></div>
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
                                        <h5 class="card-title text-uppercase text-muted mb-0">Biggest Age Group</h5>
                                        <span class="h2 font-weight-bold mb-0">${biggest_age}</span>
                                    </div>
                                    <div class="col">
                                        <p class="mt-4 mb-0 text-muted text-sm">${ages.get(biggest_age)} Users</p>
                                    </div>
                                    <div class="col-auto">
                                        <div class="icon icon-shape bg-danger text-white rounded-circle shadow">
                                            <i class="fas fa-chart-bar"></i></span>
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
                                        <h5 class="card-title text-uppercase text-muted mb-0">Purchase Rate</h5>
                                        <span class="h2 font-weight-bold mb-0">${avg_purchase} %</span>
                                    </div>
                                    <div class="col">
                                        <p class="mt-4 mb-0 text-muted text-sm">${unique_customers.size()} out of ${customers.size()} users</p>
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
                                        <h5 class="card-title text-uppercase text-muted mb-0">Biggest Gender Group</h5>
                                        <span class="h2 font-weight-bold mb-0">${biggest_gender}</span>
                                    </div>
                                    <div class="col">
                                        <p class="mt-4 mb-0 text-muted text-sm">${genders.get(biggest_gender)} Users</p>
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
                                        <h5 class="card-title text-uppercase text-muted mb-0">Feedback Rate</h5>
                                        <span class="h2 font-weight-bold mb-0">${avg_feedback} %</span>
                                    </div>
                                    <div class="col">
                                        <p class="mt-4 mb-0 text-muted text-sm">${total_rated_sales} out of ${total_sales} purchases</p>
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
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Customer_Reports?type=${type}");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    </body>
</html>

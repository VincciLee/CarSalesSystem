<%-- 
    Document   : sales_reports
    Created on : Mar 3, 2023, 11:10:00 AM
    Author     : Vincci
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="model.Cars"%>
<%@page import="model.Sales"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>

<%
    Gson gsonObj = new Gson();
    Map<Object,Object> map = null;
    List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
    List<Sales> sales = (List<Sales>)request.getAttribute("sales");
    Hashtable<String, Cars> cars = (Hashtable<String, Cars>)request.getAttribute("cars");
    String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    String[] full_months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "Octocber", "November", "December"};
    String[] int_months = {"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"};
    String full_month = "";
    
    if (request.getAttribute("display_type").equals("year")){
        for(int i=0; i<12; i++){
            int count = 0;
            float rm_sales = 0;
            String date = request.getAttribute("year")+"-"+int_months[i];
            for (Sales s: sales){
                String sales_date = s.getCompleted_date().toString();
                if (sales_date.contains(date)){
                    count++;
                    rm_sales += cars.get(s.getCar_id().toString()).getPrice();
                }
            }
            
            map = new HashMap<Object,Object>(); 
            map.put("label", months[i]); 
            map.put("y", count); 
            map.put("sales", Float.toString(rm_sales));
            list.add(map);
        }
    }else if (request.getAttribute("display_type").equals("month")){
        int int_year = Integer.valueOf(request.getParameter("year"));
        int int_month = Integer.valueOf(request.getParameter("month"));
        full_month = full_months[int_month-1];
        int days = LocalDate.of(Integer.valueOf(int_year), Integer.valueOf(int_month), 1).lengthOfMonth();
        
        for(int i=1; i<=days; i++){
            int count = 0;
            float rm_sales = 0;
            String day = Integer.toString(i);
            if(i<10){
                day = "0"+day;
            }
            String date = request.getAttribute("year")+"-"+request.getAttribute("month")+"-"+day;
            
            for (Sales s: sales){
                String sales_date = s.getCompleted_date().toString();
                if (sales_date.contains(date)){
                    count++;
                    rm_sales += cars.get(s.getCar_id().toString()).getPrice();
                }
            }
                        
            map = new HashMap<Object,Object>(); 
            map.put("label", day); 
            map.put("y", count); 
            map.put("sales", Float.toString(rm_sales));
            list.add(map);
        }
    }
    
    String dataPoints = gsonObj.toJson(list);
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
                var subtitle = "";
                var x = "";
                
                if (display_type === "month"){
                    month = document.getElementById("full_month").value;
                    title = "Monthly Sales";
                    subtitle = year + " - " + month;
                    x = "Days";
                }else{
                    title = "Annual Sales";
                    subtitle = year;
                    x = "Months";
                }
                
                var chart = new CanvasJS.Chart("chartContainer", {
                        title: {
                                text: title
                        },
                        subtitles: [{
                                text: subtitle
                        }],
                        axisX: {
                                title: x
                        },
                        axisY: {
                                title: "Transactions",
                                includeZero: true
                        },
                        data: [{
                                type: "column",
                                toolTipContent: "<strong> RM {sales}</strong>",
//                                yValueFormatString: "RM {y} {label} {sales}",
                                dataPoints: <%out.print(dataPoints);%>
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
                                <h5 class="card-title">${display_type eq 'year' ? 'Annual' : 'Monthly'} Sales Statistics</h5>
                                <form action="Sales_Reports" method="post">
                                    <div class="input-group" style="width: 30vw">
                                        <input type="number" id="form3Example4c" class="form-control" name="year" value="${year}" min="1900" max="2023" required/>
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
                            <div class="card-text h-90" id="chartContainer" style="height: 300px;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="row row-cols-2" style="width: 100%; padding-bottom: 20px;">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="card-title text-uppercase text-muted mb-0">Total Sales</h5>
                                        <span class="h2 font-weight-bold mb-0">RM ${Math.round(total_sales)}</span>
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
                                        <h5 class="card-title text-uppercase text-muted mb-0">Total Transactions</h5>
                                        <span class="h2 font-weight-bold mb-0">${sales.size()}</span>
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
                                        <h5 class="card-title text-uppercase text-muted mb-0">Average Sales</h5>
                                        <c:if test="${display_type eq 'year'}">
                                            <span class="h2 font-weight-bold mb-0">RM ${Math.round(total_sales/max_month)}</span>
                                        </c:if>
                                        <c:if test="${display_type eq 'month'}">
                                            <span class="h2 font-weight-bold mb-0">RM ${Math.round(total_sales/days)}</span>
                                        </c:if>
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
                                        <h5 class="card-title text-uppercase text-muted mb-0">Average Transactions</h5>
                                        <c:if test="${display_type eq 'year'}">
                                            <span class="h2 font-weight-bold mb-0">${Math.round(sales.size()/max_month)}</span>
                                        </c:if>
                                        <c:if test="${display_type eq 'month'}">
                                            <span class="h2 font-weight-bold mb-0">${Math.round(sales.size()/days)}</span>
                                        </c:if>
                                        
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
                window.location.replace("http://localhost:8080/CarSalesSystem-war/Sales_Reports?year=${year}&month=${month}");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    </body>
</html>

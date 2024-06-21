<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Attendance</title>
    <style>
    .photo{
    float:right;
    margin-left:10px;
    }
    </style>
</head>
<body>
    <h2>Student Attendance</h2>
    <%
        // Retrieve student ID and attendance percentage from request attributes set by the servlet
        String studentId = (String) request.getAttribute("studentId");
        double attendancePercentage = (double) request.getAttribute("attendancePercentage");
        boolean lowattendance=attendancePercentage<=75.0;
        boolean highattendance=attendancePercentage>75.0;
        String path=(String)request.getAttribute("photourl");
        
    %>
    <h3>Student ID: <%= studentId %></h3>
    <h3>Attendance Percentage: <%= String.format("%.2f", attendancePercentage) %> %</h3>
   
    <% if(lowattendance){ %>
    <h1 style="color:red;"><strong>Your Attendance is Less than 75%</strong></h1>
    <img src="sad.gif" alt=sad emojii>
    <h1>Dont Worryy..Go to college daily</h1>
    <%} %>
    <% if(highattendance){ %>
    <h1 style="color:green;"><strong>Hurray!!Your Attendance is greater than 75%</strong></h1>
   	<img src="happy.gif" alt="happyemoji">
   	<h2>Common Its not a big deal..</h2>
    <%} %>
</body>
</html>

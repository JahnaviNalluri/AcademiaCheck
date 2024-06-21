<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Tracking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
          tr.low-attendance {
            background-color: #FFCCCC; /* Light red */
        }
    </style>
</head>
<body>
    <h2>Attendance Tracking</h2>
    <table>
        <thead>
            <tr>
                <th>Student ID</th>
                <th>Attendance Percentage</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Establish database connection
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Jahnavi");
                    
                    // Query to retrieve attendance data
                    String query = "SELECT studentid, absentdays, days FROM attend";
                    pstmt = con.prepareStatement(query);
                    rs = pstmt.executeQuery();
                    
                    // Process and display attendance data
                    while (rs.next()) {
                        String studentId = rs.getString("studentid");
                        int absentDays = rs.getInt("absentdays");
                        int totalDays = rs.getInt("days");
                        double attendancePercentage = ((double) (totalDays - absentDays) / totalDays) * 100;
            %>
            <tr class="<%=attendancePercentage < 75 ?"low-attendance":""%>">
                <td><%= studentId %></td>
                <td><%= String.format("%.2f", attendancePercentage) %> %</td>
            </tr>
            <% 
                    }
                } catch (SQLException se) {
                    se.printStackTrace(); // Handle SQLException
                } catch (ClassNotFoundException e) {
                    e.printStackTrace(); // Handle ClassNotFoundException
                } finally {
                    // Close database resources
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (con != null) con.close();
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>
     <button onClick="menupage()" >Back</button>
    <script>
    function menupage(){
    	window.location.href="a3index.html";
    }
    </script>
   
</body>
</html>

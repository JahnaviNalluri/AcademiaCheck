<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<style>
 table{
 width:50%;
 }
 th, td {
            padding: 10px; /* Adjust the padding for cells */
            text-align: left; /* Align text to the left in cells */
            font-size:25px;
        }
        th:nth-child(2), td:nth-child(2) {
            width: 50%; /* Set the width of the second column */
        }
        .id1{
        width:200px;
        height:50px;
        font-size:20px;
        }
       	.cb{
       	  transform: scale(1.5);
       	}
</style>
    <meta charset="UTF-8">
    <title>Attendance</title>
</head>
<body>
    <h2>Mark Attendance</h2>
    <form action="Attendanceservlet1" method="post">
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Attendance</th>
            </tr>
            <% 
            Connection con = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Jahnavi");
                String query = "SELECT studentid FROM attend";
                stmt = con.prepareStatement(query);
                rs = stmt.executeQuery();
                ResultSetMetaData rsmd = rs.getMetaData();
                int columnCount = rsmd.getColumnCount();
                while (rs.next()) { 
            %>
                <tr>
                    <% for (int i = 1; i <= columnCount; i++) { %>
                        <td><%= rs.getString(i) %></td>
                    <% } %>
                    <td><input type="checkbox" name="attendanceIds" class="cb"  value="<%= rs.getString(1) %>"></td>
                </tr>
            <% 
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace(); 
            } finally {
                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (stmt != null) {
                    try {
                        stmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
            %>
        </table><br><br>
  
        <input type="submit" value="Submit Attendance" class="id1">
    </form>
</body>
</html>
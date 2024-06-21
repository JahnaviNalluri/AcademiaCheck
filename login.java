package attendance;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user = request.getParameter("userName");
        String pass = request.getParameter("userPass");
        RequestDispatcher rd;

        if (user.equals("Admin") && pass.equals("Admin@123")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("a3index.html");
            dispatcher.forward(request, response);
        } else if (pass.equals("12345")) {
            for (int i = 60; i <= 70; i++) {
                if (user.equals("22BQ1A12" + i)) {
                    Connection con = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Jahnavi");
                        String query = "SELECT absentdays, days FROM attend WHERE studentid = ?";
                        pstmt = con.prepareStatement(query);
                        pstmt.setString(1, user);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            int absentDays = rs.getInt("absentdays");
                            int totalDays = rs.getInt("days");
                            double attendancePercentage = ((double) (totalDays - absentDays) / totalDays) * 100;
                            request.setAttribute("attendancePercentage", attendancePercentage);
                            request.setAttribute("studentId", user);
                            
                            RequestDispatcher dispatcher = request.getRequestDispatcher("studentattendance.jsp");
                            dispatcher.forward(request, response);
                            return; // Exit the loop after forwarding the request
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null)
                                rs.close();
                            if (pstmt != null)
                                pstmt.close();
                            if (con != null)
                                con.close();
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    }
                }
            }
        } else {
        	 rd = request.getRequestDispatcher("/aindex.html");
        	   System.out.print("Sorry UserName or Password Error!");
        	   rd.include(request, response);
        	  
        	    // Add JavaScript code to display an alert message
        	    response.getWriter().println("<script>alert('Sorry, username or password is incorrect.');</script>");

        }
    }
}

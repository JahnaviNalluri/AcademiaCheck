package attendance;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Attendanceservlet1")
public class Attendanceservlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] attendanceIds = request.getParameterValues("attendanceIds");
        Connection con = null;
        PreparedStatement stmt = null;
        PrintWriter out = response.getWriter(); // Get PrintWriter from HttpServletResponse
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Jahnavi");
            String query = "UPDATE attend SET absentdays=absentdays+1 WHERE studentid = ?";
            String q1="UPDATE attend SET days=days+1";
            if (attendanceIds != null) {
                for (String id : attendanceIds) {
                    stmt = con.prepareStatement(query); // Create new prepared statement for each ID
                    stmt.setString(1, id);
                    stmt.executeUpdate();
                    stmt.close(); // Close the prepared statement after use
                }
            }
           
            stmt=con.prepareStatement(q1);
            stmt.executeUpdate();
            stmt.close();
			
			out.println("<script>");
           out.println("alert('Attendance submitted successfully!');");
           out.println("window.location.href = 'a3index.html';");
           out.println("</script>");
       
            //response.sendRedirect("a4index.html"); // Redirect to a success page
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("aindex.html"); // Redirect to an error page
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

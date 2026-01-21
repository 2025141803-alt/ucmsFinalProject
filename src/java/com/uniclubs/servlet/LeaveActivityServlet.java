import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
// Example: Change 'com.app.models' to your actual package name
import com.uniclubs.model.User;

@WebServlet("/LeaveActivityServlet")
public class LeaveActivityServlet extends HttpServlet {

   protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    String activityIdStr = request.getParameter("activityId");
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");

    if (user != null && activityIdStr != null) {
        int studentId = user.getUserId();
        int activityId = Integer.parseInt(activityIdStr);

        // USE YOUR DBCONNECTION CLASS HERE
        try (Connection conn = com.uniclubs.dao.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "DELETE FROM ACTIVITY_REGISTRATION WHERE STUDENT_ID = ? AND ACTIVITY_ID = ?")) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, activityId);

            int rowsDeleted = ps.executeUpdate();

            if (rowsDeleted > 0) {
                response.sendRedirect("myJoinedActivities?msg=leaveSuccess");
            } else {
                response.sendRedirect("myJoinedActivities?msg=notDeleted");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("myJoinedActivities?msg=error");
        }
    } else {
        response.sendRedirect("login.jsp");
    }
}
}
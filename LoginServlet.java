import classes.JDBC;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String errorMessage = "";
        
        JDBC db = new JDBC();
        if (db.isConnected) {
            try {
                String query = "SELECT id, role FROM users WHERE username = ? AND password = ?";
                PreparedStatement ps = db.conn.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("username", username);
                    session.setAttribute("role", rs.getString("role"));
                    response.sendRedirect("dashboard.jsp");
                } else {
                    errorMessage = "Invalid username or password!";
                    request.setAttribute("errorMessage", errorMessage);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } catch (IOException | SQLException | ServletException e) {
                errorMessage = "Error: " + e.getMessage();
                request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } finally {
                db.disconnect();
            }
        } else {
            errorMessage = "Database connection failed!";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}

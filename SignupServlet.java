package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String errorMessage = "";
        String successMessage = "";

        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/movies_db", "root", "");

            String query = "INSERT INTO users (username, password, role) VALUES (?, ?, 'user')";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.executeUpdate();

            successMessage = "Signup successful! You can now log in.";
            request.setAttribute("successMessage", successMessage);
        } catch (SQLException | ClassNotFoundException e) {
            errorMessage = "Error: " + e.getMessage();
            request.setAttribute("errorMessage", errorMessage);
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }

        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}

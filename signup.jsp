<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #121212;
            color: #ffffff;
        }
        .container {
            margin-top: 100px;
            background-color: #1e1e1e;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .btn-primary {
            background-color: #f5c518;
            color: #121212;
        }
        .btn-primary:hover {
            background-color: #e3af0f;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center">Signup</h2>
        <%
            String errorMessage = "";
            String successMessage = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

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
                } catch (SQLException e) {
                    errorMessage = "Error: " + e.getMessage();
                } finally {
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            }
        %>
        <% if (!errorMessage.isEmpty()) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>
        <% if (!successMessage.isEmpty()) { %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% } %>
        <form action="signup.jsp" method="post">
            <div class="mb-3">
                <label>Username</label>
                <input type="text" name="username" class="form-control bg-dark text-white" required>
            </div>
            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" class="form-control bg-dark text-white" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Signup</button>
        </form>
        <div class="mt-3 text-center">
            <a href="login.jsp" class="btn btn-link text-warning">Already have an account? Login</a>
        </div>
    </div>
</body>
</html>

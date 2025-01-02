<%-- 
    Document   : login
    Created on : 31 Dec 2024, 5:04:56?am
    Author     : umaml
--%>

<%@ page import="java.sql.*" %>
<%@ page import="classes.JDBC" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #121212;
            color: #e0e0e0;
            font-family: Arial, sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-container {
            background-color: #1c1c1c;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 400px;
        }
        .login-title {
            text-align: center;
            color: #f5c518; /* IMDb yellow */
            margin-bottom: 20px;
            font-weight: bold;
        }
        .form-control {
            background-color: #292929;
            border: none;
            color: #e0e0e0;
        }
        .form-control:focus {
            background-color: #292929;
            color: #ffffff;
            box-shadow: 0 0 0 0.2rem rgba(245, 197, 24, 0.25);
        }
        .btn-primary {
            background-color: #f5c518;
            color: #121212;
            border: none;
            font-weight: bold;
        }
        .btn-primary:hover {
            background-color: #e4b50e;
        }
        .alert {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2 class="login-title">Login</h2>
        <%
            String errorMessage = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                JDBC db = new JDBC();
                if (db.isConnected) {
                    try {
                        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
                        PreparedStatement ps = db.conn.prepareStatement(query);
                        ps.setString(1, username);
                        ps.setString(2, password);
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            session.setAttribute("userId", rs.getInt("id"));
                            session.setAttribute("username", username);
                            response.sendRedirect("dashboard.jsp");
                        } else {
                            errorMessage = "Invalid username or password!";
                        }
                    } catch (Exception e) {
                        errorMessage = "Error: " + e.getMessage();
                    } finally {
                        db.disconnect();
                    }
                }
            }
        %>
        <% if (!errorMessage.isEmpty()) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>
        <form action="login.jsp" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
    </div>
</body>
</html>

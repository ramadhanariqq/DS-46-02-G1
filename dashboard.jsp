<%-- 
    Document   : dashboard
    Created on : 31 Dec 2024, 5:05:16?am
    Author     : umaml
--%>

<%@ page import="java.sql.*" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (userId == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #1c1c1e;
            color: #ffffff;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 80px;
        }
        .card {
            background-color: #292929;
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: bold;
        }
        .btn {
            border-radius: 8px;
            font-weight: 600;
        }
        .btn-primary {
            background-color: #4caf50;
            border: none;
        }
        .btn-primary:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #5a5a5a;
            border: none;
        }
        .btn-secondary:hover {
            background-color: #4e4e4e;
        }
        .btn-danger {
            background-color: #d9534f;
            border: none;
        }
        .btn-danger:hover {
            background-color: #c9302c;
        }
        h1 {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 40px;
        }
        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome, <%= username %></h1>
        <p class="text-center">Role: <%= role %></p>
        <div class="action-buttons">
            <% if ("admin".equals(role)) { %>
                <a href="movies_admin.jsp" class="btn btn-primary btn-lg">Manage Movies</a>
            <% } else { %>
                <a href="movies_user.jsp" class="btn btn-primary btn-lg">Browse Movies</a>
                <a href="watch_history.jsp" class="btn btn-secondary btn-lg">View Watch History</a>
                <a href="recommend.jsp" class="btn btn-success btn-lg">Get Recommendations</a>
            <% } %>
            <a href="logout.jsp" class="btn btn-danger btn-lg">Logout</a>
        </div>
    </div>
</body>
</html>

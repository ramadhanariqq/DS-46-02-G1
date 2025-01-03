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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #1c1c1e;
            color: #ffffff;
            font-family: 'Arial', sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .container {
            margin-top: 80px;
            flex: 1; /* jangan diubah, buat auto grow main konten */
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #292929;
            padding: 15px 20px;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .header .logo-title {
            display: flex;
            align-items: center;
        }
        .header .logo {
            font-size: 24px;
            font-weight: bold;
            color: #ffffff;
            margin-right: 10px;
        }
        .header .title {
            font-size: 20px;
            color: #ffffff;
        }
        .header .logout-btn {
            background-color: #d9534f;
            border: none;
            color: #ffffff;
            border-radius: 8px;
            padding: 8px 12px;
            font-weight: bold;
            text-decoration: none;
        }
        .header .logout-btn:hover {
            background-color: #c9302c;
            text-decoration: none;
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
        
        .footer {
            background-color: #000; 
            color: #fff; 
            padding: 40px 0; 
            text-align: center;
        }
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .logo-section .logo {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .logo-section p {
            font-size: 14px;
            margin: 0 0 20px;
        }
        .links-section {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-bottom: 20px; 
        }
        .links-section a {
            color: #fff;
            text-decoration: none;
            font-size: 14px;
        }
        .links-section a:hover {
            text-decoration: underline;
        }
        .divider {
            width: 80%;
            border-top: 1px solid #fff; 
            margin: 20px 0; 
        }
        .copyright-section {
            margin-top: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="logo-title">
            <div class="logo">LOGO</div>
            <div class="title">Movie Recommender</div>
        </div>
        <a href="logout.jsp" class="logout-btn">Logout</a>
    </header>

    <!-- Main Content -->
    <div class="container">
        <h1>Welcome <%= username %></h1>
        <div class="action-buttons">
            <% if ("admin".equals(role)) { %>
                <a href="movies_admin.jsp" class="btn btn-primary btn-lg">Manage Movies</a>
            <% } else { %>
                <a href="movies_user.jsp" class="btn btn-primary btn-lg">Browse Movies</a>
                <a href="watch_history.jsp" class="btn btn-secondary btn-lg">View Watch List</a>
                <a href="recommend.jsp" class="btn btn-success btn-lg">Get Recommendations</a>
            <% } %>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="logo-section">
                <div class="logo">LOGO</div>
                <p>EXPLORE YOUR MOVIES TASTE</p>
            </div>
            <div class="divider"></div>
            <div class="links-section">
                <a href="#">Weebly Themes</a>
                <a href="#">Pre-Sale FAQs</a>
                <a href="#">Submit a Ticket</a>
                <a href="#">Services</a>
                <a href="#">Theme Tweak</a>
                <a href="#">Showcase</a>
                <a href="#">Widgetkit</a>
                <a href="#">Support</a>
                <a href="#">About Us</a>
                <a href="#">Contact Us</a>
                <a href="#">Affiliates</a>
                <a href="#">Resources</a>
            </div>
            <div class="copyright-section">
                <p>©Copyright. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>

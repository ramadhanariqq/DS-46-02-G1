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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #1c1c1e;
            color: #ffffff;
            font-family: 'Poppins', sans-serif; /* Updated font */
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .container {
            margin-top: 80px;
            flex: 1; 
        }
        h1 {
            text-align: center;
            font-size: 2.8rem;
            margin-bottom: 40px;
            font-weight: 600;
            letter-spacing: 1px;
            color: #fff;
            line-height: 1.4;
        }
        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
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
        
        /* Button styles */
        .btn {
            border-radius: 4px;
            font-weight: 800;
            transition: all 0.3s ease; /* Smooth transition */
            width: 300px; /* Set fixed width for square shape */
            height: 300px; /* Set fixed height for square shape */
            color: #fff; /* Ensure text is readable */
            font-size: 1.5rem; /* Adjust font size */
            text-align: center; /* Center text */
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative; /* For positioning the overlay */
            overflow: hidden; /* Hide overflow content */
        }
        .btn::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('https://i.pinimg.com/originals/f5/b6/56/f5b65620846c52e859f39fe8ce4c1198.jpg');
            background-size: cover; /* Ensure background covers entire button */
            opacity: 0.25; /* Set opacity to 25% */
            z-index: 0; /* Place behind the text */
        }
        .btn-primary:hover, .btn-secondary:hover, .btn-success:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3); /* Shadow effect */
            transform: translateY(-3px); /* Lift effect */
        }
        .btn span {
            position: relative; /* Place text above the overlay */
            z-index: 1; /* Ensure text is above overlay */
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
        <h1>Welcome to a place to get your movies recommendations <%= username %> ! >w< </h1>
        <div class="action-buttons">
            <% if ("admin".equals(role)) { %>
                <a href="movies_admin.jsp" class="btn btn-primary"><span>Manage Movies</span></a>
            <% } else { %>
                <a href="movies_user.jsp" class="btn btn-primary"><span>Browse Movies</span></a>
                <a href="watch_history.jsp" class="btn btn-secondary"><span>View Watch List</span></a>
                <a href="recommend.jsp" class="btn btn-success"><span>Get Recommendations</span></a>
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

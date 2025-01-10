<%@ page import="java.sql.*" %>
<%@ page import="classes.JDBC" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('https://scontent.fbdo9-1.fna.fbcdn.net/v/t39.30808-6/308958460_206646401697986_4666114803412058324_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=cc71e4&_nc_eui2=AeHOQsp2wmJ84HR7HRW2XzXoRez-hJUE1chF7P6ElQTVyGjbBr54-kRCzWWl5fS3J5K5pUben1Mgn3SIvxZhmGE7&_nc_ohc=QyBfav_X-ukQ7kNvgEQn8pe&_nc_oc=AdgDZTpjMkdwZZHZAtg0X4Fro3F-W6Qbpr_4ivR9ZSrXthBMFxeHlED53KWa_sXpajM&_nc_zt=23&_nc_ht=scontent.fbdo9-1.fna&_nc_gid=AQJZx46mGIY95X_m8IVY_ey&oh=00_AYA98c8euqk0YGWnJoDpUhP9lsJ7GfP_ZFKbGBwaSqF1Kw&oe=677E1584'); /* Set the path to your image */
            background-size: cover; /* Ensure the background image covers the entire page */
            background-position: center center; /* Center the background image */
            color: #e0e0e0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            margin-top: 100px;
            background-color: #1c1c1c;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
            width: 100%;
            max-width: 420px;
            transition: all 0.3s ease;
        }
        .container:hover {
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.6);
        }
        .btn-primary {
            background-color: #f5c518;
            color: #121212;
            border: none;
            font-weight: 600;
            padding: 12px;
            text-transform: uppercase;
        }
        .btn-primary:hover {
            background-color: #e4b50e;
        }
        .btn-link {
            color: #f5c518;
            text-decoration: none;
            font-weight: 500;
        }
        .btn-link:hover {
            text-decoration: underline;
        }
        .alert {
            text-align: center;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #292929;
            padding: 20px 30px;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .header .logo-title {
            display: flex;
            align-items: center;
        }
        .header .logo {
            font-size: 28px;
            font-weight: bold;
            color: #ffffff;
            margin-right: 12px;
        }
        .header .title {
            font-size: 22px;
            color: #ffffff;
        }
        .footer {
            background-color: #000; 
            color: #fff; 
            padding: 18px 0; 
            text-align: center;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .footer p {
            margin: 0;
        }
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container {
                margin-top: 50px;
                padding: 25px;
            }
            .footer {
                padding: 12px 0;
            }
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
    </header>

    <!-- Main Content -->
    <div class="container">
        <h2 class="text-center mb-4">Login</h2>
        <%
            String errorMessage = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                JDBC db = new JDBC();
                if (db.isConnected) {
                    try {
                        String query = "SELECT id, role FROM users WHERE username = ? AND password = ?";
                        PreparedStatement ps = db.conn.prepareStatement(query);
                        ps.setString(1, username);
                        ps.setString(2, password);
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            session.setAttribute("userId", rs.getInt("id"));
                            session.setAttribute("username", username);
                            session.setAttribute("role", rs.getString("role"));
                            response.sendRedirect("dashboard.jsp");
                        } else {
                            errorMessage = "Invalid username or password!";
                        }
                    } catch (Exception e) {
                        errorMessage = "Error: " + e.getMessage();
                    } finally {
                        db.disconnect();
                    }
                } else {
                    errorMessage = "Database connection failed!";
                }
            }
        %>
        <% if (!errorMessage.isEmpty()) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>
        <form action="LoginServlet" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-control bg-dark text-white" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control bg-dark text-white" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <div class="mt-3 text-center">
            <a href="signup.jsp" class="btn btn-link">Don't have an account? Signup</a>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 Movie Recommender. All Rights Reserved.</p>
    </footer>
</body>
</html>

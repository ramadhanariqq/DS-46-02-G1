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
        <h2 class="text-center mb-4">Signup</h2>
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            String successMessage = (String) request.getAttribute("successMessage");
        %>
        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>
        <% if (successMessage != null && !successMessage.isEmpty()) { %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% } %>
        <form action="SignupServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control bg-dark text-white" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control bg-dark text-white" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Signup</button>
        </form>
        <div class="mt-3 text-center">
            <a href="login.jsp" class="btn btn-link">Already have an account? Login</a>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2024 Movie Recommender. All Rights Reserved.</p>
    </footer>
</body>
</html>

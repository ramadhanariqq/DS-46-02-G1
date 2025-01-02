<%-- 
    Document   : index
    Created on : 31 Dec 2024, 5:13:35?am
    Author     : umaml
--%>

<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Recommender</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #121212;
            color: #ffffff;
        }
        .container {
            margin-top: 100px;
            background-color: #1e1e1e;
            border-radius: 15px;
            padding: 20px;
        }
        .card {
            background-color: #292929;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
        }
        .card h4 {
            color: #f1f1f1;
        }
        .card p {
            color: #b0b0b0;
        }
        .btn {
            border-radius: 5px;
            padding: 12px;
        }
        .btn-primary {
            background-color: #6200ea;
            border-color: #6200ea;
        }
        .btn-primary:hover {
            background-color: #3700b3;
            border-color: #3700b3;
        }
        .btn-secondary {
            background-color: #03dac5;
            border-color: #03dac5;
        }
        .btn-secondary:hover {
            background-color: #018786;
            border-color: #018786;
        }
        .btn-success {
            background-color: #388e3c;
            border-color: #388e3c;
        }
        .btn-success:hover {
            background-color: #2c6c2f;
            border-color: #2c6c2f;
        }
        .btn-danger {
            background-color: #d32f2f;
            border-color: #d32f2f;
        }
        .btn-danger:hover {
            background-color: #9a0007;
            border-color: #9a0007;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center mb-5">Welcome to Movie Recommender</h1>
        
        <div class="row justify-content-center">
            <%
                // Check if the user is logged in
                Integer userId = (Integer) session.getAttribute("userId");
                String username = (String) session.getAttribute("username");

                if (userId != null) {
            %>
            <!-- User is logged in -->
            <div class="col-md-4">
                <div class="card text-center p-4">
                    <h4>Hi, <%= username %>!</h4>
                    <p>Choose an option below:</p>
                    <a href="recommend.jsp" class="btn btn-primary btn-block mb-3">Get Recommendations</a>
                    <a href="watch_history.jsp" class="btn btn-secondary btn-block mb-3">View Watch History</a>
                    <a href="movies.jsp" class="btn btn-success btn-block mb-3">Manage Movies</a>
                    <a href="logout.jsp" class="btn btn-danger btn-block">Logout</a>
                </div>
            </div>
            <%
                } else {
            %>
            <!-- User is not logged in -->
            <div class="col-md-4">
                <div class="card text-center p-4">
                    <h4>Start Your Journey</h4>
                    <p>Log in to explore personalized recommendations and movie history.</p>
                    <a href="login.jsp" class="btn btn-primary btn-block">Login</a>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

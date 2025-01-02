<%-- 
    Document   : recommend.jsp
    Created on : 31 Dec 2024, 5:05:41?am
    Author     : umaml
--%>
<%@ page import="classes.RecommendationEngine" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Movie Recommendations</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #121212;
            color: #e0e0e0;
            font-family: Arial, sans-serif;
        }
        h1 {
            color: #f5c518; /* IMDb yellow */
            font-weight: bold;
        }
        .card {
            background-color: #1c1c1c;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: scale(1.03);
        }
        .card-body {
            color: #e0e0e0;
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
        .container {
            margin-top: 50px;
        }
        .movie-poster {
            border-radius: 10px 10px 0 0;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Recommended Movies for You</h1>
        <div class="row mt-4">
            <%
                Connection conn = null;
                try {
                    // Connect to the database
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/movies_db", "root", "");

                    // Create the recommendation engine
                    RecommendationEngine engine = new RecommendationEngine(conn);

                    // Get recommendations for the logged-in user
                    int userId = (Integer) session.getAttribute("userId");
                    List<Map<String, String>> recommendations = engine.getRecommendations(userId);

                    // Display recommendations
                    for (Map<String, String> movie : recommendations) {
            %>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="<%= movie.get("poster_url") %>" class="card-img-top" alt="<%= movie.get("title") %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= movie.get("title") %></h5>
                        <p class="card-text"><%= movie.get("synopsis") %></p>
                        <p><strong>Genre:</strong> <%= movie.get("genre") %></p>
                        <p><strong>Duration:</strong> <%= movie.get("duration") %> mins</p>
                    </div>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (conn != null) {
                        try {
                            conn.close();
                        } catch (SQLException ignore) {}
                    }
                }
            %>
        </div>
        <div class="text-center mt-4">
            <a href="dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
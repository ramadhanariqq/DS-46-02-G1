<%-- 
    Document   : movies
    Created on : 31 Dec 2024, 6:30:00 AM
    Author     : umaml
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    if (userId == null || !"user".equals(role)) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Movies</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #121212;
            color: #ffffff;
        }
        .container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center">Browse Movies</h1>
        <div class="row">
            <%
                Connection conn = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/movies_db", "root", "");

                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM movies");
                    while (rs.next()) {
            %>
            <div class="col-md-4">
                <div class="card bg-dark text-white mb-3">
                    <img src="<%= rs.getString("poster_url") %>" alt="<%= rs.getString("title") %>" class="card-img-top">
                    <div class="card-body">
                        <h5 class="card-title"><%= rs.getString("title") %></h5>
                        <p><strong>Genre:</strong> <%= rs.getString("genre") %></p>
                        <p><strong>Duration:</strong> <%= rs.getInt("duration") %> mins</p>
                        <p><%= rs.getString("synopsis") %></p>
                        <form method="POST" action="add_to_watchlist.jsp" class="mt-2">
                            <input type="hidden" name="movie_id" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="btn btn-primary btn-sm">Add to Watchlist</button>
                        </form>
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

        <a href="dashboard.jsp" class="btn btn-secondary mt-4">Back to Dashboard</a>
    </div>
</body>
</html>

<%-- 
    Document   : watch_history
    Created on : 31 Dec 2024, 5:06:53?am
    Author     : umaml
--%>

<%@ page import="java.sql.*" %>
<%@ page import="classes.JDBC" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Watch History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #121212;
            color: #e0e0e0;
            font-family: Arial, sans-serif;
        }
        h1 {
            color: #f5c518; 
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
    <div class="container">
        <h1 class="text-center">Watch List</h1>
        <div class="row mt-4">
            <%
                JDBC db = new JDBC();
                if (db.isConnected) {
                    try {
                        String query = "SELECT u.username AS user_name, m.title AS movie_title, m.genre AS movie_genre, " +
                                       "m.duration AS movie_duration, m.synopsis AS movie_synopsis, m.poster_url AS movie_poster, uwh.watched_at AS watched_date " +
                                       "FROM user_watch_history uwh " +
                                       "JOIN users u ON uwh.user_id = u.id " +
                                       "JOIN movies m ON uwh.movie_id = m.id " +
                                       "WHERE u.id = ? ORDER BY uwh.watched_at DESC";
                        PreparedStatement ps = db.conn.prepareStatement(query);
                        ps.setInt(1, 1); 
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
            %>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="<%= rs.getString("movie_poster") %>" class="card-img-top movie-poster" alt="<%= rs.getString("movie_title") %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= rs.getString("movie_title") %></h5>
                        <p class="card-text"><%= rs.getString("movie_synopsis") %></p>
                        <p><strong>Genre:</strong> <%= rs.getString("movie_genre") %></p>
                        <p><strong>Duration:</strong> <%= rs.getInt("movie_duration") %> mins</p>
                        <p><strong>Added On:</strong> <%= rs.getTimestamp("watched_date") %></p>
                    </div>
                </div>
            </div>
            <%
                        }
                    } catch (Exception e) {
                        out.println("<div class='text-danger'>Error: " + e.getMessage() + "</div>");
                    } finally {
                        db.disconnect();
                    }
                } else {
                    out.println("<div class='text-danger'>Error: " + db.message + "</div>");
                }
            %>
        </div>
        <div class="text-center mt-4">
            <a href="dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>

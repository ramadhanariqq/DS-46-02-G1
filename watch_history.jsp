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
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333;
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
        <h1 class="text-center">Watch History</h1>
        <div class="row mt-4">
            <%
                
                Integer userId = (Integer) session.getAttribute("userId");
                if (userId == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                JDBC db = new JDBC();
                if (db.isConnected) {
                    try {
                        String query = "SELECT u.username AS user_name, m.title AS movie_title, m.genre AS movie_genre, " +
                                       "m.duration AS movie_duration, m.synopsis AS movie_synopsis, m.poster_url AS movie_poster, uwh.movie_id AS movie_id, uwh.watched_at AS watched_date " +
                                       "FROM user_watch_history uwh " +
                                       "JOIN users u ON uwh.user_id = u.id " +
                                       "JOIN movies m ON uwh.movie_id = m.id " +
                                       "WHERE u.id = ? ORDER BY uwh.watched_at DESC";
                        PreparedStatement ps = db.conn.prepareStatement(query);
                        ps.setInt(1, userId);
                        ResultSet rs = ps.executeQuery();

                        boolean hasMovies = false;
                        while (rs.next()) {
                            hasMovies = true;
            %>
            <div class="col-md-4 mb-4">
        <div class="card h-100">
            <a href="moviereview.jsp?movieId=<%= rs.getInt("movie_id") %>" class="text-decoration-none">
                <img src="<%= rs.getString("movie_poster") %>" class="card-img-top movie-poster" alt="<%= rs.getString("movie_title") %>">
            </a>
            <div class="card-body">
                <h5 class="card-title"><%= rs.getString("movie_title") %></h5>
                <p class="card-text"><%= rs.getString("movie_synopsis") %></p>
                <p><strong>Genre:</strong> <%= rs.getString("movie_genre") %></p>
                <p><strong>Duration:</strong> <%= rs.getInt("movie_duration") %> mins</p>
                <p><strong>Added On:</strong> <%= rs.getTimestamp("watched_date") %></p>
                <form method="POST" action="watchlist" class="mt-2">
                    <input type="hidden" name="movie_id" value="<%= rs.getInt("movie_id") %>">
                    <input type="hidden" name="action" value="remove">
                    <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                </form>
            </div>
        </div>
    </div>
            <%
                        }
                        if (!hasMovies) {
                            out.println("<div class='text-center text-warning mt-4'>Your watchlist is empty.</div>");
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

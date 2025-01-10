<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    if (userId == null || !"user".equals(role)) {
        response.sendRedirect("login.jsp");
    }
    
    String message = (String) session.getAttribute("message");
    if (message != null) {
        session.removeAttribute("message");
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
            background-color: #1c1c1e;
            color: #ffffff;
        }
        .card {
            background-color: #292929;
            border: none;
            border-radius: 12px;
            color: #ffffff;
            position: relative;
        }
        .card-img-top {
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }
        .footer {
            background-color: #000;
            color: #fff;
            padding: 20px 0;
            text-align: center;
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
            margin: 20px auto;
        }
        .text-center h1 {
            margin-bottom: 40px;
        }
        .btn-watchlist {
            position: absolute;
            bottom: 12px;
            left: 12px;
            z-index: 3; /* Pastikan ini lebih besar dari link */
        }
    </style>
</head>
<body class="bg-dark text-white">

    <!-- Main Content -->
    <div class="container my-4">
        <h1 class="text-center mb-4">Browse Movies</h1>
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <%
                Connection conn = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/movies_db", "root", "");

                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM movies");
                    boolean hasMovies = false;

                    while (rs.next()) {
                        hasMovies = true;
            %>
            <div class="col">
                <div class="card position-relative h-100">
                    <!-- Wrap the poster in a clickable link -->
                    <a href="moviereview.jsp?movieId=<%= rs.getInt("id") %>" class="text-decoration-none">
                        <img src="<%= rs.getString("poster_url") %>" alt="<%= rs.getString("title") %>" class="card-img-top rounded-top movie-poster">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title"><%= rs.getString("title") %></h5>
                        <p><strong>Genre:</strong> <%= rs.getString("genre") %></p>
                        <p><strong>Duration:</strong> <%= rs.getInt("duration") %> mins</p>
                        <p><%= rs.getString("synopsis") %></p>
                    </div>
                    <div class="card-footer bg-dark border-top-0">
                        <form method="POST" action="watchlist">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="movie_id" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="btn btn-primary btn-sm">Add to Watchlist</button>
                        </form>
                    </div>
                </div>
            </div>
            <%
                    }
                    if (!hasMovies) {
                        out.println("<p class='text-center text-warning'>No movies available to browse!</p>");
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
            <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="messageModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content bg-dark text-white">
                <div class="modal-header">
                    <h5 class="modal-title" id="messageModalLabel">Notification</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <%= message %>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="logo">LOGO</div>
            <p>EXPLORE YOUR MOVIES TASTE</p>
            <div class="divider"></div>
            <div class="d-flex flex-wrap justify-content-center mt-3">
                <a href="#" class="text-white text-decoration-none mx-2">Weebly Themes</a>
                <a href="#" class="text-white text-decoration-none mx-2">Pre-Sale FAQs</a>
                <a href="#" class="text-white text-decoration-none mx-2">Submit a Ticket</a>
                <a href="#" class="text-white text-decoration-none mx-2">Services</a>
                <a href="#" class="text-white text-decoration-none mx-2">Theme Tweak</a>
                <a href="#" class="text-white text-decoration-none mx-2">Showcase</a>
                <a href="#" class="text-white text-decoration-none mx-2">Widgetkit</a>
                <a href="#" class="text-white text-decoration-none mx-2">Support</a>
                <a href="#" class="text-white text-decoration-none mx-2">About Us</a>
                <a href="#" class="text-white text-decoration-none mx-2">Contact Us</a>
                <a href="#" class="text-white text-decoration-none mx-2">Affiliates</a>
                <a href="#" class="text-white text-decoration-none mx-2">Resources</a>
            </div>
            <p class="mt-3">© Copyright. All rights reserved.</p>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>

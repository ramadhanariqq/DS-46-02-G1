<%@ page import="java.sql.*" %>
<%
    // Retrieve user information from session
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    // Redirect to login page if user is not logged in or not a regular user
    if (userId == null || !"user".equals(role)) {
        response.sendRedirect("login.jsp");
        return; // Don't proceed further if not logged in
    }

    // Get the movieId from the request parameter (make sure it is passed as 'movieId')
    String movieIdStr = request.getParameter("movieId");
    if (movieIdStr == null || movieIdStr.isEmpty()) {
        out.println("<p>Movie ID is missing in the URL.</p>");
        return; // Stop further execution if movieId is missing
    }
    int movieId = Integer.parseInt(movieIdStr);  // Convert to integer
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Review</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #292929;
            padding: 15px 20px;
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
        body {
            background-color: #1c1c1e;
            color: #ffffff;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 20px;
        }
        .movie-poster {
            width: 100%;
            max-width: 300px;
            height: 450px;
            object-fit: cover;
            border-radius: 8px;
        }
        .movie-details {
            margin-left: 20px;
        }
        .review-section {
            margin-top: 30px;
        }
        .review-form textarea {
            resize: none;
        }
        .review-item {
            background-color: #292929;
            border-radius: 10px;
            margin-bottom: 10px;
            padding: 15px;
        }
        .review-item p {
            margin: 0;
        }
        .review-item .rating {
            font-weight: bold;
        }
        .btn-submit {
            background-color: #4CAF50;
            color: white;
        }
        .btn-submit:hover {
            background-color: #45a049;
        }
        .footer {
            background-color: #000; 
            color: #fff; 
            padding: 20px 0; 
            text-align: center;
            margin-top: 20px;
        }
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            align-items: center;
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
            font-size: 14px;
        }

        /* Updated Star Rating System */
        .star-rating {
            display: flex;
            justify-content: flex-start; /* Keep stars aligned to the left */
            direction: rtl;
            gap: 10px; /* Optional: Adds some space between the stars */
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            font-size: 30px;
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s;
        }
        .star-rating input:checked ~ label {
            color: #FFD700; /* Highlight stars in gold when selected */
        }
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #FFD700; /* Hover effect to highlight stars in gold */
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="logo-title">
            <div class="logo">LOGO</div>
            <div class="title">Your Watchlist</div>
        </div>
        <a href="logout.jsp" class="logout-btn">Logout</a>
    </header>

    <div class="container">
        <%
            // Database connection
            Connection conn = null;
            try {
                // Load JDBC driver and connect to database
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/movies_db", "root", "");

                // Fetch movie details using movieId
                PreparedStatement movieStmt = conn.prepareStatement("SELECT * FROM movies WHERE id = ?");
                movieStmt.setInt(1, movieId);
                ResultSet movieRs = movieStmt.executeQuery();
                
                if (movieRs.next()) {
                    String posterUrl = movieRs.getString("poster_url");
                    if (posterUrl == null || posterUrl.isEmpty()) {
                        posterUrl = "https://via.placeholder.com/300x450?text=No+Poster"; // Placeholder image URL
                    }
        %>
        <div class="row">
            <div class="col-md-4">
                <img src="<%= posterUrl %>" alt="Movie Poster" class="movie-poster">
            </div>
            <div class="col-md-8 movie-details">
                <h1><%= movieRs.getString("title") %></h1>
                <p><strong>Genre:</strong> <%= movieRs.getString("genre") %></p>
                <p><strong>Duration:</strong> <%= movieRs.getInt("duration") %> mins</p>
                <p><strong>Synopsis:</strong> <%= movieRs.getString("synopsis") %></p>
            </div>
        </div>

        <%
                } else {
                    out.println("<p>No movie found with this ID.</p>");
                }
                movieRs.close();

                // Handle review submission
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String review = request.getParameter("review");
                    int rating = Integer.parseInt(request.getParameter("rating"));
                    
                    // Insert review into the database
                    PreparedStatement reviewStmt = conn.prepareStatement(
                        "INSERT INTO reviews (movie_id, user_id, review, rating) VALUES (?, ?, ?, ?)");
                    reviewStmt.setInt(1, movieId);
                    reviewStmt.setInt(2, userId);
                    reviewStmt.setString(3, review);
                    reviewStmt.setInt(4, rating);
                    reviewStmt.executeUpdate();
                }

                // Fetch reviews for the movie
                PreparedStatement reviewStmt = conn.prepareStatement(
                    "SELECT u.username, r.review, r.rating, r.created_at FROM reviews r JOIN users u ON r.user_id = u.id WHERE r.movie_id = ? ORDER BY r.created_at DESC");
                reviewStmt.setInt(1, movieId);
                ResultSet reviewRs = reviewStmt.executeQuery();
        %>

        <!-- Review submission form -->
        <div class="review-section">
            <h2>Write a Review</h2>
            <form method="POST" class="review-form">
                <div class="form-group">
                    <textarea name="review" class="form-control mb-2" rows="4" placeholder="Write your review..." required></textarea>
                </div>
                <div class="form-group">
                    <div class="star-rating">
                        <input type="radio" id="star5" name="rating" value="5" required><label for="star5">&#9733;</label>
                        <input type="radio" id="star4" name="rating" value="4"><label for="star4">&#9733;</label>
                        <input type="radio" id="star3" name="rating" value="3"><label for="star3">&#9733;</label>
                        <input type="radio" id="star2" name="rating" value="2"><label for="star2">&#9733;</label>
                        <input type="radio" id="star1" name="rating" value="1"><label for="star1">&#9733;</label>
                    </div>
                </div>
                <button type="submit" class="btn btn-submit">Submit Review</button>
            </form>
        </div>

        <!-- Display submitted reviews -->
        <h2 class="mt-4">User Reviews</h2>
        <div class="review-list">
            <%
                while (reviewRs.next()) {
            %>
            <div class="review-item">
                <p><strong><%= reviewRs.getString("username") %>:</strong> <%= reviewRs.getString("review") %></p>
                <p class="rating">Rating: <%= reviewRs.getInt("rating") %>/5</p>
                <p><small>Reviewed on: <%= reviewRs.getTimestamp("created_at") %></small></p>
            </div>
            <%
                }
                reviewRs.close();
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
                <p>?Copyright. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>

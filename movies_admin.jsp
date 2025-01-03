<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");

    if (userId == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Movies Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #121212;
            color: #ffffff;
        }
        .container {
            background-color: #1e1e1e;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }
        .btn-primary {
            background-color: #f5c518;
            color: #121212;
        }
        .btn-primary:hover {
            background-color: #e3af0f;
        }
        .btn-danger:hover {
            background-color: #a71d2a;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        textarea,
        input[type="text"],
        input[type="number"] {
            background-color: #292929;
            color: #f5f5f5;
            border: none;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 10px;
            width: 100%;
        }
        .form-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center">Manage Movies Section</h1>

        <%
            Connection conn = null;
            ResultSet movieToEdit = null;
            int editMovieId = request.getParameter("edit_movie_id") != null
                ? Integer.parseInt(request.getParameter("edit_movie_id"))
                : -1;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/movies_db", "root", "");

                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String action = request.getParameter("action");
                    if ("add".equals(action)) {
                        String title = request.getParameter("title");
                        String genre = request.getParameter("genre");
                        int duration = Integer.parseInt(request.getParameter("duration"));
                        String posterUrl = request.getParameter("poster_url");
                        String synopsis = request.getParameter("synopsis");

                        PreparedStatement stmt = conn.prepareStatement(
                            "INSERT INTO movies (title, genre, duration, poster_url, synopsis) VALUES (?, ?, ?, ?, ?)");
                        stmt.setString(1, title);
                        stmt.setString(2, genre);
                        stmt.setInt(3, duration);
                        stmt.setString(4, posterUrl);
                        stmt.setString(5, synopsis);
                        stmt.executeUpdate();
                    } else if ("delete".equals(action)) {
                        int id = Integer.parseInt(request.getParameter("id"));
                        PreparedStatement stmt = conn.prepareStatement("DELETE FROM movies WHERE id = ?");
                        stmt.setInt(1, id);
                        stmt.executeUpdate();
                    } else if ("edit".equals(action)) {
                        int id = Integer.parseInt(request.getParameter("id"));
                        String title = request.getParameter("title");
                        String genre = request.getParameter("genre");
                        int duration = Integer.parseInt(request.getParameter("duration"));
                        String posterUrl = request.getParameter("poster_url");
                        String synopsis = request.getParameter("synopsis");

                        PreparedStatement stmt = conn.prepareStatement(
                            "UPDATE movies SET title = ?, genre = ?, duration = ?, poster_url = ?, synopsis = ? WHERE id = ?");
                        stmt.setString(1, title);
                        stmt.setString(2, genre);
                        stmt.setInt(3, duration);
                        stmt.setString(4, posterUrl);
                        stmt.setString(5, synopsis);
                        stmt.setInt(6, id);
                        stmt.executeUpdate();
                    }
                }

                if (editMovieId != -1) {
                    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM movies WHERE id = ?");
                    stmt.setInt(1, editMovieId);
                    movieToEdit = stmt.executeQuery();
                }
            } catch (Exception e) {
                out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (conn != null && editMovieId == -1) {
                    try {
                        conn.close();
                    } catch (SQLException ignore) {}
                }
            }
        %>

        <!-- Add/Edit Movie Form -->
        <form method="POST" action="movies_admin.jsp" class="mb-4">
            <% if (movieToEdit != null && movieToEdit.next()) { %>
                <input type="hidden" name="id" value="<%= movieToEdit.getInt("id") %>">
                <input type="text" name="title" placeholder="Enter Movie Title" value="<%= movieToEdit.getString("title") %>" required>
                <input type="text" name="genre" placeholder="Enter Genre (comma-separated)" value="<%= movieToEdit.getString("genre") %>" required>
                <input type="number" name="duration" placeholder="Duration (mins)" value="<%= movieToEdit.getInt("duration") %>" required>
                <input type="text" name="poster_url" placeholder="Enter Poster URL" value="<%= movieToEdit.getString("poster_url") %>" required>
                <textarea name="synopsis" placeholder="Enter Synopsis" rows="3" required><%= movieToEdit.getString("synopsis") %></textarea>
                <div class="form-buttons">
                    <button type="submit" name="action" value="edit" class="btn btn-warning">Save Changes</button>
                </div>
            <% } else { %>
                <input type="text" name="title" placeholder="Enter Movie Title" required>
                <input type="text" name="genre" placeholder="Enter Genre (comma-separated)" required>
                <input type="number" name="duration" placeholder="Duration (mins)" required>
                <input type="text" name="poster_url" placeholder="Enter Poster URL" required>
                <textarea name="synopsis" placeholder="Enter Synopsis" rows="3" required></textarea>
                <div class="form-buttons">
                    <button type="submit" name="action" value="add" class="btn btn-primary">Add Movie</button>
                </div>
            <% } %>
        </form>

        <!-- Movie List -->
        <div class="row">
            <%
                try {
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
                        <div class="d-flex justify-content-between">
                            <form method="POST" action="movies_admin.jsp" class="d-inline">
                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                            <a href="movies_admin.jsp?edit_movie_id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">Edit</a>
                        </div>
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

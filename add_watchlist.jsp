<%@ page import="java.sql.*" %>
<%@ page import= "java.net.URLEncoder"%>

<%
    int movieId = Integer.parseInt(request.getParameter("movie_id"));
    int userId = (Integer) session.getAttribute("userId");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/movies_db", "root", "");

        String checkQuery = "SELECT * FROM user_watch_history WHERE user_id = ? AND movie_id = ?";
        pstmt = conn.prepareStatement(checkQuery);
        pstmt.setInt(1, userId);
        pstmt.setInt(2, movieId);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            request.setAttribute("message", "This movie is already in your watchlist.");
        } else {
            String insertQuery = "INSERT INTO user_watch_history (user_id, movie_id, watched_at) VALUES (?, ?, NOW())";
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, movieId);
            pstmt.executeUpdate();
            request.setAttribute("message", "The movie has been added to your watchlist.");
        }
    } catch (Exception e) {
        request.setAttribute("message", "Error: " + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }

    
    response.sendRedirect("movies_user.jsp?message=" + URLEncoder.encode((String) request.getAttribute("message"), "UTF-8"));
%>

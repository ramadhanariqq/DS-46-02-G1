/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import classes.JDBC;
import classes.RecommendationEngine;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RecommendationServlet", urlPatterns = {"/RecommendationServlet"})
public class RecommendationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JDBC db = new JDBC();
        if (db.isConnected) {
            try {
                int userId = (Integer) request.getSession().getAttribute("userId");
                RecommendationEngine engine = new RecommendationEngine(db.conn);
                List<Map<String, String>> recommendations = engine.getRecommendations(userId);
                request.setAttribute("recommendations", recommendations);
                request.getRequestDispatcher("/recommend.jsp").forward(request, response);
            } catch (IOException | SQLException | ServletException e) {
                request.setAttribute("errorMessage", e.getMessage());
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            } finally {
                db.disconnect();
            }
        } else {
            request.setAttribute("errorMessage", db.message);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
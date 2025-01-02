<%-- 
    Document   : logout
    Created on : 31 Dec 2024, 5:06:07?am
    Author     : umaml
--%>

<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>

<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
</head>
<body>
<%
    String Email = request.getParameter("Email");
    String Password = request.getParameter("password");
    String message = "";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        if (Email != null && Password != null && !Email.isEmpty() && !Password.isEmpty()) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/we_care", "root", "Harsh@123");
            
            String query = "SELECT * FROM userprofiles WHERE Email = ? AND Password = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, Email);
            pstmt.setString(2, Password);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                String p1 = rs.getString(2);
                String p2 = rs.getString(3);
                String p3 = rs.getString(4);
                String p4 = rs.getString(5);
                String p5 = rs.getString(6);
                String p6 = rs.getString(7);
                
                session.setAttribute("userData", p1); // Example of setting session attribute
                response.sendRedirect("welcome.jsp"); // Redirect on successful login
            } else {
                message = "Invalid email or password";
            }
        } else {
            message = "Email and password are required";
        }
    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    } finally {
        // Close resources
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
<% if (!message.isEmpty()) { %>
    <p style="color:red;"><%= message %></p>
<% } %>
</body>
</html>
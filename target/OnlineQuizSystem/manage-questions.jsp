<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Check if user is logged in and is admin
    String userRole = (String) session.getAttribute("role");
    if (userRole == null || !userRole.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/quizdb";
    String dbUser = "root";
    String dbPassword = "root123";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        // Delete question if requested
        if (request.getParameter("delete") != null) {
            int questionId = Integer.parseInt(request.getParameter("delete"));
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUser, dbPassword);
            
            pstmt = conn.prepareStatement("DELETE FROM questions WHERE id = ?");
            pstmt.setInt(1, questionId);
            pstmt.executeUpdate();
            
            response.sendRedirect("manage-questions.jsp?success=Question deleted successfully");
            return;
        }
    } catch (Exception e) {
        request.setAttribute("error", "Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Management - Manage Questions</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="navbar">
        <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="add-question.jsp"><i class="fas fa-plus"></i> Add Question</a>
        <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
    
    <div class="container">
        <h2><i class="fas fa-question-circle"></i> Manage Quiz Questions</h2>
        
        <% if (request.getParameter("success") != null) { %>
            <p class="message success">
                <i class="fas fa-check-circle"></i> <%= request.getParameter("success") %>
            </p>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <p class="message error">
                <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
            </p>
        <% } %>
        
        <div class="questions-list">
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);
                    
                    pstmt = conn.prepareStatement("SELECT * FROM questions ORDER BY id DESC");
                    rs = pstmt.executeQuery();
                    
                    while (rs.next()) {
            %>
                    <div class="question-box">
                        <h3><%= rs.getString("question") %></h3>
                        <div class="options-list">
                            <p><strong>A:</strong> <%= rs.getString("option1") %></p>
                            <p><strong>B:</strong> <%= rs.getString("option2") %></p>
                            <p><strong>C:</strong> <%= rs.getString("option3") %></p>
                            <p><strong>D:</strong> <%= rs.getString("option4") %></p>
                            <p class="correct-answer">
                                <strong>Correct Answer:</strong> 
                                <%= rs.getString("correct_option").replace("option", "Option ") %>
                            </p>
                        </div>
                        <div class="question-actions">
                            <a href="edit-question.jsp?id=<%= rs.getInt("id") %>" class="action-button edit-button" title="Edit Question">
                                <i class="fas fa-edit"></i>
                            </a>
                            <button onclick="deleteQuestion(<%= rs.getInt("id") %>)" class="action-button delete-button" title="Delete Question">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </div>
                    </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p class='message error'><i class='fas fa-exclamation-circle'></i> Error: " + e.getMessage() + "</p>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) { }
                    try { if (pstmt != null) pstmt.close(); } catch (Exception e) { }
                    try { if (conn != null) conn.close(); } catch (Exception e) { }
                }
            %>
        </div>
    </div>
    
    <script>
    function deleteQuestion(id) {
        if (confirm('Are you sure you want to delete this question?')) {
            window.location.href = 'manage-questions.jsp?delete=' + id;
        }
    }
    </script>
</body>
</html>

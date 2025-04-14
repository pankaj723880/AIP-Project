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
    String url = "jdbc:mysql://localhost:3306/quiz_db";
    String dbUser = "root";
    String dbPassword = "";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    // Get question details
    String question = "";
    String option1 = "";
    String option2 = "";
    String option3 = "";
    String option4 = "";
    String correctOption = "";
    
    try {
        int questionId = Integer.parseInt(request.getParameter("id"));
        
        if (request.getMethod().equals("POST")) {
            // Update question
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUser, dbPassword);
            
            pstmt = conn.prepareStatement(
                "UPDATE questions SET question=?, option1=?, option2=?, option3=?, option4=?, correct_option=? WHERE id=?"
            );
            pstmt.setString(1, request.getParameter("question"));
            pstmt.setString(2, request.getParameter("option1"));
            pstmt.setString(3, request.getParameter("option2"));
            pstmt.setString(4, request.getParameter("option3"));
            pstmt.setString(5, request.getParameter("option4"));
            pstmt.setString(6, request.getParameter("correct_option"));
            pstmt.setInt(7, questionId);
            
            pstmt.executeUpdate();
            response.sendRedirect("manage-questions.jsp?success=Question updated successfully");
            return;
        } else {
            // Fetch question details
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUser, dbPassword);
            
            pstmt = conn.prepareStatement("SELECT * FROM questions WHERE id = ?");
            pstmt.setInt(1, questionId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                question = rs.getString("question");
                option1 = rs.getString("option1");
                option2 = rs.getString("option2");
                option3 = rs.getString("option3");
                option4 = rs.getString("option4");
                correctOption = rs.getString("correct_option");
            } else {
                response.sendRedirect("manage-questions.jsp?error=Question not found");
                return;
            }
        }
    } catch (Exception e) {
        request.setAttribute("error", "Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { }
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { }
        try { if (conn != null) conn.close(); } catch (Exception e) { }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Management - Edit Question</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="navbar">
        <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="manage-questions.jsp"><i class="fas fa-question-circle"></i> Manage Questions</a>
        <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
    
    <div class="container">
        <h2><i class="fas fa-edit"></i> Edit Question</h2>
        
        <form action="edit-question.jsp?id=<%= request.getParameter("id") %>" method="post" class="quiz-form">
            <div class="form-group">
                <label for="question">Question:</label>
                <textarea id="question" name="question" required placeholder="Enter your question here..."><%= question %></textarea>
            </div>
            
            <div class="options-grid">
                <div class="form-group">
                    <label for="option1">Option 1:</label>
                    <input type="text" id="option1" name="option1" required placeholder="Enter option 1" value="<%= option1 %>">
                </div>
                
                <div class="form-group">
                    <label for="option2">Option 2:</label>
                    <input type="text" id="option2" name="option2" required placeholder="Enter option 2" value="<%= option2 %>">
                </div>
                
                <div class="form-group">
                    <label for="option3">Option 3:</label>
                    <input type="text" id="option3" name="option3" required placeholder="Enter option 3" value="<%= option3 %>">
                </div>
                
                <div class="form-group">
                    <label for="option4">Option 4:</label>
                    <input type="text" id="option4" name="option4" required placeholder="Enter option 4" value="<%= option4 %>">
                </div>
            </div>
            
            <div class="form-group">
                <label for="correct_option">Correct Answer:</label>
                <select id="correct_option" name="correct_option" required>
                    <option value="">Select correct answer</option>
                    <option value="option1" <%= correctOption.equals("option1") ? "selected" : "" %>>Option 1</option>
                    <option value="option2" <%= correctOption.equals("option2") ? "selected" : "" %>>Option 2</option>
                    <option value="option3" <%= correctOption.equals("option3") ? "selected" : "" %>>Option 3</option>
                    <option value="option4" <%= correctOption.equals("option4") ? "selected" : "" %>>Option 4</option>
                </select>
            </div>
            
            <div class="button-group">
                <button type="submit" class="primary-button">
                    <i class="fas fa-save"></i> Update Question
                </button>
                <a href="manage-questions.jsp" class="secondary-button">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
        
        <% if (request.getAttribute("error") != null) { %>
            <p class="message error">
                <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
            </p>
        <% } %>
    </div>
</body>
</html>

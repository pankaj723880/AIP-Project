<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    // Check if user is logged in
    String userName = (String) session.getAttribute("name");
    String userRole = (String) session.getAttribute("role");
    
    if (userName == null || userRole == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz System - Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="navbar">
        <a href="dashboard.jsp" class="active"><i class="fas fa-home"></i> Dashboard</a>
        <% if (userRole.equals("admin")) { %>
            <a href="manage-questions.jsp"><i class="fas fa-question-circle"></i> Manage Questions</a>
            <a href="add-question.jsp"><i class="fas fa-plus"></i> Add Question</a>
        <% } %>
        <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <div class="container">
        <h2><i class="fas fa-user"></i> Welcome, <%= userName %>!</h2>
        
        <div class="dashboard-grid">
            <% if (userRole.equals("admin")) { %>
                <a href="manage-questions.jsp" class="dashboard-card">
                    <i class="fas fa-question-circle"></i>
                    <h3>Manage Questions</h3>
                    <p>Add, edit, or remove quiz questions</p>
                </a>
                
                <a href="add-question.jsp" class="dashboard-card">
                    <i class="fas fa-plus-circle"></i>
                    <h3>Add New Question</h3>
                    <p>Create a new quiz question</p>
                </a>
            <% } %>
            
            <a href="quiz" class="dashboard-card">
                <i class="fas fa-play-circle"></i>
                <h3>Take Quiz</h3>
                <p>Start a new quiz session</p>
            </a>
            
            <a href="result.jsp" class="dashboard-card">
                <i class="fas fa-chart-bar"></i>
                <h3>View Results</h3>
                <p>Check your quiz performance</p>
            </a>
        </div>
    </div>
</body>
</html>

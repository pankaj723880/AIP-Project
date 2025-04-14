<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    // Check if user is logged in and is admin
    String userRole = (String) session.getAttribute("role");
    if (userRole == null || !userRole.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Management - Add Question</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="admin-background">
    <nav class="top-nav">
        <div class="nav-links">
            <a href="dashboard.jsp" class="nav-link"><i class="fas fa-home"></i> Dashboard</a>
            <a href="manage-questions.jsp" class="nav-link active"><i class="fas fa-question-circle"></i> Manage Questions</a>
            <a href="logout.jsp" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>
    <div class="container">
        <div class="content-card">
            <h2 class="card-title"><i class="fas fa-plus-circle"></i> Add New Question</h2>
            <form action="add-question" method="post" class="quiz-form">
            <div class="form-group">
                <label for="question" class="form-label">Question:</label>
                <textarea id="question" name="question" required class="form-input" placeholder="Enter your question here..."></textarea>
            </div>
            
            <div class="options-grid">
                <div class="form-group">
                    <label for="option1" class="form-label">Option 1:</label>
                    <input type="text" id="option1" name="option1" required class="form-input" placeholder="Enter option 1">
                </div>
                
                <div class="form-group">
                    <label for="option2" class="form-label">Option 2:</label>
                    <input type="text" id="option2" name="option2" required class="form-input" placeholder="Enter option 2">
                </div>
                
                <div class="form-group">
                    <label for="option3" class="form-label">Option 3:</label>
                    <input type="text" id="option3" name="option3" required class="form-input" placeholder="Enter option 3">
                </div>
                
                <div class="form-group">
                    <label for="option4" class="form-label">Option 4:</label>
                    <input type="text" id="option4" name="option4" required class="form-input" placeholder="Enter option 4">
                </div>
            </div>
            
            <div class="form-group">
                <label for="correct_option" class="form-label">Correct Answer:</label>
                <select id="correct_option" name="correct_option" required class="form-input select-input">
                    <option value="">Select correct answer</option>
                    <option value="option1">Option 1</option>
                    <option value="option2">Option 2</option>
                    <option value="option3">Option 3</option>
                    <option value="option4">Option 4</option>
                </select>
            </div>
            
            <div class="button-group">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Save Question
                </button>
                <a href="manage-questions.jsp" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
            </form>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <p class="message error">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </p>
        <% } else if (request.getAttribute("success") != null) { %>
            <p class="message success">
                <i class="fas fa-check-circle"></i> ${success}
            </p>
        <% } %>
    </div>
</body>
</html>

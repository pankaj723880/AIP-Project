<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quizapp.model.Question" %>
<%
    List<Question> questions = (List<Question>) request.getAttribute("questions");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="navbar">
        <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="#" class="active"><i class="fas fa-question-circle"></i> Quiz</a>
        <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <div class="container quiz-container">
        <h1>Quiz</h1>
        <div class="quiz-progress">
            <div class="progress-bar">
                <div class="progress" id="quiz-progress" style="width: 0%"></div>
            </div>
            <span id="question-counter">Question 1 of <%= questions.size() %></span>
        </div>

        <form action="submit-quiz" method="post" id="quiz-form">
            <%
                int index = 1;
                for (Question q : questions) {
            %>
                <div class="question-card" id="question-<%= index %>" style="display: <%= index == 1 ? "block" : "none" %>">
                    <h3 class="question-text"><%= index + ". " + q.getQuestion() %></h3>
                    <div class="options-grid">
                        <label class="option-card" for="q<%= index %>_1">
                            <input type="radio" id="q<%= index %>_1" name="q<%= index %>" value="option1" required>
                            <div class="option-text"><%= q.getOption1() %></div>
                        </label>
                        <label class="option-card" for="q<%= index %>_2">
                            <input type="radio" id="q<%= index %>_2" name="q<%= index %>" value="option2" required>
                            <div class="option-text"><%= q.getOption2() %></div>
                        </label>
                        <label class="option-card" for="q<%= index %>_3">
                            <input type="radio" id="q<%= index %>_3" name="q<%= index %>" value="option3" required>
                            <div class="option-text"><%= q.getOption3() %></div>
                        </label>
                        <label class="option-card" for="q<%= index %>_4">
                            <input type="radio" id="q<%= index %>_4" name="q<%= index %>" value="option4" required>
                            <div class="option-text"><%= q.getOption4() %></div>
                        </label>
                    </div>
                    <input type="hidden" name="correct<%= index %>" value="<%= q.getCorrectOption() %>">
                    
                    <div class="navigation-buttons">
                        <% if (index > 1) { %>
                            <button type="button" class="nav-button" onclick="showQuestion(<%= index - 1 %>)">
                                <i class="fas fa-arrow-left"></i> Previous
                            </button>
                        <% } %>
                        <% if (index < questions.size()) { %>
                            <button type="button" class="nav-button primary" onclick="showQuestion(<%= index + 1 %>)">
                                Next <i class="fas fa-arrow-right"></i>
                            </button>
                        <% } else { %>
                            <button type="submit" class="submit-button">
                                Submit Quiz <i class="fas fa-check-circle"></i>
                            </button>
                        <% } %>
                    </div>
                </div>
            <%
                    index++;
                }
            %>
            <input type="hidden" name="total" value="<%= questions.size() %>">
        </form>
    </div>

    <script>
    function showQuestion(index) {
        // Hide all questions
        document.querySelectorAll('.question-card').forEach(card => card.style.display = 'none');
        
        // Show the selected question
        document.getElementById('question-' + index).style.display = 'block';
        
        // Update progress
        const total = <%= questions.size() %>;
        const progress = (index / total) * 100;
        document.getElementById('quiz-progress').style.width = progress + '%';
        document.getElementById('question-counter').textContent = 'Question ' + index + ' of ' + total;
    }
    </script>
</body>
</html>

package com.quizapp.servlet;

import com.quizapp.dao.QuestionDAO;
import com.quizapp.model.Question;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/add-question")
public class AddQuestionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Question q = new Question();
        q.setQuestion(request.getParameter("question"));
        q.setOption1(request.getParameter("option1"));
        q.setOption2(request.getParameter("option2"));
        q.setOption3(request.getParameter("option3"));
        q.setOption4(request.getParameter("option4"));
        q.setCorrectOption(request.getParameter("correct_option"));

        QuestionDAO dao = new QuestionDAO();
        boolean result = dao.addQuestion(q);

        if (result) {
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Failed to add question");
            request.getRequestDispatcher("add-question.jsp").forward(request, response);
        }
    }
}

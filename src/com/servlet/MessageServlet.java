package com.servlet;

import com.dao.impl.MessageDaoImpl;
import com.entity.Message;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

//@WebServlet("/MessageServlet")
public class MessageServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action.equals("getMessageList")) getMessageList(request, response);
        if(action.equals("addMessage")) addMessage(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    //新增评论
    private void addMessage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer uid = (Integer) session.getAttribute("uid");
        if (uid == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        Integer bid = (Integer) session.getAttribute("bidForMessage");
        String message = request.getParameter("message");
        int n = 0;
        MessageDaoImpl messageDao = new MessageDaoImpl();
        try {
            n = messageDao.addMessage(uid, bid, message);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
            return;
        }
        if (n == 1) {
            request.getRequestDispatcher("/MessageServlet?action=getMessageList").forward(request, response);
        } else {
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
        }
    }

    //获取评论列表
    private void getMessageList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer bid = (Integer) session.getAttribute("bidForMessage");
        MessageDaoImpl messageDao = new MessageDaoImpl();
        List<Message> messageList = messageDao.getMessageList(bid);
        request.setAttribute("messages", messageList);
        request.getRequestDispatcher("/messageList.jsp").forward(request, response);
    }


}

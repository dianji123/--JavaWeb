package com.servlet;

import com.dao.SaleDao;
import com.dao.UserDao;
import com.dao.impl.SaleDaoImpl;
import com.dao.impl.UserDaoImpl;
import com.entity.Sale;
import com.entity.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

//@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action.equals("login")) login(request, response);
        if(action.equals("logout")) logout(request, response);
        if(action.equals("usercreate")) usercreate(request, response);
        if(action.equals("manage")) manage(request, response);
        if(action.equals("deleteduser")) deletedUser(request, response);
        if(action.equals("delete")) delete(request, response);
        if(action.equals("user")) user(request, response);
        if(action.equals("change")) change(request, response);

        //避免重复弹窗
        if ("clearSuccess".equals(action)) {
            HttpSession session = request.getSession();
            session.removeAttribute("updateSuccess");
            session.removeAttribute("deleteSuccess");
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    //登录验证
    protected void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uname = request.getParameter("uname");
        String upassword = request.getParameter("upassword");
        User user = new User (uname, upassword);
        String username = user.getUname();
        String password = user.getUpassword();
        UserDao userDao = new UserDaoImpl();
        int uid = 0;
        try {
            uid = userDao.valiLogin(username, password);
            HttpSession session = request.getSession();
            session.setAttribute("uid", uid);
            session.setAttribute("username", uname);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
            return;
        }
        if(uid == 0){
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
        } else{
            request.getRequestDispatcher("/BookServlet?action=list").forward(request, response);
        }

    }

    protected void user(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        // 从会话中获取 uid
        Integer uid = (Integer) session.getAttribute("uid");
        if (uid == null) {
            // 如果 uid 不存在，重定向到登录页面或错误页面
            response.sendRedirect("login.jsp"); // 或者其他错误页面
            return;
        }
        UserDaoImpl userDao = new UserDaoImpl();
        SaleDaoImpl saleDao = new SaleDaoImpl();
        List<User> userinfo = userDao.getUser(uid);
        List<Sale> usersale = saleDao.getSalelist(uid);
        session.setAttribute("userinfo", userinfo);
        session.setAttribute("usersale", usersale);
        response.sendRedirect("user.jsp");
    }

    //修改用户信息
    protected void change(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer uid = (Integer) session.getAttribute("uid");
        if (uid == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String uname = request.getParameter("uname");
        String upassword = request.getParameter("upassword");
        int uage = Integer.parseInt(request.getParameter("uage"));
        String uphone = request.getParameter("uphone");
        UserDao userDao = new UserDaoImpl();
        int n = 0;
        try {
            n = userDao.userChange(uid, uname, upassword, uage, uphone);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
            return;
        }
        if(n == 1){
            UserDao userDao1 = new UserDaoImpl();
            SaleDaoImpl saleDao = new SaleDaoImpl();
            List<User> userinfo = userDao1.getUser(uid);
            List<Sale> usersale = saleDao.getSalelist(uid);
            session.setAttribute("uid", uid);
            session.setAttribute("userinfo", userinfo);
            session.setAttribute("usersale", usersale);
            session.setAttribute("updateSuccess", true);
            response.sendRedirect("user.jsp");
        }else{
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
        }

    }


    //退出登录
    protected void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 清除会话中的用户信息
        HttpSession session = request.getSession();
        session.invalidate(); // 完全终止会话

        // 保留会话但只是移除特定的用户属性
        // session.removeAttribute("uid");

        // 重定向到登录页面或主页
        response.sendRedirect("login.jsp");
    }

    //注册用户
    protected void usercreate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uname = request.getParameter("uname");
        String upassword = request.getParameter("upassword");
        int uage = Integer.parseInt(request.getParameter("uage"));
        String uphone = request.getParameter("uphone");
        UserDao userDao = new UserDaoImpl();
        int n = 0;
        try {
            n = userDao.userCreate(uname, upassword, uage, uphone);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
            return;
        }
        if(n == 1){
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else{
            request.getRequestDispatcher("/BookServlet?action=list").forward(request, response);
        }

    }

    //管理已注销用户
    protected void manage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDaoImpl userDao = new UserDaoImpl();
        List<User> userList = userDao.getDeletedUser();
        HttpSession session = request.getSession();
        session.setAttribute("deletedUserList", userList);
        response.sendRedirect("userManage.jsp");
    }

    //删除已注销用户
    protected void deletedUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int deleteUid = Integer.parseInt(request.getParameter("deleteuid"));
        UserDao userDao = new UserDaoImpl();
        int n = 0;
        try {
            n = userDao.deletedUser(deleteUid);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
            return;
        }

        if (n == 1) {
            HttpSession session = request.getSession();
            session.setAttribute("deleteSuccess", true);
            request.getRequestDispatcher("/UserServlet?action=manage").forward(request, response);
        } else {
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
        }

    }

    //注销用户
    protected void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int uid = Integer.parseInt(request.getParameter("uid"));
        UserDao userDao = new UserDaoImpl();
        int n = 0;
        try {
            n = userDao.userDelete(uid);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
            return;
        }
        if(n == 1){
            request.getRequestDispatcher("/UserServlet?action=manage").forward(request, response);
        }else{
            request.getRequestDispatcher("/BookServlet? action=list").forward(request, response);
        }

    }


}

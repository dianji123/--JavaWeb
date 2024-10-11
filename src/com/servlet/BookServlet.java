package com.servlet;

import com.dao.BookDao;
import com.dao.MessageDao;
import com.dao.impl.BookDaoImpl;
import com.dao.impl.MessageDaoImpl;
import com.entity.Book;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

//@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action.equals("list")) list(request, response);
        if(action.equals("changeList")) changeList(request, response);
        if(action.equals("add")) add(request, response);
        if(action.equals("change")) oneBook(request, response);
        if(action.equals("changeBook")) changeBook(request, response);
        if(action.equals("delete")) delete(request, response);
        if(action.equals("searchByType")) searchByType(request, response);

        //避免重复弹窗
        if ("clearSuccess".equals(action)) {
            HttpSession session = request.getSession();
            session.removeAttribute("addSuccess");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    //所有书籍展示
    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookDaoImpl bookDao = new BookDaoImpl();
        List<Book> books = bookDao.listAll();
        request.setAttribute("books", books);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
        //考虑存到SessionStorage
        //response.sendRedirect("index.jsp");
    }

    //指定查询一本书
    private void oneBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bid = Integer.parseInt(request.getParameter("bid"));
        BookDaoImpl bookDao = new BookDaoImpl();
        Book book = bookDao.oneBook(bid);
        request.setAttribute("oneBook", book);
        request.getRequestDispatcher("/changeBook.jsp").forward(request, response);
    }

    //修改书籍展示
    private void changeList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookDaoImpl bookDao = new BookDaoImpl();
        List<Book> books = bookDao.listAll();
        request.setAttribute("books", books);
        request.getRequestDispatcher("/manageBook.jsp").forward(request, response);
    }

    //添加图书
    protected void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bname =  request.getParameter("bname");
        float bprice = Float.parseFloat(request.getParameter("bprice"));
        String btype =  request.getParameter("btype");
        int bstock = Integer.parseInt(request.getParameter("bstock"));
        String bdesc =  request.getParameter("bdesc");
        Book book = new Book(bname, bprice, btype, bstock,bdesc);
        book.setBname(bname);
        book.setBprice(bprice);
        book.setBtype(btype);
        book.setBstock(bstock);
        book.setBdesc(bdesc);
        BookDao bookDao = new BookDaoImpl();
        int n = 0;
        try {
            n = bookDao.addBook(book);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
            return;
        }
        if(n == 1){
            HttpSession session = request.getSession();
            session.setAttribute("addSuccess", true);
            response.sendRedirect("addBook.jsp");
        } else{
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
        }

    }

    //修改图书
    protected void changeBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bid = Integer.parseInt(request.getParameter("bid"));
        float bprice = Float.parseFloat(request.getParameter("bprice"));
        int bstock = Integer.parseInt(request.getParameter("bstock"));
        BookDao bookDao = new BookDaoImpl();
        int n = 0;
        try {
            n = bookDao.changeBook(bid, bprice, bstock);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
            return;
        }
        if(n == 1){
            request.getRequestDispatcher("/BookServlet?action=changeList").forward(request, response);
        } else{
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
        }

    }

    //删除图书
    private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bid = Integer.parseInt(request.getParameter("bid"));
        BookDao bookDao = new BookDaoImpl();
        int n = 0;
        try {
            n = bookDao.deleteBook(bid);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
            return;
        }
        if(n == 1){
            request.getRequestDispatcher("/BookServlet?action=changeList").forward(request, response);
        } else{
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
        }
    }

    //查询特定类型图书
    protected void searchByType(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String btype = request.getParameter("btype");
        BookDaoImpl bookDao = new BookDaoImpl();
        List<Book> bookList = bookDao.getTypeList(btype);
        request.setAttribute("booktype", bookList);
        request.getRequestDispatcher("/searchBook.jsp").forward(request, response);
    }

}

package com.servlet;

import com.dao.impl.SaleDaoImpl;
import com.entity.Book;
import com.entity.Sale;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

//@WebServlet("/SaleServlet")
public class SaleServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action.equals("bookSale")) bookSale(request, response);
        if(action.equals("buyBook")) buyBook(request, response);
        if(action.equals("saleList")) allSaleList(request, response);
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }


    private void bookSale(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer uid = (Integer) session.getAttribute("uid");
        if (uid == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int bid = Integer.parseInt(request.getParameter("bid"));
        int scount = Integer.parseInt(request.getParameter("scount"));
        int n = 0;
        SaleDaoImpl saleDao = new SaleDaoImpl();
        try {
            n = saleDao.saleBook(bid, uid, scount);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
            return;
        }
        if (n == 1) {
            request.getRequestDispatcher("/BookServlet?action=list").forward(request, response);
        } else {
            request.getRequestDispatcher("/failure.jsp").forward(request, response);
        }

    }

    //展示购买书籍信息
    private void buyBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取购买按钮的索引
        String buttonIndexStr = request.getParameter("buyButton");
        int buttonIndex = Integer.parseInt(buttonIndexStr);

        // 获取书籍信息
        int bid = Integer.parseInt(request.getParameter("bid[" + buttonIndex + "]"));
        String bname = request.getParameter("bname[" + buttonIndex + "]");
        float bprice = Float.parseFloat(request.getParameter("bprice[" + buttonIndex + "]"));
        String btype = request.getParameter("btype[" + buttonIndex + "]");
        int bstock = Integer.parseInt(request.getParameter("bstock[" + buttonIndex + "]"));
        int bsale = Integer.parseInt(request.getParameter("bsale[" + buttonIndex + "]"));
        String bdesc = request.getParameter("bdesc[" + buttonIndex + "]");

        // 创建书籍对象并处理购买逻辑
        Book book = new Book(bid, bname, bprice, btype, bstock, bsale, bdesc);
        request.setAttribute("buyBook", book);
        HttpSession session = request.getSession();
        session.setAttribute("bidForMessage", bid);
        request.getRequestDispatcher("/saleBook.jsp").forward(request, response);
    }

    //获取所有售卖记录
    protected void allSaleList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SaleDaoImpl saleDao = new SaleDaoImpl();
        List<Sale> saleList = saleDao.getAllSalelist();
        request.setAttribute("saleList", saleList);
        request.getRequestDispatcher("/saleManage.jsp").forward(request, response);
    }

}

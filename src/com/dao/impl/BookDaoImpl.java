package com.dao.impl;

import com.dao.BookDao;
import com.entity.Book;
import com.util.BasicJDBC;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDaoImpl implements BookDao {

    private BasicJDBC db = null;
    private Connection connection = null;

    public BookDaoImpl() {
        db = new BasicJDBC();
        connection = db.getCon();
    }

    //添加图书
    @Override
    public int addBook(Book b) {
        PreparedStatement ps = null;
        String sql = "insert into book(Bname,Bprice,Btype,Bstock,Bsale,Bdesc)" +
                "values(?,?,?,?,?,?)";
        int n = 0;
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, b.getBname());
            ps.setDouble(2, b.getBprice());
            ps.setString(3, b.getBtype());
            ps.setInt(4, b.getBstock());
            ps.setInt(5, b.getBsale());
            ps.setString(6, b.getBdesc());
            n = ps.executeUpdate();
            System.out.println(n+"添加图书成功");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return n;
    }

    //修改图书信息
    @Override
    public int changeBook(int bid, float bprice, int bstock) {
        PreparedStatement ps = null;
        String sql = "update book set Bprice=?,Bstock=? where Bid=?";
        int n = 0;
        try {
            ps = connection.prepareStatement(sql);
            ps.setFloat(1, bprice);
            ps.setInt(2, bstock);
            ps.setInt(3, bid);
            n = ps.executeUpdate();
            System.out.println(n+"修改图书信息成功");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return n;
    }
    //删除图书
    @Override
    public int deleteBook(int bid) {
        PreparedStatement ps = null;
        String sql = "delete from book where bid=?";
        int n = 0;
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, bid);
            n = ps.executeUpdate();
            System.out.println(n+"删除图书成功");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return n;
    }

    //根据图书类型查询图书
    @Override
    public List<Book> getTypeList(String btype) {
        PreparedStatement ps = null;
        String sql = "select * from book where Btype=?";
        ResultSet rs = null;
        List<Book> typelList = new ArrayList<>();
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, btype);
            rs = ps.executeQuery();
            while (rs.next()){
                Book book = new Book(rs.getInt(1), rs.getString(2), rs.getFloat(3),
                        rs.getString(4), rs.getInt(5), rs.getInt(6), rs.getString(7));
                typelList.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return typelList;
    }

    //查询所有
    @Override
    public List<Book> listAll(){
        PreparedStatement ps = null;
        String sql = "select * from book";
        ResultSet rs = null;
        List<Book> bookList = new ArrayList<>();
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()){
                Book book = new Book();
                book.setBid(rs.getInt(1));
                book.setBname(rs.getString(2));
                book.setBprice(rs.getFloat(3));
                book.setBtype(rs.getString(4));
                book.setBstock(rs.getInt(5));
                book.setBsale(rs.getInt(6));
                book.setBdesc(rs.getString(7));
                bookList.add(book);
            }
        } catch (SQLException e){
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return bookList;
    }

    //查询某一本书
    @Override
    public Book oneBook(int bid) {
        PreparedStatement ps = null;
        String sql = "select * from book where bid=?";
        ResultSet rs = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, bid);
            rs = ps.executeQuery();
            if (rs.next()) { // 检查是否有数据返回
                return new Book(rs.getInt(1), rs.getString(2), rs.getFloat(3),
                        rs.getString(4), rs.getInt(5), rs.getInt(6), rs.getString(7));
            }
        } catch (SQLException e){
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return null;
    }
}

package com.dao.impl;

import com.dao.SaleDao;
import com.entity.Book;
import com.entity.Sale;
import com.util.BasicJDBC;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SaleDaoImpl implements SaleDao {

    private BasicJDBC db = null;
    private Connection connection = null;

    public SaleDaoImpl() {
        db = new BasicJDBC();
        connection = db.getCon();
    }

    //图书销售
    @Override
    public int saleBook(int uid, int bid, int saleCount) {
        /**
         * sale表进行插入操作时，book表对应的书的Bstock,Bsale也要同步更新
         * 这里使用在数据库创建的存储过程SaleBook
         */
        PreparedStatement ps = null;
        String sql = "call SaleBook(?,?,?)";
        int n = 0;
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, uid);
            ps.setInt(2, bid);
            ps.setInt(3, saleCount);
            n = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }

        return n;
    }

    //获取所有售卖记录
    @Override
    public List<Sale> getAllSalelist() {
        PreparedStatement ps = null;
        String sql = "SELECT Uname, Bname, Scount, Bprice FROM sale " +
                "JOIN user ON user.Uid = sale.Uid " +
                "JOIN book ON book.Bid = sale.Bid ";
        ResultSet rs = null;
        List<Sale> saleList = new ArrayList<>();
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Sale sale = new Sale();
                sale.setUname(rs.getString("Uname"));
                sale.setBname(rs.getString("Bname"));
                sale.setScount(rs.getInt("Scount"));
                sale.setBprice(rs.getFloat("Bprice"));
                saleList.add(sale);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return saleList;
    }

    //获取用户的所有售卖记录
    @Override
    public List<Sale> getSalelist(int uid) {
        PreparedStatement ps = null;
        String sql = "SELECT Uname, Bname, Scount, Bprice FROM sale " +
                "JOIN user ON user.Uid = sale.Uid " +
                "JOIN book ON book.Bid = sale.Bid " +
                "WHERE user.Uid =";
        if (uid == 0) {
            sql = sql + "user.Uid";
        } else {
            sql = sql + uid;
        }
        ResultSet rs = null;
        List<Sale> saleList = new ArrayList<>();
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Sale sale = new Sale(rs.getString(1), rs.getString(2), rs.getInt(3),
                        rs.getFloat(4));
                saleList.add(sale);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }

        return saleList;
    }

    //
    @Override
    public List<Book> getBookSale(int bid) {
        return null;
    }




}

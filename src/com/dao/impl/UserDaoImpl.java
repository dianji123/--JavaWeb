package com.dao.impl;

import com.dao.UserDao;
import com.entity.User;
import com.util.BasicJDBC;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {

    private BasicJDBC db = null;
    private Connection connection = null;
    public UserDaoImpl(){
        db = new BasicJDBC();
        connection = db.getCon();
    }

    //登录验证
    @Override
    public int valiLogin(String name, String password) throws Exception {
        int uid = 0;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "select * from user where Uname=? and Upassword=? and Udesc=0";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()){
                uid = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return uid;
    }

    //注册用户
    @Override
    public int userCreate(String uname, String upassword, int uage, String uphone) {
        PreparedStatement ps = null;
        String sql = "insert into user(Uname,Upassword,Uage,Uphone,Udesc) values(?,?,?,?,0)";
        int n = 0;
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, uname);
            ps.setString(2, upassword);
            ps.setInt(3, uage);
            ps.setString(4, uphone);
            n = ps.executeUpdate();
            System.out.println(n+"注册成功");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return n;
    }

    //删除用户
    @Override
    public int userDelete(int uid) {
        PreparedStatement ps = null;
        String sql = "UPDATE user SET Udesc=1 WHERE Uid=?";
        int n = 0;
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, uid);
            n = ps.executeUpdate();
            System.out.println(n+"删除成功");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return n;
    }

    //查询已注销用户
    @Override
    public List<User> getDeletedUser() {
        PreparedStatement ps = null;
        String sql = "select * from user where Udesc=1";
        ResultSet rs = null;
        List<User> userList = new ArrayList<>();
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getInt(4), rs.getString(5));
                userList.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return userList;
    }

    //删除已注销用户
    @Override
    public int deletedUser(int uid) {
        PreparedStatement ps = null;
        String sql = "delete from user where Uid=?";
        int n = 0;
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, uid);
            n = ps.executeUpdate();
            System.out.println(n+"删除成功");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return n;
    }

    //修改用户信息
    @Override
    public int userChange(int uid, String uname, String upassword, int uage, String uphone) {
        PreparedStatement ps = null;
        String sql = "update user set Uname=?,Upassword=?,Uage=?,Uphone=? where Uid=?";
        int n = 0;
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, uname);
            ps.setString(2, upassword);
            ps.setInt(3, uage);
            ps.setString(4, uphone);
            ps.setInt(5, uid);
            n = ps.executeUpdate();
            System.out.println(n+"修改成功");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return n;
    }

    //查询
    @Override
    public List<User> getUser(int uid) {
        PreparedStatement ps = null;
        String sql = "select * from user where Udesc=0 and Uid=";
        if (uid == 0){
            sql = sql + "Uid";
        } else {
            sql = sql + uid;
        }
        ResultSet rs = null;
        List<User> userList = new ArrayList<>();
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getInt(4), rs.getString(5));
                userList.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return userList;
    }
}

package com.util;

import java.sql.*;

public class BasicJDBC {

        private Connection connection = null;

        public BasicJDBC(){
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
//                System.out.println("database driver success to load");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                System.out.println("database driver failed to load");
            }
        }

        public Connection getCon(){
            try {
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3308/bookstore?" +
                        "useUnicode=true&allowPublicKeyRetrieval=true&characterEncoding=utf-8&useSSL=false&serverTimezone=GMT"
                , "root", "123456");
//                System.out.println("database link success");
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("database link fail");
            }
            return connection;
        }

        public void closeAll(Connection connection, PreparedStatement ps, ResultSet rs){
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
}

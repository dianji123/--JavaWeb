package com.dao.impl;

import com.dao.MessageDao;
import com.entity.Message;
import com.util.BasicJDBC;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MessageDaoImpl implements MessageDao {

    private BasicJDBC db = null;
    private Connection connection = null;

    public MessageDaoImpl() {
        db = new BasicJDBC();
        connection = db.getCon();
    }

    //获取评论列表
    @Override
    public List<Message> getMessageList(int bid) {
        PreparedStatement ps = null;
        String sql = "select Uname,Message from message join user on user.Uid=message.uid where Bid=?";
        ResultSet rs = null;
        List<Message> messageList = new ArrayList<>();
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, bid);
            rs = ps.executeQuery();
            while (rs.next()){
                Message message = new Message(rs.getString(1), rs.getString(2));
                messageList.add(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return messageList;
    }

    //添加评论
    @Override
    public int addMessage(int uid, int bid, String message) {
        PreparedStatement ps = null;
        String sql = "insert into message(Uid,Bid,Message) values(?,?,?)";
        int n = 0;
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1,uid);
            ps.setInt(2,bid);
            ps.setString(3, message);
            n = ps.executeUpdate();
            System.out.println(n+"添加评论成功");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll(connection, ps, null);
        }
        return n;
    }
}

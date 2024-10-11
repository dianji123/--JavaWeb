package com.dao;

import com.entity.Message;

import java.util.List;

public interface MessageDao {

    public List<Message> getMessageList(int bid);
    public int addMessage(int Uid, int Bid, String Message);

}

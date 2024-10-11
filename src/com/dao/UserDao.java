package com.dao;

import com.entity.User;

import java.util.List;

public interface UserDao {

    public int valiLogin(String username, String password)throws Exception;
    public int userCreate(String uname,String upassword,int uage,String uphone);
    public int userDelete(int uid);
    public int userChange(int uid,String uname,String upassword,int uage,String uphone);
    public List<User> getUser(int uid);
    public List<User> getDeletedUser();
    public int deletedUser(int uid);

}

package com.entity;

public class User {

    private int uid;
    private String uname;
    private String upassword;
    private int uage;
    private String uphone;


    public User(){

    }


    public User(String username, String password){
        this.uname = username;
        this.upassword = password;
    }

    public User(int uid, String username, String password, int age, String phone){
        this.uid = uid;
        this.uname = username;
        this.upassword = password;
        this.uage = age;
        this.uphone = phone;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getUpassword() {
        return upassword;
    }

    public void setUpassword(String upassword) {
        this.upassword = upassword;
    }

    public int getUage() {
        return uage;
    }

    public void setUage(int uage) {
        this.uage = uage;
    }

    public String getUphone() {
        return uphone;
    }

    public void setUphone(String uphone) {
        this.uphone = uphone;
    }
}

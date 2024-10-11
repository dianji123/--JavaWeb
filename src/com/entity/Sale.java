package com.entity;

public class Sale {

    private int sid;
    private int bid;
    private int uid;
    private int scount;

    private String uname;
    private String bname;
    private float bprice;

    public Sale(){

    }

    public Sale(String uname, String bname, int scount, float bprice){
        this.uname = uname;
        this.bname = bname;
        this.scount = scount;
        this.bprice = bprice;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int getScount() {
        return scount;
    }

    public void setScount(int scount) {
        this.scount = scount;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getBname() {
        return bname;
    }

    public void setBname(String bname) {
        this.bname = bname;
    }

    public float getBprice() {
        return bprice;
    }

    public void setBprice(float bprice) {
        this.bprice = bprice;
    }

    @Override
    public String toString() {
        return "Sale{" +
                "Uname=" + uname +
                ", Bname='" + bname + '\'' +
                ", Scount='" + scount + '\'' +
                ", Bprice=" + bprice +
                '}';
    }
}

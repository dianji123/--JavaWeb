package com.entity;

public class Book {

    private int bid;
    private String bname;
    private float bprice;
    private String btype;
    private int bstock;
    private int bsale;
    private String bdesc;

    public Book(){

    }

    public Book(String bname, float bprice, String btype, int bstock, String bdesc) {
        this.bname = bname;
        this.bprice = bprice;
        this.btype = btype;
        this.bstock = bstock;
        this.bdesc = bdesc;
    }

    public Book(int bid, String bname, float bprice, String btype, int bstock, int bsale, String bdesc) {
        this.bid = bid;
        this.bname = bname;
        this.bprice = bprice;
        this.btype = btype;
        this.bstock = bstock;
        this.bsale = bsale;
        this.bdesc = bdesc;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
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

    public String getBtype() {
        return btype;
    }

    public void setBtype(String btype) {
        this.btype = btype;
    }

    public int getBstock() {
        return bstock;
    }

    public void setBstock(int bstock) {
        this.bstock = bstock;
    }

    public int getBsale() {
        return bsale;
    }

    public void setBsale(int bsale) {
        this.bsale = bsale;
    }

    public String getBdesc() {
        return bdesc;
    }

    public void setBdesc(String bdesc) {
        this.bdesc = bdesc;
    }

    @Override
    public String toString() {
        return "Book{" +
                "bid=" + bid +
                ", bname='" + bname + '\'' +
                ", bprice=" + bprice +
                ", btype='" + btype + '\'' +
                ", bstock=" + bstock +
                ", bsale=" + bsale +
                ", bdesc='" + bdesc + '\'' +
                '}';
    }
}

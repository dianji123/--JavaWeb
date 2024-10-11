package com.dao;

import com.entity.Book;
import com.entity.Sale;

import java.util.List;

public interface BookDao {

    public List<Book> getTypeList(String btype);
    public List<Book> listAll();
    public Book oneBook(int bid);
    public int addBook(Book b);
    public int changeBook(int bid, float bprice, int bstock);
    public int deleteBook(int bid);

}

package com.dao;

import com.entity.Book;
import com.entity.Sale;

import java.util.List;

public interface SaleDao {

    public List<Book> getBookSale(int bid);
    public List<Sale> getSalelist(int uid);
    public List<Sale> getAllSalelist();
    public int saleBook(int uid, int bid, int scount);

}

package com.pahanaedu.pahanaedubilling.model;

import java.util.Date;
import java.util.List;

public class Bill {
    private int id;
    private int customerId;
    private double total;
    private Date billDate;
    private List<Item> items; // optional: items included in this bill

    public Bill() {}

    public Bill(int id, int customerId, double total, Date billDate, List<Item> items) {
        this.id = id;
        this.customerId = customerId;
        this.total = total;
        this.billDate = billDate;
        this.items = items;
    }

    public Bill(int customerId, double total, Date billDate, List<Item> items) {
        this.customerId = customerId;
        this.total = total;
        this.billDate = billDate;
        this.items = items;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public Date getBillDate() { return billDate; }
    public void setBillDate(Date billDate) { this.billDate = billDate; }

    public List<Item> getItems() { return items; }
    public void setItems(List<Item> items) { this.items = items; }

    @Override
    public String toString() {
        return "Bill{id=" + id + ", customerId=" + customerId + ", total=" + total + ", date=" + billDate + "}";
    }
}

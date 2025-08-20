package com.pahanaedu.pahanaedubilling.model;

public class Item {
    private int id;
    private String name;
    private double price;
    private int qty;

    public Item() {}

    public Item(int id, String name, double price, int qty) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.qty = qty;
    }

    // Getters & Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }

    public int getQty() {
        return qty;
    }
    public void setQty(int qty) {
        this.qty = qty;
    }
    
    public String toString() {
    	return "Item {Id="+id+", name="+name+", price="+price+", QTY="+qty+"}";
	}
}

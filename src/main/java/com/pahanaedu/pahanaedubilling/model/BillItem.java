package com.pahanaedu.pahanaedubilling.model;

public class BillItem {

    private int billItemId;
    private int billId;
    private int itemId;
    private int quantity;
    private double lineTotal;

    // Default constructor
    public BillItem() {
    }

    // Parameterized constructor
    public BillItem(int billItemId, int billId, int itemId, int quantity, double lineTotal) {
        this.billItemId = billItemId;
        this.billId = billId;
        this.itemId = itemId;
        this.quantity = quantity;
        this.lineTotal = lineTotal;
    }

    // Getters and Setters
    public int getBillItemId() {
        return billItemId;
    }

    public void setBillItemId(int billItemId) {
        this.billItemId = billItemId;
    }

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getLineTotal() {
        return lineTotal;
    }

    public void setLineTotal(double lineTotal) {
        this.lineTotal = lineTotal;
    }

    // toString override
    @Override
    public String toString() {
        return "BillItem{" +
                "billItemId=" + billItemId +
                ", billId=" + billId +
                ", itemId=" + itemId +
                ", quantity=" + quantity +
                ", lineTotal=" + lineTotal +
                '}';
    }
}
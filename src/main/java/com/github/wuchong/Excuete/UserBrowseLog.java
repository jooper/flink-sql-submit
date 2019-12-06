package com.github.wuchong.Excuete;

public class UserBrowseLog {

    private String userID;
    private String eventTime;
    private String eventType;
    private String productID;
    private int productPrice;
    private long eventTimeTimestamp;


    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getEventTime() {
        return eventTime;
    }

    public void setEventTime(String eventTime) {
        this.eventTime = eventTime;
    }

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public int getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(int productPrice) {
        this.productPrice = productPrice;
    }

    public long getEventTimeTimestamp() {
        return eventTimeTimestamp;
    }

    public void setEventTimeTimestamp(long eventTimeTimestamp) {
        this.eventTimeTimestamp = eventTimeTimestamp;
    }
}

package com.abmm.sh.abmm.model;

/**
 *
 */
public class MainOrderModel {
    private String clearingprice;
    private String id = "";
    private String orderid = "";
    private String shopid = "";
    private String itemid = "";
    private String code = "";
    private String useddate = "";
    private String price = "";
    private String dateline = "";
    private String status = "";
    private String title = "";
    private String ordertime = "";

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getClearingprice() {
        return clearingprice;
    }

    public void setClearingprice(String clearingprice) {
        this.clearingprice = clearingprice;
    }

    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }

    public String getShopid() {
        return shopid;
    }

    public void setShopid(String shopid) {
        this.shopid = shopid;
    }

    public String getItemid() {
        return itemid;
    }

    public void setItemid(String itemid) {
        this.itemid = itemid;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getUsedate() {
        return useddate;
    }

    public void setUsedate(String usedate) {
        this.useddate = usedate;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDateline() {
        return dateline;
    }

    public void setDateline(String dateline) {
        this.dateline = dateline;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getOrdertime() {
        return ordertime;
    }

    public void setOrdertime(String ordertime) {
        this.ordertime = ordertime;
    }
}

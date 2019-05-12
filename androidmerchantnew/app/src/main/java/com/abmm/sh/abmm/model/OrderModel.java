package com.abmm.sh.abmm.model;

import java.io.Serializable;

/**
 * 订单列表model
 */
public class OrderModel implements Serializable {
    private String buyeraddress = "";
    private String buyermobile = "";
    private String buyername = "";
    private String orderid = "";
    private String ordertime = "";
    private String status = "";
    private String payableamt = "";
    private String clearingprice;
    private String statusname = "";
    private String memo = "";
    private String title = "";
    private String pic = "";
    private String type = "";
    private String num = "";
    private String price = "";
    private String expresscompany;
    private String expressno;
    private String[] express;

    public String getPayableamt() {
        return payableamt;
    }

    public void setPayableamt(String payableamt) {
        this.payableamt = payableamt;
    }

    public String getClearingprice() {
        return clearingprice;
    }

    public void setClearingprice(String clearingprice) {
        this.clearingprice = clearingprice;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getBuyeraddress() {
        return buyeraddress;
    }

    public void setBuyeraddress(String buyeraddress) {
        this.buyeraddress = buyeraddress;
    }

    public String getBuyermobile() {
        return buyermobile;
    }

    public void setBuyermobile(String buyermobile) {
        this.buyermobile = buyermobile;
    }

    public String getBuyername() {
        return buyername;
    }

    public void setBuyername(String buyername) {
        this.buyername = buyername;
    }

    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }

    public String getOrdertime() {
        return ordertime;
    }

    public void setOrdertime(String ordertime) {
        this.ordertime = ordertime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatusname() {
        return statusname;
    }

    public void setStatusname(String statusname) {
        this.statusname = statusname;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getExpresscompany() {
        return expresscompany;
    }

    public void setExpresscompany(String expresscompany) {
        this.expresscompany = expresscompany;
    }

    public String getExpressno() {
        return expressno;
    }

    public void setExpressno(String expressno) {
        this.expressno = expressno;
    }

    public String[] getExpress() {
        return express;
    }

    public void setExpress(String[] express) {
        this.express = express;
    }
}

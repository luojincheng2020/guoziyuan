package com.abmm.sh.abmm.model;

import java.io.Serializable;

/**
 * 到店付model
 */
public class DaodianfuModel implements Serializable {
    private String ordertime = "";
    private String sellerusername = "";
    private String payableamt = "";

    public String getSellerusername() {
        return sellerusername;
    }

    public void setSellerusername(String sellerusername) {
        this.sellerusername = sellerusername;
    }

    public String getPayableamt() {
        return payableamt;
    }

    public void setPayableamt(String payableamt) {
        this.payableamt = payableamt;
    }

    public String getOrdertime() {
        return ordertime;
    }

    public void setOrdertime(String ordertime) {
        this.ordertime = ordertime;
    }
}

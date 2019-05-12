package com.abmm.sh.abmm.model;

import java.io.Serializable;

/**
 * 积分model
 */
public class PointModel implements Serializable {
    private String content = "";
    private String dateline = "";
    private String point = "";

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPoint() {
        return point;
    }

    public void setPoint(String point) {
        this.point = point;
    }

    public String getDateline() {
        return dateline;
    }

    public void setDateline(String dateline) {
        this.dateline = dateline;
    }

}

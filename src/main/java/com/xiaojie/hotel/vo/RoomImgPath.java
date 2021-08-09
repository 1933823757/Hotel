package com.xiaojie.hotel.vo;

import java.util.List;

public class RoomImgPath<T> {
    private Object object;
    private List<T> imgPathList;

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }

    public List<T> getImgPathList() {
        return imgPathList;
    }

    public void setImgPathList(List<T> imgPathList) {
        this.imgPathList = imgPathList;
    }

    public RoomImgPath(Object object, List<T> imgPathList) {
        this.object = object;
        this.imgPathList = imgPathList;
    }

    public RoomImgPath() {
    }

    @Override
    public String toString() {
        return "RoomImgPath{" +
                "object=" + object +
                ", imgPathList=" + imgPathList +
                '}';
    }
}

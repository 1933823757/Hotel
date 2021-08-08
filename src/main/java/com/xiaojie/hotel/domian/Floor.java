package com.xiaojie.hotel.domian;

public class Floor {
    private String id;
    private String floorId;
    private String roomType;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFloorId() {
        return floorId;
    }

    public void setFloorId(String floorId) {
        this.floorId = floorId;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    @Override
    public String toString() {
        return "Floor{" +
                "id='" + id + '\'' +
                ", floorId='" + floorId + '\'' +
                ", roomType='" + roomType + '\'' +
                '}';
    }
}

package com.xiaojie.hotel.domian;

public class Room {
   private String id;
   private String roomId;
   private String roomType;
   private String  roomPrice;
   private String roomSuggest;
   private String roomImgPath;
    private String floorId;

    public String getFloorId() {
        return floorId;
    }

    public void setFloorId(String floorId) {
        this.floorId = floorId;
    }

    public String getRoomSuggest() {
        return roomSuggest;
    }

    public void setRoomSuggest(String roomSuggest) {
        this.roomSuggest = roomSuggest;
    }

    public String getRoomImgPath() {
        return roomImgPath;
    }

    public void setRoomImgPath(String roomImgPath) {
        this.roomImgPath = roomImgPath;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getRoomPrice() {
        return roomPrice;
    }

    public void setRoomPrice(String roomPrice) {
        this.roomPrice = roomPrice;
    }

    @Override
    public String toString() {
        return "Room{" +
                "id='" + id + '\'' +
                ", roomId='" + roomId + '\'' +
                ", roomType='" + roomType + '\'' +
                ", roomPrice='" + roomPrice + '\'' +
                ", roomSuggest='" + roomSuggest + '\'' +
                ", roomImgPath='" + roomImgPath + '\'' +
                ", floorId='" + floorId + '\'' +
                '}';
    }
}

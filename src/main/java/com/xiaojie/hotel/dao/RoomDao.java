package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.Floor;
import com.xiaojie.hotel.domian.MoveRoom;
import com.xiaojie.hotel.domian.Room;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoomDao {


    Integer getDeleteCount(String[] id);

    int deleteRoom(String[] id);

    Integer getCountRoom(String id);

    int addRoom(Room room);

    int getRoomByRoomId(@Param("roomId") String roomId,@Param("floorId") String floorId);

    List<Floor> selectRoomAll(Room room);


    Room getRoomById(String id);

    int updateRoom(Room room);

    int isRoomId(@Param("floorId") String floorId, @Param("roomId") String roomId);

    int deleteRoomById(String[] id);

    List<Room> getRoomIdAll(@Param("list") List<MoveRoom> list,@Param("flag") String flag);

    Room selectRoomType(String roomId);

    Room getRoomByRoom(String roomId);

    List<Room> getRoomByList(List<MoveRoom> list);

    List<Room> getRooms(Integer num);

    List<Room> getRoomFenYe(List<Room> list);

    List<Room> getDeluse(@Param("list") List<Room> roomList,@Param("roomType") String name);

    int updateRoomByFlooId(Floor id);

    Integer seletRoomByFloor(Floor floor);


    List<Room> getRoomId(String[] id);

    List<Room> getRoomByFloorId(String roomType);
}

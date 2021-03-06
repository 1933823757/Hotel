package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MoveRoomDao {
    List<MoveRoom> selectMoveRoomByStage(@Param("stage") String stage,@Param("stage2") String stage2);

    int addMoveRoom(MoveRoom moveRoom);

    int updateMoveRoom(MoveRoom moveRoom);

    int updateMoveRoomNotRoom(MoveRoom moveRoom);

    int deleteMoveRoomByEngageId(@Param("engageId") String engageId,@Param("state") String state);

    List<MoveRoom> getMoveRoomAll();

    List<Engage> getMoveRoomFenYe(MoveRoom moveRoom);

    MoveRoom selectMoveRoomById(String id);

    int updateRuZhu(MoveRoom moveRoom);

    int updateRuZhuPrice(MoveRoom moveRoom);

    int deleteMoveROomById(String id);

    List<MoveRoom> getRoomList();

    List<MoveRoom> selectMoveRoomByEngage(String roomType);

    int updateMoveRoomByEngage(@Param("list") List<MoveRoom> moveList,@Param("roomType") String roomType);

    Integer findMoveRoom(List<Room> roomList);

    int deleteMoveROomByRoomType(List<Room> roomList);

    MoveRoom selectMove(String username);

    int updateMoveByUser(@Param("user") User user,@Param("username") String username);

    int selectMoveCount(List<OrderInformAtion> list);

    int deleteMoveByOrder(List<OrderInformAtion> list);
}

package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.Engage;
import com.xiaojie.hotel.domian.MoveRoom;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MoveRoomDao {
    List<MoveRoom> selectMoveRoomByStage(@Param("stage") String stage,@Param("stage2") String stage2);

    int addMoveRoom(MoveRoom moveRoom);

    int updateMoveRoom(MoveRoom moveRoom);

    int updateMoveRoomNotRoom(MoveRoom moveRoom);

    int deleteMoveRoomByEngageId(String engageId);

    List<MoveRoom> getMoveRoomAll();

    List<Engage> getMoveRoomFenYe(MoveRoom moveRoom);

    MoveRoom selectMoveRoomById(String id);

    int updateRuZhu(MoveRoom moveRoom);

    int updateRuZhuPrice(MoveRoom moveRoom);
}

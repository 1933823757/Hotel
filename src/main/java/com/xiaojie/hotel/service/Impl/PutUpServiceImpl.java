package com.xiaojie.hotel.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaojie.hotel.dao.EngageDao;
import com.xiaojie.hotel.dao.MoveRoomDao;
import com.xiaojie.hotel.dao.OrderInformAtionDao;
import com.xiaojie.hotel.dao.RoomDao;
import com.xiaojie.hotel.domian.Engage;
import com.xiaojie.hotel.domian.MoveRoom;
import com.xiaojie.hotel.domian.OrderInformAtion;
import com.xiaojie.hotel.domian.Room;
import com.xiaojie.hotel.service.PutUpService;
import com.xiaojie.hotel.util.DateTimeUtil;
import com.xiaojie.hotel.util.UUIDUtil;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PutUpServiceImpl implements PutUpService {
    private EngageDao engageDao;
    private RoomDao roomDao;
    private MoveRoomDao moveRoomDao;
    private OrderInformAtionDao orderInformAtionDao;

    public void setOrderInformAtionDao(OrderInformAtionDao orderInformAtionDao) {
        this.orderInformAtionDao = orderInformAtionDao;
    }

    public void setMoveRoomDao(MoveRoomDao moveRoomDao) {
        this.moveRoomDao = moveRoomDao;
    }

    public void setRoomDao(RoomDao roomDao) {
        this.roomDao = roomDao;
    }

    public void setEngageDao(EngageDao engageDao) {
        this.engageDao = engageDao;
    }

    //获取房间所有的房间号,
    @Transactional
    @Override
    public List<Room> getRoomIdAll() {
        String  stage = "1";
        String stage2 = "2";
        String flag = "";
        //如果房间状态为1 的话，则说明房间有人入住，则排除此房间
        List<MoveRoom> moveRoomList = moveRoomDao.selectMoveRoomByStage(stage,stage2);
        if (moveRoomList.size()>0){
            flag +="1";
        }
        List<Room> list = roomDao.getRoomIdAll(moveRoomList,flag);
        return list;
    }

    //添加住宿预定的业务处理
    @Transactional
    @Override
    public Map<String, Object> addEngage(Engage engage) {
        Map<String,Object> map = new HashMap<>();
        boolean flag =false;
        //实体类里面还缺少一个房间类型属性值，则需要去查询
        Room room = roomDao.selectRoomType(engage.getRoomId());
        engage.setRoomType(room.getRoomType());
        String moveRoomId = UUIDUtil.getUUID();
        engage.setMoveRoomId(moveRoomId);
        int num = engageDao.addMoveRoom(engage);
        if (num == 1){
            //总预定天数
            Integer totalDay = (Integer.valueOf(engage.getClose_time().replace("-",""))-Integer.valueOf(engage.getStart_time().replace("-","")));
            //总价格
            Integer totalPrice = Integer.valueOf(room.getRoomPrice())*totalDay;
            //添加成功后，还需修改房间状态
            //"0" 休闲状态 "1" 预定状态  "2" 已入住
            //新建入住信息,把添加的预定信息添加进去
            MoveRoom moveRoom = new MoveRoom();
            moveRoom.setC_tel(engage.getC_tel());
            //预定的时间
            moveRoom.setC_name(engage.getC_name());
            moveRoom.setState("1");
            moveRoom.setFix_time(engage.getStart_time());
            moveRoom.setId(moveRoomId);
            moveRoom.setIdCard(engage.getIdCard());
            moveRoom.setManagerName(engage.getManagerName());
            moveRoom.setRoomId(room.getRoomId());
            moveRoom.setRoomPrice(String.valueOf(totalPrice));
            moveRoom.setEngageId(engage.getId());
            int num2 = moveRoomDao.addMoveRoom(moveRoom);
            if (num2 == 1){
                //添加订单信息
                OrderInformAtion orderInformAtion = new OrderInformAtion(UUIDUtil.getUUID(),engage.getC_name(), DateTimeUtil.getSysTime(),DateTimeUtil.getOrderId(),engage.getRoomId(),String.valueOf(totalPrice),engage.getId(),"1");
                int num3 = orderInformAtionDao.addOrderInformAtion(orderInformAtion);
                if (num3 ==1){
                    flag=true;
                }

            }
        }
        map.put("success",flag);
        return map;
    }

    //预定信息的分页查询
    @Override
    public Map<String, Object> getEngage(Engage engage, Integer pageNo, Integer pageSize) {
        //分页
        Map<String, Object> map = new HashMap<>();
        PageHelper.startPage(pageNo, pageSize);
        List<Engage> list = engageDao.getEngage(engage);
        PageInfo pageInfo = new PageInfo(list);
        map.put("total", pageInfo.getTotal());
        map.put("pages", pageInfo.getPages());
        map.put("list", pageInfo.getList());
        return map;
    }


    //修改查询预定信息
    @Override
    public Engage getEngageById(String id) {
        Engage engage = engageDao.getEngageById(id);
        return engage;
    }

    //修改预定信息
    @Transactional
    @Override
    public Map<String, Object> editEngage(Engage engage) {
        Map<String,Object> map = new HashMap<>();
        boolean flag = false;
        Room room=null;
        if (engage.getRoomId().length()==32){
            room = roomDao.getRoomById(engage.getRoomId());
        }else{
             room = roomDao.getRoomByRoom(engage.getRoomId());
        }
        //总预定天数
        Integer totalDay = (Integer.valueOf(engage.getClose_time().replace("-",""))-Integer.valueOf(engage.getStart_time().replace("-","")));
        //总价格
        Integer totalPrice = Integer.valueOf(room.getRoomPrice())*totalDay;
        MoveRoom moveRoom = new MoveRoom();
        //通过预定的id拿到住宿的id
        Engage engage1 = engageDao.getEngageById(engage.getId());
        moveRoom.setId(engage1.getMoveRoomId());
        moveRoom.setRoomPrice(String.valueOf(totalPrice));
        moveRoom.setC_name(engage.getC_name());
        moveRoom.setC_tel(engage.getC_tel());
        moveRoom.setIdCard(engage.getIdCard());
        moveRoom.setFix_time(engage.getStart_time());
        if (engage.getRoomId().length()==32){
            //如果等于32，则说明前台改了房间号，
            //设置最新的房间类型
            engage.setRoomType(room.getRoomType());
            int num2 = engageDao.updateEngageAll(engage);
            if (num2 == 1){
                //更新住宿表
                moveRoom.setRoomId(room.getRoomId());
                int num3 = moveRoomDao.updateMoveRoom(moveRoom);
                if (num3 == 1){
                    //更改订单信息
                    OrderInformAtion orderInformAtion = new OrderInformAtion(engage.getId(),engage.getC_name(),null,null,engage.getRoomId(),String.valueOf(totalPrice),null,null);
                    int num4 = orderInformAtionDao.updateOrder(orderInformAtion);
                    if (num4 == 1){
                        flag=true;
                    }

                }
            }
        }else{
            //则说明没改房间号,则房间信息不用更该
            int num = engageDao.updateEngageNoRoomId(engage);
            if (num == 1){

                int num5 = moveRoomDao.updateMoveRoomNotRoom(moveRoom);
                if (num5 == 1){
                    OrderInformAtion orderInformAtion = new OrderInformAtion();
                    orderInformAtion.setId(engage.getId());
                    orderInformAtion.setC_name(engage.getC_name());
                    orderInformAtion.setTotalPrice(String.valueOf(totalPrice));
                    int num6 = orderInformAtionDao.updateOrderNotRoom(orderInformAtion);
                    if (num6 == 1){
                        flag = true;
                    }

                }

        }
        }
        map.put("success",flag);
        return map;
    }

    //删除预定信息所有东西
    @Override
    public Map<String, Object> deleteEngage(String[] id) {
        Map<String, Object> map =new HashMap<>();
        boolean flag = false;
        int index = 0;
        for (int i=0;i<id.length;i++){
            String engageId = id[i];
            String orderState = "0";
            int num = engageDao.deleteEngageById(engageId);
            if (num == 1){
                int num2 = moveRoomDao.deleteMoveRoomByEngageId(engageId);
                if (num2 == 1){
                    int num3 = orderInformAtionDao.updateOrderStage(engageId,orderState);
                    if (num3 == 1){
                        index+=1;
                    }
                }
            }
        }
        if (index == id.length){
            flag=true;
        }
        map.put("success",flag);
        return map;
    }

}

package com.xiaojie.hotel.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaojie.hotel.dao.*;
import com.xiaojie.hotel.domian.*;
import com.xiaojie.hotel.service.PutUpService;
import com.xiaojie.hotel.util.DateTimeUtil;
import com.xiaojie.hotel.util.UUIDUtil;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class PutUpServiceImpl implements PutUpService {
    private EngageDao engageDao;
    private RoomDao roomDao;
    private MoveRoomDao moveRoomDao;
    private OrderInformAtionDao orderInformAtionDao;
    private CustomerDao customerDao;

    public void setCustomerDao(CustomerDao customerDao) {
        this.customerDao = customerDao;
    }

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
        String stage = "1";
        String stage2 = "2";
        String flag = "";
        //如果房间状态为1 的话，则说明房间有人入住，则排除此房间
        List<MoveRoom> moveRoomList = moveRoomDao.selectMoveRoomByStage(stage, stage2);
        if (moveRoomList.size() > 0) {
            flag += "1";
        }
        List<Room> list = roomDao.getRoomIdAll(moveRoomList, flag);
        return list;
    }

    //添加住宿预定的业务处理
    @Transactional
    @Override
    public Map<String, Object> addEngage(Engage engage) {
        Map<String, Object> map = new HashMap<>();
        boolean flag = false;
        //实体类里面还缺少一个房间类型属性值，则需要去查询
        Room room = roomDao.selectRoomType(engage.getRoomId());
        engage.setRoomType(room.getRoomType());

        String moveRoomId = UUIDUtil.getUUID();
        engage.setMoveRoomId(moveRoomId);
        int num = engageDao.addMoveRoom(engage);
        if (num == 1) {
            //总预定天数
            Integer totalDay = (Integer.valueOf(engage.getClose_time().replace("-", "")) - Integer.valueOf(engage.getStart_time().replace("-", "")));
            //总价格
            Integer totalPrice = Integer.valueOf(room.getRoomPrice()) * totalDay;
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
            moveRoom.setClose_time(engage.getClose_time());
            moveRoom.setRoomType(room.getRoomType());
            int num2 = moveRoomDao.addMoveRoom(moveRoom);
            if (num2 == 1) {
                String orderId = DateTimeUtil.getOrderId();
                //添加订单信息
                OrderInformAtion orderInformAtion = new OrderInformAtion(UUIDUtil.getUUID(), engage.getC_name(), DateTimeUtil.getSysTime(),orderId, engage.getRoomId(), String.valueOf(totalPrice), engage.getId(), "1");
                int num3 = orderInformAtionDao.addOrderInformAtion(orderInformAtion);
                if (num3 == 1) {
                    //创建客户信息
                    Customer customer = new Customer();
                    customer.setId(UUIDUtil.getUUID());
                    customer.setC_name(engage.getC_name());
                    customer.setC_start_time(DateTimeUtil.getSysTime());
                    customer.setC_tel(engage.getC_tel());
                    customer.setEngageId(engage.getId());
                    customer.setIdCard(engage.getIdCard());
                    customer.setOrder_id(orderId);
                    customer.setRoomId(room.getRoomId());
                    customer.setState("1");
                    int num4 = customerDao.addCustomer(customer);
                    if (num4 == 1){
                        flag = true;
                    }
                }

            }
        }
        map.put("success", flag);
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
        Map<String, Object> map = new HashMap<>();
        boolean flag = false;
        Room room = null;
        if (engage.getRoomId().length() == 32) {
            room = roomDao.getRoomById(engage.getRoomId());
        } else {
            room = roomDao.getRoomByRoom(engage.getRoomId());
        }
        //总预定天数
        Integer totalDay = (Integer.valueOf(engage.getClose_time().replace("-", "")) - Integer.valueOf(engage.getStart_time().replace("-", "")));
        //总价格
        Integer totalPrice = Integer.valueOf(room.getRoomPrice()) * totalDay;
        MoveRoom moveRoom = new MoveRoom();
        //通过预定的id拿到住宿的id
        Engage engage1 = engageDao.getEngageById(engage.getId());
        moveRoom.setId(engage1.getMoveRoomId());
        moveRoom.setRoomPrice(String.valueOf(totalPrice));
        moveRoom.setC_name(engage.getC_name());
        moveRoom.setC_tel(engage.getC_tel());
        moveRoom.setIdCard(engage.getIdCard());
        moveRoom.setFix_time(engage.getStart_time());
        moveRoom.setClose_time(engage.getClose_time());
        //修改客户信息
        Customer customer = new Customer();
        customer.setC_name(engage.getC_name());
        customer.setC_tel(engage.getC_tel());
        customer.setEngageId(engage.getId());
        customer.setIdCard(engage.getIdCard());
        if (engage.getRoomId().length() == 32) {
            //如果等于32，则说明前台改了房间号，
            //设置最新的房间类型
            engage.setRoomType(room.getRoomType());
            int num2 = engageDao.updateEngageAll(engage);
            if (num2 == 1) {
                //更新住宿表和房间类型
                moveRoom.setRoomType(room.getRoomType());
                moveRoom.setRoomId(room.getRoomId());
                int num3 = moveRoomDao.updateMoveRoom(moveRoom);
                if (num3 == 1) {
                    //更改订单信息
                    OrderInformAtion orderInformAtion = new OrderInformAtion(engage.getId(), engage.getC_name(), null, null, engage.getRoomId(), String.valueOf(totalPrice), null, null);
                    int num4 = orderInformAtionDao.updateOrder(orderInformAtion);
                    if (num4 == 1) {
                        //修改客户信息
                        customer.setRoomId(room.getRoomId());
                        int num5 = customerDao.updateCustomer(customer);
                        if (num5 == 1){
                            flag = true;
                        }
                    }

                }
            }
        } else {
            //则说明没改房间号,则房间信息不用更该
            int num = engageDao.updateEngageNoRoomId(engage);
            if (num == 1) {

                int num5 = moveRoomDao.updateMoveRoomNotRoom(moveRoom);
                if (num5 == 1) {
                    OrderInformAtion orderInformAtion = new OrderInformAtion();
                    orderInformAtion.setId(engage.getId());
                    orderInformAtion.setC_name(engage.getC_name());
                    orderInformAtion.setTotalPrice(String.valueOf(totalPrice));
                    int num6 = orderInformAtionDao.updateOrderNotRoom(orderInformAtion);
                    if (num6 == 1) {
                        int num7 = customerDao.updateCustomerNotRoomId(customer);
                        flag = true;
                    }

                }

            }
        }
        map.put("success", flag);
        return map;
    }

    @Transactional
    //删除预定信息所有东西
    @Override
    public Map<String, Object> deleteEngage(String[] id) {
        Map<String, Object> map = new HashMap<>();
        boolean flag = false;
        int index = 0;
        for (int i = 0; i < id.length; i++) {
            String engageId = id[i];
            String orderState = "0";
            int num = engageDao.deleteEngageById(engageId);
            if (num == 1) {
                //1代表预定状态的房间
                String state = "1";
                int num2 = moveRoomDao.deleteMoveRoomByEngageId(engageId,state);
                int num3 = orderInformAtionDao.updateOrderStage(engageId, orderState);
                if (num2 == 1){
                    int num4 = customerDao.deleteCustomer(engageId);
                }
                if (num3 == 1) {
                    index += 1;
                }
            }
        }
        if (index == id.length) {
            flag = true;
        }
        map.put("success", flag);
        return map;
    }

    //--------------------入住业务
    @Override
    public Map<String, Object> getRoomAll() {
        Map<String, Object> map = new HashMap<>();
        List<MoveRoom> list = moveRoomDao.getMoveRoomAll();
        List<Room> room = roomDao.getRoomByList(list);
        map.put("success", room);
        return map;
    }

    //分页查询业务
    @Override
    public Map<String, Object> getMoveRoomFenYe(MoveRoom moveRoom, Integer pageNo1, Integer pageSize1) {
        //分页
        Map<String, Object> map = new HashMap<>();

        if (moveRoom.getRoomId().length() != 0) {
            Room room = roomDao.getRoomById(moveRoom.getRoomId());
            moveRoom.setRoomId(room.getRoomId());
        }
        PageHelper.startPage(pageNo1, pageSize1);
        List<Engage> list = moveRoomDao.getMoveRoomFenYe(moveRoom);
        PageInfo pageInfo = new PageInfo(list);
        map.put("total", pageInfo.getTotal());
        map.put("pages", pageInfo.getPages());
        map.put("list", pageInfo.getList());
        return map;
    }


    //把预定信息转为住宿信息
    @Override
    public MoveRoom getMr(String id) {
        MoveRoom moveRoom = moveRoomDao.selectMoveRoomById(id);
        return moveRoom;
    }

    //登记入住信息
    @Transactional
    @Override
    public Map<String, Object> updateRoom(MoveRoom moveRoom) {
        boolean flag = false;
        Map<String, Object> map = new HashMap<>();
        //通过传过来的id查询到预定信息的id
        MoveRoom moveRoom1 = moveRoomDao.selectMoveRoomById(moveRoom.getId());
        int num = moveRoomDao.updateRuZhu(moveRoom);
        //更改订单信息
        OrderInformAtion orderInformAtion = new OrderInformAtion();
        orderInformAtion.setC_name(moveRoom.getC_name());
        orderInformAtion.setUserId(moveRoom1.getEngageId());
        //更改客户信息
        Customer customer = new Customer();
        customer.setC_name(moveRoom.getC_name());
        customer.setIdCard(moveRoom.getIdCard());
        customer.setState(moveRoom.getState());
        customer.setC_tel(moveRoom.getC_tel());
        customer.setEngageId(moveRoom1.getEngageId());
        int num4 = customerDao.updateCustomerState(customer);
        int num3 = orderInformAtionDao.update(orderInformAtion);
        if (num3 == 1) {
            flag = true;
        }
        if (num == 1) {
            //如果此时的状态不一样的话，说明前台改了入住状态，则需要删除预定信息表里的数据
            if(Integer.valueOf(moveRoom1.getState()) !=Integer.valueOf(moveRoom.getState())){
                engageDao.deleteEngageById(moveRoom1.getEngageId());
                flag = true;
            }else {
                Engage engage = new Engage();
                engage.setC_name(moveRoom.getC_name());
                engage.setC_tel(moveRoom.getC_tel());
                engage.setClose_time(moveRoom.getClose_time());
                engage.setIdCard(moveRoom.getIdCard());
                engage.setId(moveRoom1.getEngageId());
                int num2 = engageDao.updateEngage(engage);
                if (num2 == 1) {
                  flag = true;
                }
            }
        }
        map.put("success", flag);
        return map;
    }

    @Transactional
    //更新入住信息业务
    @Override
    public Map<String, Object> moveUpdate(MoveRoom moveRoom) {
        boolean flag = false;
        Map<String, Object> map = new HashMap<>();
        //预定的时间
        String fix_time = moveRoom.getFix_time().replace("-", "");
        //前台修改的退房时间
        String close_time = moveRoom.getClose_time().replace("-", "");
        //通过房间的roomID去查询房间的价格
        Room room = roomDao.getRoomByRoom(moveRoom.getRoomId());
        //计算总价格
        Integer roomPrice = (Integer.valueOf(close_time) - Integer.valueOf(fix_time)) * Integer.valueOf(room.getRoomPrice());
        moveRoom.setRoomPrice(String.valueOf(roomPrice));
        //通过传过来的id查询到预定信息的id
        MoveRoom moveRoom1 = moveRoomDao.selectMoveRoomById(moveRoom.getId());
        int num = moveRoomDao.updateRuZhuPrice(moveRoom);
        //更改订单信息
        OrderInformAtion orderInformAtion = new OrderInformAtion();
        orderInformAtion.setC_name(moveRoom.getC_name());
        orderInformAtion.setId(moveRoom1.getEngageId());
        orderInformAtion.setTotalPrice(moveRoom.getRoomPrice());
        //更改客户信息
        Customer customer = new Customer();
        customer.setC_name(moveRoom.getC_name());
        customer.setIdCard(moveRoom.getIdCard());
        customer.setState(moveRoom.getState());
        customer.setC_tel(moveRoom.getC_tel());
        customer.setEngageId(moveRoom1.getEngageId());
        int num4 = customerDao.updateCustomerState(customer);
        int num3 = orderInformAtionDao.updateOrderNotRoom(orderInformAtion);
        if (num3 == 1) {
            flag = true;
        }
        if(Integer.valueOf(moveRoom1.getState()) !=Integer.valueOf(moveRoom.getState())){
            engageDao.deleteEngageById(moveRoom1.getEngageId());
        }else{
            Engage engage = new Engage();
            engage.setC_name(moveRoom.getC_name());
            engage.setC_tel(moveRoom.getC_tel());
            engage.setClose_time(moveRoom.getClose_time());
            engage.setIdCard(moveRoom.getIdCard());
            engage.setId(moveRoom1.getEngageId());
            int num2 = engageDao.updateEngage(engage);
            if (num2 == 1) {
                flag=true;
            }
        }
        map.put("success", flag);
        return map;
    }

    //退房业务
    @Transactional
    @Override
    public Map<String, Object> checkOut(String id) {
        Map<String, Object> map = new HashMap<>();
        //先拿id去判断用户的状态，已预定还是入住中，如果在入住的话，则需删除记录，如果是预定，则提示前此用户还未入住
        MoveRoom moveRoom = moveRoomDao.selectMoveRoomById(id);
        String state = "1";
        if (state.equals(moveRoom.getState())){
            //说明此用户处于预定状态，则提示前台
            map.put("success",false);
            map.put("title",moveRoom.getC_name()+"客户还未入住，登记退房失败");
        }else{
            //删除入住信息记录
            int num = moveRoomDao.deleteMoveROomById(id);
            //删除入住记录后去更改客户的入住状态
            String customerState = "0";
            int num3 = customerDao.updateCustomerByState(customerState,moveRoom.getEngageId());
            if (num == 1){
                map.put("title",moveRoom.getC_name()+"退房成功");
                map.put("success",true);
            }
        }
        return map;
    }


    //主页展示所有房间状态的业务
    @Override
    public Map<String, Object> getRoomList() {
        List<MoveRoom> list = moveRoomDao.getRoomList();
        Map<String,Object> map = new HashMap<>();
        map.put("list",list);
        return map;
    }

}

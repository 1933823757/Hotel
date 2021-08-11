package com.xiaojie.hotel.controller;

import com.xiaojie.hotel.domian.Engage;
import com.xiaojie.hotel.domian.Manager;
import com.xiaojie.hotel.domian.MoveRoom;
import com.xiaojie.hotel.domian.Room;
import com.xiaojie.hotel.service.PutUpService;
import com.xiaojie.hotel.util.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
      住宿管理模块控制器
 */
@Controller
@RequestMapping("/putup")
public class PutupController {
    @Autowired
    private PutUpService putUpService;

    //跳转到住宿预定界面
    @RequestMapping("/toputupbook.do")
    public String toPutupBook() {
        return "/rootpage/putup/putupbook";
    }

    //跳转到住宿登记界面
    @RequestMapping("/toHotelRegistraTion.do")
    public String toHotelRegistraTion() {
        return "/rootpage/putup/hotelregistration";
    }

    //获取所有房间号的请求
    @RequestMapping("/getRoomIdAll.do")
    @ResponseBody
    public Map<String, Object> getRoomIdAll() {
        List<Room> list = putUpService.getRoomIdAll();
        Map<String, Object> map = new HashMap<>();
        map.put("success", list);
        return map;
    }

    //添加预定住宿
    @RequestMapping("/addEngage.do")
    @ResponseBody
    public Map<String, Object> addMoveRoom(Engage engage, HttpServletRequest request) {
        Manager manager = (Manager) request.getSession().getAttribute("manager");
        engage.setManagerName(manager.getManagerName());
        engage.setId(UUIDUtil.getUUID());
        Map<String, Object> map = putUpService.addEngage(engage);
        return map;
    }

    //获取预定住宿信息分页请求
    @RequestMapping("/getEngage.do")
    @ResponseBody
    public Map<String, Object> getEngage(Engage engage, String pageNo, String pageSize) {
        Integer pageNo1 = Integer.valueOf(pageNo);
        Integer pageSize1 = Integer.valueOf(pageSize);
        Map<String, Object> map = putUpService.getEngage(engage, pageNo1, pageSize1);
        return map;
    }

    //修改前获取预定信息的请求
    @RequestMapping("/getEngageById.do")
    @ResponseBody
    public Map<String, Object> getEngageById(String id) {
        Map<String, Object> map = new HashMap<>();
        //拿到当前的预定信息
        Engage engage = putUpService.getEngageById(id);
        //获取所有房间
        List<Room> list = putUpService.getRoomIdAll();
        map.put("engage", engage);
        map.put("roomList", list);
        return map;
    }

    //修改预定信息请求
    @RequestMapping("/editEngage.do")
    @ResponseBody
    public Map<String, Object> editEngage(Engage engage) {
        Map<String, Object> map = putUpService.editEngage(engage);
        return map;
    }

    //删除预定信息请求
    @RequestMapping("/deleteEnage.do")
    @ResponseBody
    public Map<String, Object> deleteEnage(HttpServletRequest request) {
        String[] id = request.getParameterValues("id");
        Map<String, Object> map = putUpService.deleteEngage(id);
        return map;
    }

    //-------------------------------下面是入住登入请求
    //获取所有的房间
    @RequestMapping("/selectRoomAll.do")
    @ResponseBody
    public Map<String,Object> selectRoomAll(){
        Map<String,Object> map = putUpService.getRoomAll();
        return map;
    }

    //分页查询
    @RequestMapping("/getMoveRoomFenYe.do")
    @ResponseBody
    public Map<String,Object> getMoveRoomFenYe(MoveRoom moveRoom,String pageNo,String pageSize){
        Integer pageNo1 = Integer.valueOf(pageNo);
        Integer pageSize1 = Integer.valueOf(pageSize);
        Map<String, Object> map = putUpService.getMoveRoomFenYe(moveRoom, pageNo1, pageSize1);
        return map;
    }

    //登记按钮获取单条记录请求
    @RequestMapping("/getmr.do")
    @ResponseBody
    public MoveRoom getMr(String id){
        MoveRoom moveRoom = putUpService.getMr(id);
        return moveRoom;
    }

    //登记请求
    @RequestMapping("/updateRoom.do")
    @ResponseBody
    public Map<String,Object> updateRoom(MoveRoom moveRoom){
        Map<String,Object> map = putUpService.updateRoom(moveRoom);
        return map;
    }

    //登记修改的请求
    @RequestMapping("/moveRoomUpdate.do")
    @ResponseBody
    public Map<String,Object> moveUpdate(MoveRoom moveRoom){
        Map<String,Object> map = putUpService.moveUpdate(moveRoom);
        return map;
    }
    //退房登记
    @RequestMapping("/checkout.do")
    @ResponseBody
    public Map<String,Object> checkOut(String id){
        Map<String,Object> map = putUpService.checkOut(id);
        return map;
    }
}

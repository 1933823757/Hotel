package com.xiaojie.hotel.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaojie.hotel.domian.Floor;
import com.xiaojie.hotel.domian.Room;
import com.xiaojie.hotel.service.RoomManagermentService;
import com.xiaojie.hotel.util.UUIDUtil;
import javafx.beans.binding.ObjectExpression;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
public class RootController {

    //跳转到房间楼层管理的jsp
    @RequestMapping("/tofloor.do")
    public ModelAndView toFloor() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("rootpage/roommanagement/floor");
        return mv;
    }

    //跳转到房间管理的jsp
    @RequestMapping("/toroommanagement.do")
    public ModelAndView toToroommanagerment() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("rootpage/roommanagement/roommanagement");
        return mv;
    }

    @Autowired
    private RoomManagermentService roomManagermentService;

    //添加楼层的控制层
    @RequestMapping(value = "/addFloor.do")
    @ResponseBody
    public Map<String, Object> addFloor(Floor floor) {
        floor.setId(UUIDUtil.getUUID());
        boolean flag = roomManagermentService.addFloor(floor);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        return map;
    }

    //    获取全部楼层
    @RequestMapping("/getFloorList.do")
    @ResponseBody
    public Map<String, Object> getFloorList(String floorId, String roomType, String pageNo, String pageSize) {
        Floor floor = new Floor();
        floor.setFloorId(floorId);
        floor.setRoomType(roomType);
        Integer pageNo1 = Integer.valueOf(pageNo);
        Integer pageSize1 = Integer.valueOf(pageSize);
        Map<String, Object> map = roomManagermentService.getFloorAll(floor, pageNo1, pageSize1);
        return map;
    }

    //根据id获取frool楼层信息
    @RequestMapping("/getFrool.do")
    @ResponseBody
    public Floor getFrool(String id) {
        Floor floor = roomManagermentService.getFloorById(id);
        return floor;
    }

    //修改楼层信息
    @RequestMapping("/updataFloor.do")
    @ResponseBody
    public Map<String, Object> updateFloor(Floor floor) {
        boolean flag = roomManagermentService.updateFloor(floor);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        return map;
    }

    //删除楼层信息
    @RequestMapping("/deleteFloorAndRoom.do")
    @ResponseBody
    public Map<String, Object> deleteFloorAndRoom(HttpServletRequest request) {
        String[] id = request.getParameterValues("id");
        Map<String, Object> map = new HashMap<>();
        Boolean flag = roomManagermentService.deleteFloorAndRoom(id);
        map.put("success", flag);
        return map;
    }

    //房间添加前获取楼层的请求
    @RequestMapping("/getFloorId.do")
    @ResponseBody
    public Map<String, Object> getFloorId() {
        List<Floor> list = roomManagermentService.getFloorId();
        Map<String, Object> map = new HashMap<>();
        map.put("success", list);
        return map;
    }

    List<String> imgPaths = new ArrayList<>();

    //房间文件图片上传
    @RequestMapping("/uploadFile.do")
    @ResponseBody
    public Map<String, Object> uploadFile(@RequestParam("file") MultipartFile file) {

        Map<String, Object> uploadData = new HashMap<String, Object>();
        //获取上传文件的原名
        String oldFileName = file.getOriginalFilename();
        //储存路径
        String saveFilePath = "D://Java-Webxiangmu//hotel//src//main//webapp//images//roomImgs";
        //新的图片名字
        String newFileName = UUIDUtil.getUUID() + oldFileName.substring(oldFileName.lastIndexOf("."));
        //新图片
        File newFile = new File(saveFilePath + "\\" + newFileName);
        try {
            file.transferTo(newFile);
            uploadData.put("code", 0);
            uploadData.put("msg", "上传成功");
            uploadData.put("data", "");
        } catch (IOException e) {
            uploadData.put("code", -1);
            uploadData.put("msg", "上传失败");
            uploadData.put("data", "");
            uploadData.put("error", "上传失败，请检查网络连接或联系管理员");
        }
        //将路径存入全局变量
        String path = "images/roomImgs/" + newFileName;
        imgPaths.add(path);
        System.out.println("string图片存放------------------------" + imgPaths.toString());
        return uploadData;
    }

    //添加房间的请求
    @RequestMapping("/addRoom.do")
    @ResponseBody
    public Map<String, Object> addRoom(Room room) {
        Map<String, Object> map = new HashMap<>();

        //首先判断全局变量里的list是否为零，为零则说明没有上传图片，则不填加数据
        if (imgPaths.size() == 0) {
            map.put("title", "图片未上传");
            map.put("success", false);
            return map;
            //否则则说明图片已经上传了，然后可以进行房间的添加了
        } else {
            //把list集合里的图片路径拼接一起存放在数据库里
            String roomImgPath = "";
            Iterator i = imgPaths.iterator();
            int index = 0;
            while (i.hasNext()) {
                String name = (String) i.next();
                roomImgPath += name;
                if (index < imgPaths.size() - 1) {
                    roomImgPath += ";";
                }
                index += 1;
            }
            room.setId(UUIDUtil.getUUID());
            room.setRoomImgPath(roomImgPath);
            map= roomManagermentService.addRoom(room);
            //当执行完sql语句后，把全局变量里list的数量清空，这样下一次上传图片就不是原先的
            if ((boolean)map.get("success")){
               imgPaths.clear();
            }
            return map;
        }

    }


    //房间分页查询
    @RequestMapping("/RoomPagelist.do")
    @ResponseBody
    public Map<String,Object> RoomPageList(Room room,String pageNo,String pageSize,HttpServletRequest request){
        Integer pageNo1 = Integer.valueOf(pageNo);
        Integer pageSize1 = Integer.valueOf(pageSize);
        roomManagermentService.getFloorType(request);
        Map<String,Object> map = roomManagermentService.RoomPageList(room,pageNo1,pageSize1);
        return map;
    }

    //房间修改按钮打开模态窗口前的事件
    @RequestMapping("/getRoomAll.do")
    @ResponseBody
    public Room getRoomAllById(String id){
        Room room = roomManagermentService.getRoomById(id);
        return room;
    }

    //更新房间信息
    @RequestMapping("/updateRoom.do")
    @ResponseBody
    public Map<String,Object> updateRoom(Room room){
        if (imgPaths.size()>0){
            //把list集合里的图片路径拼接一起存放在数据库里
            String roomImgPath = "";
            Iterator i = imgPaths.iterator();
            int index = 0;
            while (i.hasNext()) {
                String name = (String) i.next();
                roomImgPath += name;
                if (index < imgPaths.size() - 1) {
                    roomImgPath += ";";
                }
                index += 1;
            }
            //说明有上传图片，则需要更新图片
            room.setRoomImgPath(roomImgPath);
        }
        Map<String,Object> map= roomManagermentService.updateRoom(room);
        if ((boolean)map.get("success")){
            imgPaths.clear();
        }
        return map;
    }

    //删除房间信息
    @RequestMapping("/deleteRoom.do")
    @ResponseBody
    public Map<String, Object> deleteRoom(HttpServletRequest request) {
        String[] id = request.getParameterValues("id");
        Map<String, Object> map = new HashMap<>();
        Boolean flag = roomManagermentService.deleteRoom(id);
        map.put("success", flag);
        return map;
    }
}

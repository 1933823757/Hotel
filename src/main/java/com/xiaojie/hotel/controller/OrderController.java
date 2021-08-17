package com.xiaojie.hotel.controller;

import com.xiaojie.hotel.domian.Floor;
import com.xiaojie.hotel.domian.OrderInformAtion;
import com.xiaojie.hotel.service.OrderServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

//订单报表控制层
@Controller
@RequestMapping("/order")
public class OrderController {
    @RequestMapping("/toorder.do")
    public String toOrder(){
        return "rootpage/orderreport/order";
    }

    @Autowired
    private OrderServices orderService;

    @RequestMapping("/getRoomType.do")
    @ResponseBody
    public List<Floor> getRoomType(){
        List<Floor> list = orderService.getRoomType();
        return list;
    }

    @RequestMapping("/getOrderAll.do")
    @ResponseBody
    public Map getOrderAll(String pageNo, String pageSize, String floorId,String c_name,String order_id,String start_time,String orderState){
            Map<String,Object> map = orderService.getOrderAll(Integer.valueOf(pageNo), Integer.valueOf(pageSize),c_name,order_id,start_time,orderState,floorId);
            return map;
    }
}

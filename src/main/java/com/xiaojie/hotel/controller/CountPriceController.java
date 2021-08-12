package com.xiaojie.hotel.controller;

import com.xiaojie.hotel.service.CountPriceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class CountPriceController {

    @Autowired
    private CountPriceService countPriceService;

    @RequestMapping("/toCountPrice.do")
    public String toCountPrice(){
        return "rootpage/FinancialStatistics/PriceCount";
    }
    @RequestMapping("/getInvalidOrder.do")
    @ResponseBody
    public Map getInvalidOrder(){
        Map<String,Object> map = countPriceService.getInvalidOrder();
        return map;
    }
}

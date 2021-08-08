package com.xiaojie.hotel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RootController {

    //跳转到房间楼层管理的jsp
    @RequestMapping("/tofloor.do")
    public ModelAndView toFloor(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("rootpage/roommanagement/floor");
        return mv;
    }

    //跳转到房间管理的jsp
    @RequestMapping("/toroommanagement.do")
    public ModelAndView toToroommanagerment(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("rootpage/roommanagement/roommanagement");
        return  mv;
    }
}

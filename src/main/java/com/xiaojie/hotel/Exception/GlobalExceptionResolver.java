package com.xiaojie.hotel.Exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;
@ControllerAdvice
public class GlobalExceptionResolver {
    Map<String,Object> map =new HashMap<>();

    @ExceptionHandler(value = LoginCodeException.class)
    @ResponseBody
    public Map doCodeException(Exception ex){
       map.put("title",ex.getMessage());
       map.put("success",false);
        return map;
    }
    @ExceptionHandler(value = LoginUserException.class)
    @ResponseBody
    public Map doNameException(Exception ex){
        map.put("title",ex.getMessage());
        map.put("success",false);
        return map;
    }
    @ExceptionHandler(value = ErrorException.class)
    public ModelAndView EroorException(Exception ex){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/login.jsp");
        return mv;
    }
}

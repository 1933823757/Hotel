package com.xiaojie.hotel.Exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

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
}

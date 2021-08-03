package com.xiaojie.hotel.interceptors;

import com.xiaojie.hotel.domian.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null){
            response.sendRedirect("/Hotel/login.jsp");
            return false;

        }
        return true;
    }
}

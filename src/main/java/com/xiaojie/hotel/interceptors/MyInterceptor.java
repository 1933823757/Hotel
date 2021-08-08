package com.xiaojie.hotel.interceptors;

import com.xiaojie.hotel.domian.Manager;
import com.xiaojie.hotel.domian.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Enumeration;

public class MyInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String t ="";
       Enumeration<String> keys = request.getSession().getAttributeNames();
        while (keys.hasMoreElements()) {
            String name=keys.nextElement().toString();
            if (name.equals("user")){
                t=name;
                break;
            }else if (name.equals("manager")){
                t=name;
                break;
            }
        }
        User user = (User) request.getSession().getAttribute("user");
        Manager manager = (Manager) request.getSession().getAttribute("manager");
        if ("user".equals(t)){
            if (user == null ){
                response.sendRedirect("/Hotel/login.jsp");
                return false;

            }
            return true;
        }else{
           if (manager == null){
               response.sendRedirect("/Hotel/login.jsp");
               return false;
           }
           return  true;
        }

    }
}

package com.xiaojie.hotel.controller;

import com.xiaojie.hotel.domian.Customer;
import com.xiaojie.hotel.service.CustomerService;
import org.omg.PortableInterceptor.INACTIVE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/*
    客户列表控制器
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    private CustomerService customerService;


    @RequestMapping("/tocustomer.do")
    public String tocustomer(){
        return "rootpage/customer/customer";
    }

    @RequestMapping("/getCustomerList.do")
    @ResponseBody
    public Map<String,Object> getCustomerList(Customer customer,String pageNo,String pageSize){
        Integer pageNo1 = Integer.valueOf(pageNo);
        Integer pageSize1 = Integer.valueOf(pageSize);
        Map<String,Object> map = customerService.getCustomerList(customer,pageNo1,pageSize1);
        return map;
    }

    //删除客户记录
    @RequestMapping("/deleteCustomer.do")
    @ResponseBody
    public Map deleteCUstomer(HttpServletRequest request){
        String id[] =request.getParameterValues("id");
        Map<String,Object> map = customerService.deleteCustomer(id);
        return map;
    }
}

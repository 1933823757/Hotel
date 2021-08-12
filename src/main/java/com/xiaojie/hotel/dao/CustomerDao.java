package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.Customer;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface CustomerDao {
    int addCustomer(Customer customer);

    int updateCustomer(Customer customer);

    int updateCustomerNotRoomId(Customer customer);



    int deleteCustomer(String engageId);

    int updateCustomerState(Customer customer);

    int updateCustomerByState(@Param("state") String customerState,@Param("engageId") String engageId);

    List<Customer> selectCustomerAll(Customer customer);

    Customer selectCustomerById(String customerId);

    int deleteCustomerById(String customerId);
}

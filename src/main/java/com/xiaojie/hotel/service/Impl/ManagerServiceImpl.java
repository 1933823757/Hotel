package com.xiaojie.hotel.service.Impl;

import com.xiaojie.hotel.dao.ManagerDao;
import com.xiaojie.hotel.domian.Manager;
import com.xiaojie.hotel.service.ManagerService;

import java.util.HashMap;
import java.util.Map;

public class ManagerServiceImpl implements ManagerService {
    private ManagerDao managerDao;

    public void setManagerDao(ManagerDao managerDao) {
        this.managerDao = managerDao;
    }

    @Override
    public Manager getManager(Manager manager) {
        Manager manager1 = managerDao.getManager(manager);
        return manager1;
    }

    @Override
    public Map<String, Object> updateManager(Manager manager) {
        boolean flag = false;
        Map<String,Object> map = new HashMap<>();
        int num = managerDao.updateManager(manager);
        if (num == 1){
            flag = true;
            map.put("title",manager.getManagerId()+"管理员密码修改成功");
        }else {
            map.put("title","修改失败");
        }
        map.put("success",flag);
        return map;
    }
}

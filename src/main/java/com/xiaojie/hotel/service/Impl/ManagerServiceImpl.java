package com.xiaojie.hotel.service.Impl;

import com.xiaojie.hotel.dao.ManagerDao;
import com.xiaojie.hotel.domian.Manager;
import com.xiaojie.hotel.service.ManagerService;

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
}

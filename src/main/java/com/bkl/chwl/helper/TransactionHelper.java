package com.bkl.chwl.helper;

import com.bkl.chwl.entity.User;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;

public class TransactionHelper {

	public static void loadTransaction(String account) {
		GeneralDao<User> userDao = DaoFactory.createGeneralDao(User.class);
		User user = userDao.find("email", account);

		if (user != null) {
		}
	}
}

package com.bkl.chwl.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


public class ServicesListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent context) {
		// TODO Auto-generated method stub

	}

	@Override
	public void contextInitialized(ServletContextEvent context) {
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


}

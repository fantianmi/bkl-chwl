package com.bkl.chwl.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.bkl.chwl.entity.Bill;
import com.bkl.chwl.entity.BillDetail;
import com.bkl.chwl.entity.Cash;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.service.UserBillService;
import com.bkl.chwl.utils.DoubleUtil;
import com.bkl.chwl.utils.FrontUtil;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.utils.TimeUtil;
import com.km.common.vo.Condition;

public class UserBillServiceImpl implements UserBillService {
	GeneralDao<Bill> billDao = DaoFactory.createGeneralDao(Bill.class);
	
	public UserBillServiceImpl() {
		billDao = DaoFactory.createGeneralDao(Bill.class);
	}
	
	public UserBillServiceImpl(Connection conn) {
		billDao = DaoFactory.createGeneralDao(Bill.class,conn);
	}
	
	private Bill getBillFromUserInfo(User user) {
		Bill bill = new Bill();
		bill.setUser_id(user.getId());
		bill.setBtc_amount(0);
		//bill.setBtc_account(DoubleUtil.add(user.getBtc(),user.getBtc_frozen()));
		
		bill.setRmb_account(0);
//		bill.setRmb_account(DoubleUtil.add(user.getRmb(),user.getRmb_frozen()));
		
		bill.setCtime((int)TimeUtil.getUnixTime());
		return bill;
	}
	
	
	public long doRecharge(Cash cash,User user) {
		Bill bill = getBillFromUserInfo(user);
		bill.setType(Bill.TYPE_RMB_RECHARGE_CONFIRM);
		
		bill.setRmb_amount(cash.getAmount());
		return billDao.save(bill);
	}

	public long doWithdraw(Cash cash,User user) {
		Bill bill = getBillFromUserInfo(user);
		bill.setType(Bill.TYPE_RMB_WITHDRAW_CONFIRM);
		bill.setRmb_amount(-cash.getAmount());
		return billDao.save(bill);
	}
	
	@Override
	public long doRecommendPaid(User paidUser, double btcAmount) {
		Bill bill = getBillFromUserInfo(paidUser);
		bill.setType(BillDetail.TYPE_BTC_RECOMMED);
		bill.setBtc_amount(btcAmount);
		return billDao.save(bill);
	}
	
	public void adjustUserMoneyByExtraCoin(double totalBtcExtra, double totalRmb) {
		String sql = "insert into bill (type,ctime,user_id,btc_amount,rmb_amount,btc_account,rmb_account) select %s,UNIX_TIMESTAMP(),id,0,btc_extra*%s/%s,btc,rmb from user";
		sql = String.format(sql, Bill.TYPE_ADJUST_RMB_BY_BTCEXTRA,FrontUtil.formatDouble(totalRmb), FrontUtil.formatDouble(totalBtcExtra));
		
		billDao.exec(sql);
	}
	
}

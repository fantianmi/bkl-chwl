package com.bkl.chwl.service.impl;

import java.sql.Connection;

import com.bkl.chwl.entity.BillDetail;
import com.bkl.chwl.entity.Cash;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.service.SystemBillService;
import com.bkl.chwl.utils.DoubleUtil;
import com.bkl.chwl.utils.FrontUtil;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.TimeUtil;

public class SystemBillServiceImpl implements SystemBillService {
	GeneralDao<BillDetail> billDetailDao = null;
	
	public SystemBillServiceImpl() {
		billDetailDao = DaoFactory.createGeneralDao(BillDetail.class);
	}
	
	public SystemBillServiceImpl(Connection conn) {
		billDetailDao = DaoFactory.createGeneralDao(BillDetail.class,conn);
	}

	public long doRecharge(Cash cash,User user) {
		BillDetail bill = getBillDetailFromUserInfo(user);
		bill.setType(BillDetail.TYPE_RMB_RECHARGE_CONFIRM);
		bill.setTypestring("人民币充值");
		
		bill.setRmb_amount(cash.getAmount());
		bill.setRefid(cash.getId());
		return billDetailDao.save(bill);
	}
	
	private BillDetail getBillDetailFromUserInfo(User user) {
		BillDetail bill = new BillDetail();
		bill.setUser_id(user.getId());
		bill.setBtc_amount(0);
		//bill.setBtc_account(user.getBtc());
		//bill.setBtc_frozen_account(user.getBtc_frozen());
		
		bill.setRmb_account(0);
//		bill.setRmb_account(user.getRmb());
//		bill.setRmb_frozen_account(user.getRmb_frozen());
		
		bill.setCtime((int)TimeUtil.getUnixTime());
		return bill;
	}
	
	public long saveWithdraw(Cash cash,User user) {
		BillDetail bill = getBillDetailFromUserInfo(user);
		bill.setType(BillDetail.TYPE_RMB_WITHDRAW_SAVE);
		bill.setTypestring("人民币提现保存");
//		bill.setRmb_amount(-cash.getAmount());
//		bill.setRmb_frozen_amount(cash.getAmount());
		return billDetailDao.save(bill);
	}
	
	public long doWithdraw(Cash cash,User user) {
		BillDetail bill = getBillDetailFromUserInfo(user);
		bill.setType(BillDetail.TYPE_RMB_WITHDRAW_CONFIRM);
		bill.setTypestring("人民币取现确认");
		bill.setRmb_frozen_amount(-cash.getAmount());
		bill.setRefid(cash.getId());
		return billDetailDao.save(bill);
	}
	
	
	public long cancelWithdraw(Cash cash,User user) {
		BillDetail bill = getBillDetailFromUserInfo(user);
		bill.setType(BillDetail.TYPE_RMB_WITHDRAW_CANCEL);
		bill.setTypestring("人民币取现取消");
		bill.setRmb_amount(cash.getAmount());
		bill.setRmb_frozen_amount(-cash.getAmount());
		bill.setRefid(cash.getId());
		return billDetailDao.save(bill);
	}
	

	@Override
	public long doRecommendPaid(User paidUser, double btcAmount) {
		BillDetail buybill = getBillDetailFromUserInfo(paidUser);
		buybill.setTypestring("推荐用户奖励");
		buybill.setBtc_amount(btcAmount);
		return billDetailDao.save(buybill);
	}
	
	public void adjustUserMoneyByExtraCoin(double totalBtcExtra, double totalRmb) {
		String sql = "insert into billdetail (type,typestring,ctime,user_id,rmb_amount,rmb_frozen_amount,btc_amount,btc_frozen_amount,rmb_account,rmb_frozen_account,btc_account,btc_frozen_account) select %s,'人民币分红',UNIX_TIMESTAMP(),id,btc_extra*%s/%s,0,0,0,rmb,rmb_frozen,btc,btc_frozen from user";
		sql = String.format(sql, BillDetail.TYPE_ADJUST_RMB_BY_BTCEXTRA,FrontUtil.formatDouble(totalRmb), FrontUtil.formatDouble(totalBtcExtra));
		
		billDetailDao.exec(sql);
	}

}

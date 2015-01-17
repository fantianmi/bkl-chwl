package com.bkl.chwl.service;

import java.util.List;

import com.bkl.chwl.entity.Bill;
import com.bkl.chwl.entity.Cash;
import com.bkl.chwl.entity.User;
import com.km.common.vo.RetCode;

public interface UserBillService {
	/**
	 * 查询用户账单列表
	 * @param user_id
	 * @param billType 0表示全部账单 1表示人民币充值，2表示人民币取现，3表示BTC充值，4表示BTC取现，5表示BTC买入，6表示BTC卖出,7表示人民币分红
	 * @return
	 * @throws Exception
	 */
	public long doRecharge(Cash cash,User user);
	
	public long doWithdraw(Cash cash,User user);
	
	
	long doRecommendPaid(User paidUser, double btcAmount);
	
	void adjustUserMoneyByExtraCoin(double totalBtcExtra, double totalRmb);
}

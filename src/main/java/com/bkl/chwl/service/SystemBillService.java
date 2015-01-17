package com.bkl.chwl.service;

import com.bkl.chwl.entity.Cash;
import com.bkl.chwl.entity.User;

public interface SystemBillService {

	public long doRecharge(Cash cash,User user);
	
	public long saveWithdraw(Cash cash,User user);
	public long doWithdraw(Cash cash,User user);
	public long cancelWithdraw(Cash cash,User user);
	
	long doRecommendPaid(User paidUser, double btcAmount);
	void adjustUserMoneyByExtraCoin(double totalBtcExtra, double totalRmb);
	
}

package com.bkl.chwl.task;

import java.sql.Connection;

import com.bkl.chwl.MainConfig;
import com.bkl.chwl.entity.Bill;
import com.bkl.chwl.entity.BillDetail;
import com.bkl.chwl.entity.RecommendDetail;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.service.RecommendDetailService;
import com.bkl.chwl.service.SystemBillService;
import com.bkl.chwl.service.UserBillService;
import com.bkl.chwl.service.impl.RecommendDetailServiceImpl;
import com.bkl.chwl.service.impl.SystemBillServiceImpl;
import com.bkl.chwl.service.impl.UserBillServiceImpl;
import com.bkl.chwl.utils.DoubleUtil;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;

/**
 * @author chaozheng
 * 
 */
public class PayRecommendTask implements Runnable {

	private final int userId;

	public PayRecommendTask(int userId) {
		this.userId = userId;
	}

	@Override
	public void run() {
		Connection conn = DaoFactory.createConnection();
		GeneralDao<RecommendDetail> rdDao = DaoFactory.createGeneralDao(
				RecommendDetail.class, conn);
		GeneralDao<User> userDao = DaoFactory
				.createGeneralDao(User.class, conn);
		UserBillService userBillServ = new UserBillServiceImpl(conn);
		SystemBillService systemBillServ = new SystemBillServiceImpl(conn);
		RecommendDetailService rdSrv = new RecommendDetailServiceImpl(conn);
		RecommendDetail rd = rdSrv.getRecommendDetail(userId);

		rdDao.beginTransaction();
		rdDao.lockTable(rdDao.getTableName(RecommendDetail.class),
				rdDao.getTableName(User.class), rdDao.getTableName(Bill.class),
				rdDao.getTableName(BillDetail.class));
		try {
			if (rd == null || rd.getStatus() != 0) {
				return;
			}
			double btcAmount = MainConfig.getRecommendedPaidAmout();
			double btcPaidUserLimit = MainConfig.getRecommendedPaidUserLimit();
			int paidNum = rdSrv.countPaidRecommend(rd.getRecommended_id());
			if (btcPaidUserLimit != -1 && (paidNum + 1) * btcAmount > btcPaidUserLimit) {
				return;
			}
			// 推荐人
			User recommendUser = userDao.find(rd.getRecommended_id());
			if (recommendUser != null) {

				// 更新推荐信息状态
				rd.setStatus(1);
				rd.setBtc_amount(btcAmount);
				rdDao.update(rd);

				// 增加推荐费
				// 记录帐单
				userBillServ.doRecommendPaid(recommendUser, btcAmount);
				systemBillServ.doRecommendPaid(recommendUser, btcAmount);

			}

			rdDao.unLockTable();
			rdDao.commit();
		} catch (Exception e) {
			e.fillInStackTrace();
			rdDao.rollback();
		} finally {
			DaoFactory.closeConnection(conn);
		}
	}

}

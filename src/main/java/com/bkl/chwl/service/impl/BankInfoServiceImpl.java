package com.bkl.chwl.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

import com.bkl.chwl.entity.Area;
import com.bkl.chwl.entity.BankInfo;
import com.bkl.chwl.service.BankInfoService;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.vo.Condition;

public class BankInfoServiceImpl implements BankInfoService {
	GeneralDao<BankInfo> bankDao=DaoFactory.createGeneralDao(BankInfo.class);

	@Override
	public Map<String, BankInfo> getBankInfoMap() {
		Map map=new HashMap<String, BankInfo>();
		List<BankInfo> banks=bankDao.findList();
		for(BankInfo b:banks){
			map.put(b.getBankName(), b);
		}
		return map;
	}

	@Override
	public BankInfo getByBankName(String bankName) {
		Condition bankNameCon=DbUtil.generalEqualWhere("bankName", bankName);
		return bankDao.find(new Condition[]{bankNameCon}, new String[]{});
	}

}

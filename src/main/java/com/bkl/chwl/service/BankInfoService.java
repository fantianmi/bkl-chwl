package com.bkl.chwl.service;

import java.util.List;
import java.util.Map;

import com.bkl.chwl.entity.Area;
import com.bkl.chwl.entity.BankInfo;

public interface BankInfoService {
	public Map<String,BankInfo> getBankInfoMap();
	public BankInfo getByBankName(String bankName);
}

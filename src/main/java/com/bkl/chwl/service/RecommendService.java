package com.bkl.chwl.service;

import java.util.List;
import java.util.Map;

import com.bkl.chwl.vo.Fans;

public interface RecommendService {
	//获得商家总盈利数
	public Map<Integer,Fans> getShopFansProfileMap(List<com.baiyi.data.model.User2> users);
}

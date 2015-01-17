package com.bkl.chwl.service;

import java.util.Map;

import com.bkl.chwl.entity.Proxy2User;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;

public interface ProxyService {
	public PageReply<Proxy2User> getProxyList(Map searchMap,Page page);
	public PageReply<Proxy2User> getProxyListProvince(Map searchMap,Page page);
	
	/**
	 * 设置代理
	 * @param uid
	 * @param local
	 * @param local2
	 * @param type
	 * @param ruid 推荐人id
	 * @return
	 */
	public boolean setProxy(long uid,int local,int local2,int type,long ruid);
}

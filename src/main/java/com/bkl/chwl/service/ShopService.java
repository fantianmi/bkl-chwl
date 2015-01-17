package com.bkl.chwl.service;

import java.util.List;
import java.util.Map;

import com.bkl.chwl.entity.Shop;
import com.bkl.chwl.entity.Shop2Collect;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;


public interface ShopService {
	public long save(Shop shop);
	public long update(Shop shop,long id);
	//need update
	public List<Shop> getList(long reid);
	public List<Shop> getList(int local,int local2,int local3,int type,int type2,int sort);
	public Shop get(long id);
	public Shop getByUid(long uid);
	public long delete(long id);
	public PageReply<Shop> getListPage(int local,int local2,int local3,int type,int type2,int sort,Map searchMap, Page page);
	public int countLike(long sid);
	public int countCollect(long sid);
	public void addLike(long uid,long sid);
	public void addSellNun(long uid);
	public void addCollection(long uid,long sid);
	public boolean isLike(long uid,long sid);
	public boolean isCollect(long uid,long sid);
	public List<Shop2Collect> getCollectList(long uid);
	/**
	 * 获得销售总额
	 * @param uid
	 * @return
	 */
	public double getProfileTotal(long uid,int staticsType);
}

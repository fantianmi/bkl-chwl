package com.bkl.chwl.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.bkl.chwl.entity.Shop;
import com.bkl.chwl.entity.Shop2Collect;
import com.bkl.chwl.entity.ShopCollect;
import com.bkl.chwl.entity.ShopLike;
import com.bkl.chwl.entity.Tradeorder;
import com.bkl.chwl.service.ShopService;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.utils.TimeUtil;
import com.km.common.vo.Condition;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;

public class ShopServiceImpl implements ShopService {
	GeneralDao<Shop> ShopDao=DaoFactory.createGeneralDao(Shop.class);
	@Override
	public long save(Shop Shop) {
		return ShopDao.save(Shop);
	}

	@Override
	public long update(Shop Shop, long id) {
		return ShopDao.update(Shop,id);
	}

	@Override
	public List<Shop> getList(long reid) {
		Condition reidCon=DbUtil.generalEqualWhere("reid", reid);
		return ShopDao.findList(new Condition[]{reidCon}, new String[]{"title desc"});
	}

	@Override
	public Shop get(long id) {
		return ShopDao.find(id);
	}

	@Override
	public long delete(long id) {
		return ShopDao.delete(id);
	}

	@Override
	public List<Shop> getList(int local, int local2, int local3, int type,
			int type2, int sort) {
		Condition[] conditions={};
		if(local!=0){
			Condition localCon=DbUtil.generalEqualWhere("local", local);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=localCon;
		}
		if(local2!=0){
			Condition local2Con=DbUtil.generalEqualWhere("local2", local2);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=local2Con;
		}
		if(local3!=0){
			Condition local3Con=DbUtil.generalEqualWhere("local3", local3);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=local3Con;
		}
		if(type!=0){
			Condition typeCon=DbUtil.generalEqualWhere("shop_type", type);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=typeCon;
		}
		if(type2!=0){
			Condition type2Con=DbUtil.generalEqualWhere("shop_type2", type2);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=type2Con;
		}
		
		Condition localCon=DbUtil.generalEqualWhere("local", local);
		conditions=Arrays.copyOf(conditions, conditions.length+1);
		conditions[conditions.length-1]=localCon;
		String sorts="";
		if(sort==Shop.SORT_TIME){
			sorts="id desc";
		}else if(sort==Shop.SORT_HOT){
			sorts="shop_like desc";
		}else{
			sorts="shop_sellnum desc";
		}
		return ShopDao.findList(conditions, new String[]{sorts});
	}

	@Override
	public Shop getByUid(long uid) {
		Condition uidCon=DbUtil.generalEqualWhere("uid", uid);
		return ShopDao.find(new Condition[]{uidCon}, new String[]{});
	}

	@Override
	public PageReply<Shop> getListPage(int local, int local2, int local3,
			int type, int type2, int sort, Map searchMap, Page page) {
		Condition[] conditions={};
		if(local!=0){
			Condition localCon=DbUtil.generalEqualWhere("local", local);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=localCon;
		}
		if(local2!=0){
			Condition local2Con=DbUtil.generalEqualWhere("local2", local2);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=local2Con;
		}
		if(local3!=0){
			Condition local3Con=DbUtil.generalEqualWhere("local3", local3);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=local3Con;
		}
		if(type!=0){
			Condition typeCon=DbUtil.generalEqualWhere("shop_type", type);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=typeCon;
		}
		if(type2!=0){
			Condition type2Con=DbUtil.generalEqualWhere("shop_type2", type2);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=type2Con;
		}
		
		String sorts="";
		if(sort==Shop.SORT_TIME){
			sorts="id desc";
		}else if(sort==Shop.SORT_HOT){
			sorts="shop_like desc";
		}else if(sort==Shop.SORT_SELLNUM){
			sorts="shop_sellnum desc";
		}else if(sort==Shop.SORT_DEFAULT){
			sorts=null;
		}else if(sort==Shop.SORT_PRICE){
			sorts="price asc";
		}else if(sort==Shop.SORT_DISCOUNT){
			sorts="coinRate desc";
		}
		return ShopDao.getPage(page, conditions, new String[]{sorts}, searchMap);
	}
	public boolean isLike(long uid,long sid){
		GeneralDao<ShopLike> shopLikeDao=DaoFactory.createGeneralDao(ShopLike.class);
		Condition sidCon=DbUtil.generalEqualWhere("sid", sid);
		Condition uidCon=DbUtil.generalEqualWhere("uid", uid);
		ShopLike shopLike=shopLikeDao.find(new Condition[]{sidCon,uidCon},new String[]{});
		if(shopLike!=null) return true;
		return false;
	}
	public boolean isCollect(long uid,long sid){
		GeneralDao<ShopCollect> shopCollectDao=DaoFactory.createGeneralDao(ShopCollect.class);
		Condition sidCon=DbUtil.generalEqualWhere("sid", sid);
		Condition uidCon=DbUtil.generalEqualWhere("uid", uid);
		ShopCollect shopCollect=shopCollectDao.find(new Condition[]{sidCon,uidCon},new String[]{});
		if(shopCollect!=null) return true;
		return false;
	}
	
	public void addLike(long uid,long sid) {
		if(isLike(uid,sid)) return;
		Condition sidCon=DbUtil.generalEqualWhere("id", sid);
		Shop s=ShopDao.find(new Condition[]{sidCon},new String[]{});
		if(s!=null){
			s.setShop_like(s.getShop_like()+1);
			ShopDao.save(s);
			ShopLike sl=new ShopLike(uid,sid);
			GeneralDao<ShopLike> shopLikeDao=DaoFactory.createGeneralDao(ShopLike.class);
			shopLikeDao.save(sl);
		}
	}
	

	public void addSellNun(long uid) {
		Condition uidCon=DbUtil.generalEqualWhere("uid", uid);
		Shop s=ShopDao.find(new Condition[]{uidCon},new String[]{});
		if(s!=null){
			s.setShop_sellnum(s.getShop_sellnum()+1);
			ShopDao.save(s);
		}
	}

	public int countLike(long sid) {
		GeneralDao<ShopLike> shopLikeDao=DaoFactory.createGeneralDao(ShopLike.class);
		String sql="select count(*) from shoplike where sid="+sid;
		return shopLikeDao.queryIngeger(sql, null);
	}

	public int countCollect(long sid) {
		GeneralDao<ShopCollect> shopCollectDao=DaoFactory.createGeneralDao(ShopCollect.class);
		String sql="select count(*) from shoplike where sid="+sid;
		return shopCollectDao.queryIngeger(sql, null);
	}
	public void addCollection(long uid, long sid) {
		if(isCollect(uid,sid)) return;
		Condition sidCon=DbUtil.generalEqualWhere("id", sid);
		Shop s=ShopDao.find(new Condition[]{sidCon},new String[]{});
		if(s!=null){
			s.setShop_collect(s.getShop_collect()+1);
			ShopDao.save(s);
			ShopCollect sc=new ShopCollect(uid,sid);
			GeneralDao<ShopCollect> shopCollectDao=DaoFactory.createGeneralDao(ShopCollect.class);
			shopCollectDao.save(sc);
		}
	}

	@Override
	public List<Shop2Collect> getCollectList(long uid) {
		GeneralDao<Shop2Collect> shop2collectDao=DaoFactory.createGeneralDao(Shop2Collect.class);
		String sql="select s.*,c.id as collect_id,c.uid as collect_uid,c.sid as collect_sid from shopcollect c left join shop s on c.sid=s.id where c.uid="+uid+" order by c.id desc";
		return shop2collectDao.findList(sql, null);
	}

	@Override
	public double getProfileTotal(long uid,int staticsType) {
		GeneralDao<Tradeorder> orderDao=DaoFactory.createGeneralDao(Tradeorder.class);
		String sql="select sum(price) from tradeorder where seller="+uid+" and status="+Tradeorder.STATUS_SUCCESS;
		long now=TimeUtil.getUnixTime();
		long day=now-(60*60*24);
		long month=now-(60*60*24*30);
		long month3=now-(60*60*24*90);
		if(staticsType==Tradeorder.STATICS_ALL){
			
		}else if(staticsType==Tradeorder.STATICS_DAY){
			sql+=" and stime>"+day;
		}else if(staticsType==Tradeorder.STATICS_MONTH){
			sql+=" and stime>"+month;
		}else if(staticsType==Tradeorder.STATICS_3MONTH){
			sql+=" and stime>"+month3;
		}
		return orderDao.queryDouble(sql, null);
	}
}

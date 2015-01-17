package com.bkl.chwl.utils;

import org.junit.Test;
import org.mortbay.log.Log;

import com.baiyi.data.model.ProxyUser;
import com.baiyi.domain.AddCoinEntity;
import com.baiyi.domain.BounsEntity;
import com.baiyi.domain.CoinLogEntity;
import com.baiyi.domain.LotteryEntity;
import com.baiyi.domain.OrderLogEntity;
import com.baiyi.domain.UserInfoEntity;
import com.bkl.chwl.MainConfig;
import com.bkl.chwl.vo.SellLogEntity;
import com.bkl.chwl.vo.UserListEntity;
import com.bkl.chwl.vo.UserProfile;
import com.bkl.chwl.vo.WebApi;
import com.km.common.vo.Page;

public class ApiCommon {
	private String serverUrl="http://123.57.67.98:8081";
	private String authKey="test";
	private String authPass="test";
	
	public static double getUserCoin(long uid) throws Exception{
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		UserInfoEntity info=WebApi.getUser((int)uid);
		return info.getCoin().doubleValue();
	}
	
	public static UserInfoEntity getUserInfo(long uid){
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		try{
			UserInfoEntity info=WebApi.getUser((int)uid);
			return info;
		}catch(Exception e){
			Log.info("remote server connect time out");
			return null;
		}
	}
	
	public static UserProfile getUserProfile(long uid){
		UserProfile profile=new UserProfile();
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		try{
			UserInfoEntity info=WebApi.getUser((int)uid);
			profile.setCoin(info.getCoin().doubleValue());
			profile.setBigbouns(info.getBigBouns().size());
			profile.setMediumbouns(info.getMiddelBouns().size());
			profile.setSmallbouns(info.getSmallBouns().size());
			profile.setLottoTime(info.getLotteryTime());
			return profile;
		}catch(Exception e){
			Log.info("query remote userinfo data error, uid="+uid);
			return null;
		}
	}
	
	public static boolean translate(long fromUid, long toUid, int coin){
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		try{
			WebApi.translate((int)fromUid, (int)toUid, coin);
			return true;
		}catch(Exception e){
			return false;
		}
	}
	
	public static boolean createOrder(long fromUid, long toUid, int coin,String orderId,int type){
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		try{
			WebApi.order((int)fromUid, type, coin, (int)toUid, orderId);
			return true;
		}catch(Exception e){
			return false;
		}
	}
	//pagenum begin with 0
	public static UserListEntity getRecommendUserList(long uid,int pagenum,int type,int pagesize) throws Exception{
		pagenum=(pagenum-1)*pagesize;
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		UserListEntity users=WebApi.getRecommendUserList((int)uid, pagenum, type, pagesize);
		return users;
	}
	public static BounsEntity openBouns(int type,int id) throws Exception{
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		return WebApi.openBouns(type, id);
	}
	
	public static SellLogEntity getSellLog(long uid,Page page) throws Exception{
		int pageNow=0;
		int pageSize=20;
		if(page!=null){
			pageNow=(page.getPagenum()-1)*page.getPagesize();
			pageSize=page.getPagesize();
		}
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		return WebApi.getSellLog((int)uid, pageNow, pageSize);
	}
	
	public static LotteryEntity doLotto(long uid) throws Exception{
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		return WebApi.doLottery((int)uid);
	}
	
	@Test
	public void doLottery() throws Exception{
		long uid=1002l;
		this.doLotto(uid);
	}
	
	public static boolean withDraw(long uid,double coin){
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		try{
			WebApi.withDraw((int)uid,(int)coin);
			return true;
		}catch(Exception e){
			return false;
		}
	}
	
	public static boolean setProxy(long uid,int local,int local2,int type,long ruid){
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		try{
			WebApi.setProxy((int)uid, local, local2,type,(int)ruid);
			return true;
		}catch(Exception e){
			return false;
		}
	}
	
	
	@Test
	public void UserRegTest() throws Exception{
		WebApi.init(serverUrl, authKey, authPass);
		WebApi.register(10024, "18688164056", 10003, 1, 1, 1);
	}
	@Test
	public void LotteryEntityTest() throws Exception{
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		LotteryEntity l =WebApi.doLottery(10003);
	}
	@Test
	public void getProxyUserTest() throws Exception{
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		ProxyUser[] u =WebApi.getAllProxy();
	}
	@Test
	public void getCoinTest() throws Exception{
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		double amount=WebApi.getCoin(10003);
		System.out.println("yu e wei:"+amount);
	}
	@Test 
	public void getCoinLogTEST() throws Exception{
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		CoinLogEntity cle=WebApi.getCoinLog(10003, 0, 100);
	}
	@Test 
	public void getOrderLogTEST() throws Exception{
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		OrderLogEntity ole=WebApi.getOrderLog(10003, 0, 100);
	}
	@Test 
	public void getRecommendUserListTEST() throws Exception{
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		UserListEntity users=WebApi.getRecommendUserList(1002, 0, 2, 100);
	}
	@Test 
	public void getSellLogTEST() throws Exception{
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		SellLogEntity sl=WebApi.getSellLog(10008,0, 100);
	}
	@Test 
	public void getProxyTEST() throws Exception{
		WebApi.init(MainConfig.dxwServerURL(), MainConfig.dxwAuthKey(), MainConfig.dxwAuthPass());
		ProxyUser[] users = WebApi.getAllProxy();
	}
	
}

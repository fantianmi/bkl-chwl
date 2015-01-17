package com.bkl.chwl;

import com.km.common.config.Config;

public class MainConfig {
	private static String  version;
	private static  boolean isCnVersion;
	private static  boolean enableEmailActive;
	
	
	private static double recommendedPaidAmout;
	private static double cashMinRechargeAmount;
	private static double cashMinWithdrawAmount;
	private static double recommendedPaidUserLimit;
	private static double recommendedPaidTotalLimit;
	private static String frontSimpleName;
	
	private static int cashAmountMinDecimalPrecision = 2;
	
	private static String dxwServerURL;
	private static String dxwAuthKey;
	private static String dxwAuthPass;
	private static int defaultProvinceId;
	private static String contextPath;
	private static String wechatappid;
	private static String wechatappsecret;
	private static String wechaturl;
	
	static {
		try {
			flush();
			startService();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void startService() throws Exception {
		
	}
	
	private static void flush() {
		isCnVersion = "cn".equals(Config.getString("config.product.ver"));
		enableEmailActive = Boolean.parseBoolean(Config.getString("config.email.active.enable")); 
		frontSimpleName = Config.getString("config.front.simple.name");
		
		cashMinRechargeAmount = Config.getDouble("cash.minimum.recharge.amount");
		
		recommendedPaidAmout = Config.getDouble("coin.recommended.paid.amount");
		recommendedPaidUserLimit = Config.getDouble("coin.recommended.paid.user.amount.limit");
		recommendedPaidTotalLimit = Config.getDouble("coin.recommended.paid.total.amount.limit");
		
		cashMinWithdrawAmount = Config.getDouble("cash.minimum.withdraw.amount");
		cashAmountMinDecimalPrecision = Config.getInt("cash.amount.decimal.precision.number");
		version = Config.getString("config.system.version");
		dxwServerURL=Config.getString("dxw.serverUrl");
		dxwAuthKey=Config.getString("dxw.authKey");
		dxwAuthPass=Config.getString("dxw.authPass");
		defaultProvinceId=Config.getInt("default.province.id");
		contextPath=Config.getString("config.context.path");
		wechaturl=Config.getString("wechat.url");
		wechatappid=Config.getString("wechat.appid");
		wechatappsecret=Config.getString("wechat.appsecret");
	}
	
	public static String getFrontSimpleName() {
		return frontSimpleName;
	}
	
	public static boolean isCnVersion() {
		return isCnVersion;
	}
	public static boolean enableEmailActive() {
		return enableEmailActive;
	}
	
	public static double getCashMinRechargeAmount() {
		return cashMinRechargeAmount;
	}
	public static double getRecommendedPaidAmout() {
		return recommendedPaidAmout;
	}
	public static double getCashMinWithdrawAmount() {
		return cashMinWithdrawAmount;
	}
	public static double getRecommendedPaidUserLimit() {
		return recommendedPaidUserLimit;
	}
	public static int getCashAmountMinDecimalPrecision() {
		return cashAmountMinDecimalPrecision;
	}
	public static String dxwServerURL() {
		return dxwServerURL;
	}
	public static String dxwAuthKey() {
		return dxwAuthKey;
	}
	public static String dxwAuthPass() {
		return dxwAuthPass;
	}
	public static int defaultProvinceId() {
		return defaultProvinceId;
	}
	public static String getContextPath() {
		return contextPath;
	}
	public static String getWechaturl() {
		return wechaturl;
	}
	public static String getWechatappid() {
		return wechatappid;
	}
	public static String getWechatappsecret() {
		return wechatappsecret;
	}
}

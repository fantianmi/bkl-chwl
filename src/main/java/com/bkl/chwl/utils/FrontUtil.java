package com.bkl.chwl.utils;


import com.bkl.chwl.entity.Cash;

public class FrontUtil {
	public static void main(String[] args) {
		System.out.println(formatDouble(0.0001));
	}
	public static String formatDouble(double value) {
		///java.text.DecimalFormat df = new java.text.DecimalFormat("0.00");
		//return df.format(value);
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();   
		//nf.setMaximumintDigits(10);
		nf.setMaximumFractionDigits(100);
		nf.setGroupingUsed(false);  
		return nf.format(value);
	}
	
	public static String formatRmbDouble(double value) {
		java.text.DecimalFormat df = new java.text.DecimalFormat("0.0");
		return addComma(df.format(value));
	}
	
	public static String formatCoinPriceDouble(double value) {
		java.text.DecimalFormat df = new java.text.DecimalFormat("0.0000");
		return addComma(df.format(value));
	}
	
	public static String formatCoinAmountDouble(double value) {
		java.text.DecimalFormat df = new java.text.DecimalFormat("0");
		return addComma(df.format(value));
	}
	
	public static String addComma(String str){  
	    boolean neg = false;  
	    if (str.startsWith("-")){  //处理负数  
	        str = str.substring(1);  
	        neg = true;  
	    }  
	    String tail = null;  
	    if (str.indexOf('.') != -1){ //处理小数点  
	        tail = str.substring(str.indexOf('.'));  
	        str = str.substring(0, str.indexOf('.'));  
	    }  
	    StringBuilder sb = new StringBuilder(str);  
	    sb.reverse();  
	    for (int i = 3; i < sb.length(); i += 4){  
	        sb.insert(i, ',');  
	    }  
	    sb.reverse();  
	    if (neg){  
	        sb.insert(0, '-');  
	    }  
	    if (tail != null){  
	        sb.append(tail);  
	    }  
	    return sb.toString();  
	}  
	
	//隐藏银行卡以及身份证信息
	public static String hiddenNum(String num){
		int length=num.length();
		String start=num.substring(0,length/4);
		String end=num.substring(length/4*3,length);
		return start+"******"+end;
	}
	
	public static String getCashStatusString(Cash cash) {
		int status = cash.getStatus();
		int type = cash.getType();
		if (status == Cash.STATUS_UNCONFIRM) {
			return "尚未支付";
		}
		if (type == Cash.TYPE_RMB_RECHARGE) {
			if (status == Cash.STATUS_CONFIRM) {
				return "支付成功";
			} else {
				return "取消支付";
			}
		} else {
			if (status == Cash.STATUS_CONFIRM) {
				return "取现成功";
			} else {
				return "取消取现";
			}
		}
	}
	
}

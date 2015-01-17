package com.bkl.chwl.utils;

public class StringUtil {
	public static String subString(String stringValue,int length){
		if(stringValue==null){
			return "未知";
		}
		if(stringValue.length()<=length){
			return stringValue;
		}else{
			return stringValue.substring(0, length);
		}
	}
	public static String doubleToRate(double doubleValue){
		double temp=doubleValue*100;
		return String.valueOf(temp)+"%";
	}
	//返利的特殊显示 立省=（(商家设置返利数*40)/100）%
	public static String payBackDoubleToRate(double doubleValue){
		double temp=doubleValue*40/100*100;
		return String.valueOf(temp)+"%";
	}
	public static String clearAllWhiteSpace(String str) {
		if (str == null) {
			return null;
		}
		str = str.replace(" ", "");
		str = str.replace("\t", "");
		return str;
	}
}

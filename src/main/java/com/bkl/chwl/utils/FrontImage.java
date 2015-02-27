package com.bkl.chwl.utils;

import com.bkl.chwl.MainConfig;
import com.km.common.config.Config;

public class FrontImage {
	private static String ossbaseUrl=MainConfig.getOssBaseurl();
	public static String convertOss(String image){
		if(Config.getInt("oss.status")==1){
			if(image.equals("")||image==null){
				return ossbaseUrl+"default.jpg";
			}else{
				return ossbaseUrl+image.substring(8);
			}
		}else{
			if(image.equals("")||image==null){
				return "uploads/default.jpg";
			}else{
				return image;
			}
			
		}
	}
	public static void main(String args[]){
		String adr="uploads/b8d701e5-4025-402f-ae20-fd5a80793eb8.jpg";
		System.out.println(convertOss(adr));
		/*String adr2=null;
		System.out.println(convertOss(adr2));*/
		String adr3="";
		System.out.println(convertOss(adr3));
	}
}

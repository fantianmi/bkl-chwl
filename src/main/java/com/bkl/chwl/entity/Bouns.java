package com.bkl.chwl.entity;

public class Bouns {
	public static String convertStatus(int status){
		if(status==0) return "未填满";
		if(status==1) return "已填满";
		if(status==2) return "已领取";
		return "未知";
	}
	public static String convertStatusHTML(int status,int id,int type){
		if(status==0) return "<button onclick='openbouns(this,"+id+","+type+")' disabled='disabled' class='btn btn-danger btn-xs' style='disable'>未填满</button>";
		if(status==1) return "<button onclick='openbouns(this,"+id+","+type+")' class='btn btn-danger btn-xs'>领取</button>";
		if(status==2) return "<button onclick='openbouns(this,"+id+","+type+")' disabled='disabled' class='btn btn-danger btn-xs'>已领取</button>";
		return "<button onclick='openbouns()' disabled='disabled' class='btn btn-danger btn-xs' style='disable'>未填满</button>";
	}

}

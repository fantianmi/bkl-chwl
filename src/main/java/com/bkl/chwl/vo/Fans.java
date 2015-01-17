package com.bkl.chwl.vo;

public class Fans {
	private int total;
	private String resHTML;
	public int getTotal() {
		return total;
	}
	public int otherTotal;
	public void setTotal(int total) {
		this.total = total;
	}
	public String getResHTML() {
		return resHTML;
	}
	public void setResHTML(String resHTML) {
		this.resHTML = resHTML;
	}
	//用户id
	private long uid;
	//共获利
	private double profile;
	//共消费
	private double consume;
	private String totalProfile;
	
	public String getTotalProfile() {
		return totalProfile;
	}
	public void setTotalProfile(String totalProfile) {
		this.totalProfile = totalProfile;
	}
	public long getUid() {
		return uid;
	}
	public void setUid(long uid) {
		this.uid = uid;
	}
	public double getProfile() {
		return profile;
	}
	public void setProfile(double profile) {
		this.profile = profile;
	}
	public double getConsume() {
		return consume;
	}
	public void setConsume(double consume) {
		this.consume = consume;
	}
	public int getOtherTotal() {
		return otherTotal;
	}
	public void setOtherTotal(int otherTotal) {
		this.otherTotal = otherTotal;
	}
	
	
	
	
}

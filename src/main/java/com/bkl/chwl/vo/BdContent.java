package com.bkl.chwl.vo;

public class BdContent {
	private String address;
	private BdAddress_detail address_detail;
	private BdPoint point;
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public BdAddress_detail getAddress_detail() {
		return address_detail;
	}
	public void setAddress_detail(BdAddress_detail address_detail) {
		this.address_detail = address_detail;
	}
	public BdPoint getPoint() {
		return point;
	}
	public void setPoint(BdPoint point) {
		this.point = point;
	}
	
}

package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;

@TableAonn(tableName="version")
public class Version {
	public static final int APK_ANDROID=0;
	public static final int APK_IOS=1;
	private long id;
	private String version;
	private String name;
	private String downloadurl;
	private int apktype=0;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDownloadurl() {
		return downloadurl;
	}
	public void setDownloadurl(String downloadurl) {
		this.downloadurl = downloadurl;
	}
	public String getApktypeString() {
		if(apktype==0) return "android";
		else if(apktype==1) return "ios";
		return "unknow";
	}
	public int getApktype() {
		return apktype;
	}
	public void setApktype(int apktype) {
		this.apktype = apktype;
	}
	

}

package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;

@TableAonn(tableName="area")
public class Area {
	private long id;
	private String title;
	private long reid;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public long getReid() {
		return reid;
	}
	public void setReid(long reid) {
		this.reid = reid;
	}
}

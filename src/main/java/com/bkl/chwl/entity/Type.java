package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;

@TableAonn(tableName="type")
public class Type {
	private long id;
	private String name;
	private long reid;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public long getReid() {
		return reid;
	}
	public void setReid(long reid) {
		this.reid = reid;
	}
}

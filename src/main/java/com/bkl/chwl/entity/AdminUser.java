package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;

@TableAonn(tableName = "admin")
public class AdminUser {
	private int id = 0;
	private String username = "";
	private String password = "";
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
}

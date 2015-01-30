package com.bkl.chwl.entity;

import org.junit.Test;

import com.km.common.dao.TableAonn;

@TableAonn(tableName="comment")
public class Comment {
	private long id;
	private String content;
	private long sid;
	private long uid;
	private long ctime;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public long getSid() {
		return sid;
	}
	public void setSid(long sid) {
		this.sid = sid;
	}
	public long getUid() {
		return uid;
	}
	public void setUid(long uid) {
		this.uid = uid;
	}
	public long getCtime() {
		return ctime;
	}
	public void setCtime(long ctime) {
		this.ctime = ctime;
	}
}

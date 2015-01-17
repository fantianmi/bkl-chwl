package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;

@TableAonn(tableName="weixin")
public class Weixin {
	private long id;
	private String access_token;
	private long access_token_expires;
	
	private String ticket;
	private long ticket_expires;
	private long expires_in;
	
	public long getAccess_token_expires() {
		return access_token_expires;
	}
	public void setAccess_token_expires(long access_token_expires) {
		this.access_token_expires = access_token_expires;
	}
	public long getTicket_expires() {
		return ticket_expires;
	}
	public void setTicket_expires(long ticket_expires) {
		this.ticket_expires = ticket_expires;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getAccess_token() {
		return access_token;
	}
	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}
	public String getTicket() {
		return ticket;
	}
	public void setTicket(String ticket) {
		this.ticket = ticket;
	}
	public long getExpires_in() {
		return expires_in;
	}
	public void setExpires_in(long expires_in) {
		this.expires_in = expires_in;
	}
}

package com.bkl.chwl.service;

import java.util.List;

import com.bkl.chwl.entity.User2BindCard;
import com.bkl.chwl.entity.UserBindCard;

public interface BindCardService {
	//绑定银行卡
	public long addCard(UserBindCard bindcard);
	//根据用户id查询银行卡uid
	public List<UserBindCard> getCards(long uid);
	public List<User2BindCard> getUser2Cards(long uid);
	//
	public UserBindCard getCard(long id);
	public User2BindCard getUser2Card(long id);
	//删除银行卡 uid id
	public long deleteCard(long uid,long id);
	
}

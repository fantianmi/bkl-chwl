package com.bkl.chwl.service;

import java.util.List;

import com.bkl.chwl.entity.User2BindCard;
import com.bkl.chwl.entity.UserBindCard;

public interface BindCardService {
	//绑定银行卡
	public long addCard(UserBindCard bindcard);
	//根据用户id查询银行卡uid
	public List<UserBindCard> getCards(long uid);
	//判断用户是不是第一次绑卡，即是否有绑定过卡
	public boolean existCard(long uid);
	
	public List<User2BindCard> getUser2Cards(long uid);
	//
	public UserBindCard getCard(long id);
	public User2BindCard getUser2Card(long id);
	//删除银行卡 uid id
	public long deleteCard(long uid,long id);
	/**
	 * 设置默认收款卡
	 * @param id
	 * @param uid
	 * @return
	 */
	public boolean setDefault(long id,long uid);
	/**
	 * 获得默认卡片
	 * @param uid
	 * @return
	 */
	public User2BindCard getDefult(long uid);
	/**
	 * 按照银行卡查询
	 * @param uid
	 * @param bank_account_o
	 * @return
	 */
	public UserBindCard findByBank_account_o(long uid,String bank_account_o);
	/**
	 * 是否存在重复绑卡现象
	 * @param uid
	 * @param bank_account_o
	 * @return
	 */
	public boolean existBank_account_o(long uid,String bank_account_o);
	
}

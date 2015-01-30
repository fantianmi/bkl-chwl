package com.bkl.chwl.service.impl;

import java.util.List;

import com.bkl.chwl.entity.User2BindCard;
import com.bkl.chwl.entity.UserBindCard;
import com.bkl.chwl.service.BindCardService;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.vo.Condition;

public class BindCardServiceImpl implements BindCardService {
	GeneralDao<UserBindCard> bindCardDao=DaoFactory.createGeneralDao(UserBindCard.class);
	
	public long addCard(UserBindCard bindcard) {
		return bindCardDao.save(bindcard);
	}
	public List<UserBindCard> getCards(long uid) {
		Condition uidCon=DbUtil.generalEqualWhere("uid", uid);
		return bindCardDao.findList(new Condition[]{uidCon}, new String[]{"id desc"});
	}

	public UserBindCard getCard(long id) {
		return bindCardDao.find(id);
	}

	public long deleteCard(long uid, long id) {
		Condition uidCon=DbUtil.generalEqualWhere("uid", uid);
		Condition idCon=DbUtil.generalEqualWhere("id", id);
		return bindCardDao.delete(new Condition[]{uidCon,idCon});
	}
	
	public List<User2BindCard> getUser2Cards(long uid) {
		GeneralDao<User2BindCard> user2BindCardDao=DaoFactory.createGeneralDao(User2BindCard.class);
		String sql="select u.*,b.id as bid,b.bank_o,b.bank_account_o,b.bank_deposit_o,b.phone_o,b.isdefault,b.uid,b.bank_number_o from userbindcard b left join user u on b.uid=u.id where b.uid="+uid;
		return user2BindCardDao.findList(sql, null);
	}
	
	public User2BindCard getUser2Card(long id) {
		GeneralDao<User2BindCard> user2BindCardDao=DaoFactory.createGeneralDao(User2BindCard.class);
		String sql="select u.*,b.id as bid,b.bank_o,b.bank_account_o,b.bank_deposit_o,b.phone_o,b.isdefault,b.uid,b.bank_number_o from userbindcard b left join user u on b.uid=u.id where b.id="+id;
		return user2BindCardDao.findSql(sql, null);
	}
	@Override
	public boolean setDefault(long id, long uid) {
		String sql  ="update userbindcard set isdefault="+UserBindCard.DEFAULT_FALSE+" where uid="+uid+" and id!="+id;
		bindCardDao.exec(sql, null);
		String sql2="update userbindcard set isdefault="+UserBindCard.DEFAULT_TRUE+" where uid="+uid+" and id="+id;
		bindCardDao.exec(sql2, null);
		return true;
	}
	@Override
	public User2BindCard getDefult(long uid) {
		GeneralDao<User2BindCard> user2BindCardDao=DaoFactory.createGeneralDao(User2BindCard.class);
		String sql="select u.*,b.id as bid,b.bank_o,b.bank_account_o,b.bank_deposit_o,b.phone_o,b.isdefault,b.uid,b.bank_number_o from userbindcard b left join user u on b.uid=u.id where b.uid="+uid+" and isdefualt="+UserBindCard.DEFAULT_TRUE;
		return user2BindCardDao.findSql(sql, null);
	}

}

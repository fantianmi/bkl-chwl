package com.bkl.chwl.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkl.chwl.entity.Area;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.entity.User2BindCard;
import com.bkl.chwl.entity.UserBindCard;
import com.bkl.chwl.service.AreaService;
import com.bkl.chwl.service.BindCardService;
import com.bkl.chwl.service.UserService;
import com.bkl.chwl.service.impl.AreaServiceImpl;
import com.bkl.chwl.service.impl.BindCardServiceImpl;
import com.bkl.chwl.service.impl.UserServiceImpl;
import com.bkl.chwl.utils.StringUtil;
import com.bkl.chwl.utils.UserUtil;
import com.km.common.servlet.CommonServlet;
import com.km.common.utils.ServletUtil;
import com.km.common.utils.TimeUtil;

public class BindCardServlet extends CommonServlet {
	public void addCard(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User u=UserUtil.getCurrentUser(request);
		UserService userServ=new UserServiceImpl();
		User2BindCard reqcard=ServletUtil.readObjectServletQuery(request,User2BindCard.class);
		BindCardService bindCardServ=new BindCardServiceImpl();
		UserBindCard card=new UserBindCard();
		boolean needUpdateUser=false;
		card.setBank_account_o(reqcard.getBank_account_o());
		card.setBank_deposit_o(reqcard.getBank_deposit_o());
		card.setBank_o(reqcard.getBank_o());
		card.setIsdefault(card.DEFAULT_FALSE);
		card.setPhone_o(reqcard.getPhone_o());
		card.setUid(u.getId());
		long id=bindCardServ.addCard(card);
		//检查是否需要更新用户表
		if(u.getName()==null||u.getName()==""){
			needUpdateUser=true;
			u.setName(reqcard.getName());
		}
		if(u.getIdentity_no()==null||u.getIdentity_no()==""){
			needUpdateUser=true;
			u.setIdentity_no(reqcard.getIdentity_no());
		}
		if(u.getIdentity_type()==0){
			needUpdateUser=true;
			u.setIdentity_type(reqcard.getIdentity_type());
		}
		if(needUpdateUser){
			userServ.save(u);
		}
		card.setId(id);
		ServletUtil.writeOkCommonReply(card, response);
	}
	
	public void modifyCard(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User2BindCard reqcard=ServletUtil.readObjectServletQuery(request,User2BindCard.class);
		BindCardService bindCardServ=new BindCardServiceImpl();
		UserBindCard card=bindCardServ.getCard(reqcard.getBid());
		card.setBank_account_o(reqcard.getBank_account_o());
		card.setBank_deposit_o(reqcard.getBank_deposit_o());
		card.setBank_o(reqcard.getBank_o());
		card.setPhone_o(reqcard.getPhone_o());
		
		long id=bindCardServ.addCard(card);
		card.setId(id);
		ServletUtil.writeOkCommonReply(card, response);
	}
	
	public void removeCard(HttpServletRequest request,HttpServletResponse response) throws Exception{
		UserBindCard reqcard=ServletUtil.readObjectServletQuery(request,UserBindCard.class);
		BindCardService bindCardServ=new BindCardServiceImpl();
		long id=bindCardServ.deleteCard(reqcard.getUid(), reqcard.getId());
		ServletUtil.writeOkCommonReply(id, response);
	}
}

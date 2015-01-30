package com.bkl.chwl.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.bkl.chwl.entity.BankInfo;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.entity.User2BindCard;
import com.bkl.chwl.entity.UserBindCard;
import com.bkl.chwl.service.BankInfoService;
import com.bkl.chwl.service.BindCardService;
import com.bkl.chwl.service.UserService;
import com.bkl.chwl.service.impl.BankInfoServiceImpl;
import com.bkl.chwl.service.impl.BindCardServiceImpl;
import com.bkl.chwl.service.impl.OrderServiceImpl;
import com.bkl.chwl.service.impl.UserServiceImpl;
import com.bkl.chwl.utils.UserUtil;
import com.km.common.servlet.CommonServlet;
import com.km.common.utils.ServletUtil;
import com.km.common.vo.RetCode;

public class BindCardServlet extends CommonServlet {
	private Log log = LogFactory.getLog(OrderServiceImpl.class);
	public void addCard(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User u=UserUtil.getCurrentUser(request);
		UserService userServ=new UserServiceImpl();
		User2BindCard reqcard=ServletUtil.readObjectServletQuery(request,User2BindCard.class);
		
		String bank_o=reqcard.getBank_o();
		BankInfoService bankServ=new BankInfoServiceImpl();
		BankInfo bankInfo=bankServ.getByBankName(bank_o);
		if(bankInfo==null){
			ServletUtil.writeCommonReply(null, RetCode.BANK_NOT_EXIST, response);
		}
		BindCardService bindCardServ=new BindCardServiceImpl();
		UserBindCard card=new UserBindCard();
		boolean needUpdateUser=false;
		card.setBank_account_o(reqcard.getBank_account_o().replaceAll(" ", ""));
		card.setBank_deposit_o(reqcard.getBank_o());
		card.setBank_o(reqcard.getBank_o());
		card.setIsdefault(card.DEFAULT_FALSE);
		card.setPhone_o(reqcard.getPhone_o());
		card.setUid(u.getId());
		card.setBank_number_o(bankInfo.getBankNumber());
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
	public void addCardTEST(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User u=UserUtil.getCurrentUser(request);
		UserService userServ=new UserServiceImpl();
		User2BindCard reqcard=ServletUtil.readObjectServletQuery(request,User2BindCard.class);
		String bank_o=reqcard.getBank_o();
		BankInfoService bankServ=new BankInfoServiceImpl();
		bankServ.getByBankName(bank_o);
		BindCardService bindCardServ=new BindCardServiceImpl();
		UserBindCard card=new UserBindCard();
		boolean needUpdateUser=false;
		card.setBank_account_o(reqcard.getBank_account_o());
		card.setBank_deposit_o(reqcard.getBank_o());
		card.setBank_o(reqcard.getBank_o());
		card.setIsdefault(card.DEFAULT_FALSE);
		card.setPhone_o(reqcard.getPhone_o());
		card.setUid(u.getId());
		card.setBank_number_o("");
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
		ServletUtil.writeOkCommonReply(bank_o, response);
	}
	
	public void modifyCard(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User2BindCard reqcard=ServletUtil.readObjectServletQuery(request,User2BindCard.class);
		BindCardService bindCardServ=new BindCardServiceImpl();
		UserBindCard card=bindCardServ.getCard(reqcard.getBid());
		card.setBank_account_o(reqcard.getBank_account_o());
		card.setBank_deposit_o(reqcard.getBank_deposit_o());
		card.setBank_o(reqcard.getBank_o());
		card.setPhone_o(reqcard.getPhone_o());
		if(reqcard.getBank_number_o()!=null){
			card.setBank_number_o(reqcard.getBank_number_o());
		}
		long id=bindCardServ.addCard(card);
		card.setId(id);
		ServletUtil.writeOkCommonReply(card, response);
	}
	/**
	 * 设置默认收款卡片，针对商家
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void setDefault(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User u=UserUtil.getCurrentUser(request);
		long id=Integer.parseInt(request.getParameter("id"));
		BindCardService bindCardServ=new BindCardServiceImpl();
		bindCardServ.setDefault(id, u.getId());
		ServletUtil.writeOkCommonReply(null, response);
	}
	
	public void removeCard(HttpServletRequest request,HttpServletResponse response) throws Exception{
		UserBindCard reqcard=ServletUtil.readObjectServletQuery(request,UserBindCard.class);
		BindCardService bindCardServ=new BindCardServiceImpl();
		long id=bindCardServ.deleteCard(reqcard.getUid(), reqcard.getId());
		ServletUtil.writeOkCommonReply(id, response);
	}
}

package com.bkl.chwl.entity;

import org.apache.commons.lang.StringUtils;

import com.bkl.chwl.utils.DoubleUtil;
import com.km.common.dao.TableAonn;
import com.km.common.utils.MD5Util;
import com.km.common.utils.TimeUtil;

@TableAonn(tableName = "user")
public class User {
	private long id;
	/***
	 * 邮箱.作为帐号登录
	 */
	private String email = "";
	private String password = "";
	/***
	 * 注册IP
	 */
	private String reg_ip = "";
	/**
	 * qq登录 微博登录唯一标识
	 */
	private String pin = "";
	/**
	 * 微信的Openid
	 */
	private String openid="";
	/**
	 * 用户姓名
	 */
	private String name = "";
	
	/**
	 * 用户呢称
	 */
	private String nick_name = "";
	
	/**
	 * 证件类型
	 */
	private int identity_type;
	public static final int IDENTITY_TYPE_ID=1;
	public static final int IDENTITY_TYPE_PASS=2;
	public static final int IDENTITY_TYPE_RE_ENTRY=3;
	public static final int IDENTITY_TYPE_MTP=4;
	/**
	 * 手机号码
	 */
	private String mobile;
	/**
	 * 大小王临时加上_用于找回密码
	 */
	private String mobile2;
	
	/**
	 * 证件号
	 */
	private String identity_no;
	
	/**
	 * 创建时间
	 */
	private long ctime;
	
	private int email_validated ;
	private int realname_validated;
	private int mobile_validated;
	private String secret = "";
	private String address = "";
	private float received;
	private String headIcon="";
	
	/**
	 * 点头付特殊字段 
	 */
	private int role;
	private String licenceFileURL;
	private String licenceFileName;
	//所属地区 一级城市 二级城市 三级城市
	private int local;
	private int local2;
	private int local3;
	
	//营业执照编号
	private String licenceNumber;
	//城市代理
	private int proxy;
	private long proxy_cid;
	//区域代理
	private int proxy2;
	private long proxy2_cid;
	private int vertify;
	//公司营业执照名
	private String licenceRegName;
	//公司法人
	private String manager;
	
	public static final int ROLE_NORMAL=1;
	public static final int ROLE_SHOPER=2;
	
	public static final int PROXY_TRUE=1;
	public static final int PROXY_FALSE=0;
	
	public static final int VERTIFY_TRUE=1;
	public static final int VERTIFY_FALSE=0;
	public static final int PROXY_TYPE_PROVINCE=1;
	public static final int PROXY_TYPE_CITY=2;
	public static final int PROXY_TYPE_ISOLATE=3;
	
	
	public String getLicenceRegName() {
		return licenceRegName;
	}
	public void setLicenceRegName(String licenceRegName) {
		this.licenceRegName = licenceRegName;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getLicenceNumber() {
		return licenceNumber;
	}
	public void setLicenceNumber(String licenceNumber) {
		this.licenceNumber = licenceNumber;
	}
	public int getVertify() {
		return vertify;
	}
	public String getVertifyString() {
		if(vertify==VERTIFY_FALSE) return "等待审核";
		if(vertify==VERTIFY_TRUE) return "审核通过";
		return "等待审核";
	}
	
	public void setVertify(int vertify) {
		this.vertify = vertify;
	}
	public int getProxy() {
		return proxy;
	}
	public String getProxyString(){
		if(proxy==this.PROXY_FALSE) return "普通商户";
		if(proxy==this.PROXY_TRUE) return "城市代理商户";
		return "未知";
	}

	public int getLocal3() {
		return local3;
	}
	public void setLocal3(int local3) {
		this.local3 = local3;
	}
	public void setProxy(int proxy) {
		this.proxy = proxy;
	}
	
	public long getProxy_cid() {
		return proxy_cid;
	}
	public void setProxy_cid(long proxy_cid) {
		this.proxy_cid = proxy_cid;
	}
	public long getProxy2_cid() {
		return proxy2_cid;
	}
	public void setProxy2_cid(long proxy2_cid) {
		this.proxy2_cid = proxy2_cid;
	}
	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public String getLicenceFileURL() {
		return licenceFileURL;
	}

	public void setLicenceFileURL(String licenceFileURL) {
		this.licenceFileURL = licenceFileURL;
	}

	public String getLicenceFileName() {
		return licenceFileName;
	}

	public void setLicenceFileName(String licenceFileName) {
		this.licenceFileName = licenceFileName;
	}

	public int getLocal() {
		return local;
	}

	public void setLocal(int local) {
		this.local = local;
	}
	
	public String getMobile2() {
		return mobile2;
	}
	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}
	public int getLocal2() {
		return local2;
	}

	public void setLocal2(int local2) {
		this.local2 = local2;
	}

	public int getMobile_validated() {
		return mobile_validated;
	}

	public void setMobile_validated(int mobile_validated) {
		this.mobile_validated = mobile_validated;
	}
	/**
	 * 行号：行号类似卡号，是每家营业网点的代码，用于提现转账减少手续费
	 */
	private String bank_number;
	
	/***
	 * 银行名称
	 */
	private String bank;
	
	/***
	 * 银行卡号
	 */
	private String bank_account;
	
	
	private int frozen;
	
	private long passwd_modify_overtime;
	
	public int getProxy2() {
		return proxy2;
	}
	public String getProxy2String(){
		if(proxy2==this.PROXY_FALSE) return "普通商户";
		if(proxy2==this.PROXY_TRUE) return "区域代理商户";
		return "未知";
	}
	
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public void setProxy2(int proxy2) {
		this.proxy2 = proxy2;
	}
	public String getHeadIcon() {
		return headIcon;
	}

	public void setHeadIcon(String headIcon) {
		this.headIcon = headIcon;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public void saveMD5Password(String password) {
		this.password = MD5Util.md5(password);
	}
	
	public void saveMD5SecretPassword(String password) {
		this.secret = MD5Util.md5(password);
	}
	
	/***
	 * 登录密码检验
	 * @param password
	 * @return
	 */
	public boolean checkPassword(String password) {
		if (StringUtils.isBlank(password)) {
			return false;
		}
		return MD5Util.md5(password).equals(this.password);
	}
	
	/***
	 * 交易密码检验
	 * @param password
	 * @return
	 */
	public boolean checkSecretPassword(String password) {
		if (StringUtils.isBlank(password)) {
			return false;
		}
		return MD5Util.md5(password).equals(this.secret);
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getReg_ip() {
		return reg_ip;
	}

	public void setReg_ip(String reg_ip) {
		this.reg_ip = reg_ip;
	}

	public String getPin() {
		return pin;
	}
	public void setPin(String pin) {
		this.pin = pin;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getNick_name() {
		return nick_name;
	}

	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}

	public long getCtime() {
		return ctime;
	}
	public void setCtime(long ctime) {
		this.ctime = ctime;
	}

	public int getEmail_validated() {
		return email_validated;
	}
	public void setEmail_validated(int email_validated) {
		this.email_validated = email_validated;
	}

	public int getRealname_validated() {
		return realname_validated;
	}

	public void setRealname_validated(int realname_validated) {
		this.realname_validated = realname_validated;
	}

	public String getSecret() {
		return secret;
	}
	public void setSecret(String secret) {
		this.secret = secret;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public float getReceived() {
		return received;
	}
	public void setReceived(float received) {
		this.received = received;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getBank_account() {
		return bank_account;
	}

	public void setBank_account(String bank_account) {
		this.bank_account = bank_account;
	}


	public int getIdentity_type() {
		return identity_type;
	}
	
	public String getIdentity_typeString(){
		if(identity_type==IDENTITY_TYPE_ID) return "身份证";
		if(identity_type==IDENTITY_TYPE_MTP) return "台胞证";
		if(identity_type==IDENTITY_TYPE_PASS) return "护照";
		if(identity_type==IDENTITY_TYPE_RE_ENTRY) return "回乡证";
		return "未定义";
	}

	public void setIdentity_type(int identity_type) {
		this.identity_type = identity_type;
	}

	public String getIdentity_no() {
		return identity_no;
	}

	public void setIdentity_no(String identity_no) {
		this.identity_no = identity_no;
	}

	public int getFrozen() {
		return frozen;
	}

	public void setFrozen(int frozen) {
		this.frozen = frozen;
	}
	
	public String getCtimeString() {
		return TimeUtil.fromUnixTime(ctime);
	}

	public long getPasswd_modify_overtime() {
		return passwd_modify_overtime;
	}

	public void setPasswd_modify_overtime(long passwd_modify_overtime) {
		this.passwd_modify_overtime = passwd_modify_overtime;
	}

	public String getBank_number() {
		return bank_number;
	}

	public void setBank_number(String bank_number) {
		this.bank_number = bank_number;
	}
}
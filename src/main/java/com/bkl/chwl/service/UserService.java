package com.bkl.chwl.service;

import java.util.Map;

import com.bkl.chwl.entity.User;
import com.bkl.chwl.entity.User2Shop;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;
import com.km.common.vo.RetCode;


/**
 * 类职责:用户注册，登录，实名制，密码等管理
 * @author Administrator
 *
 */
public interface UserService{

	/**
	 * 保存用户对象
	 * @param user	用户对象
	 * @return	用户ID
	 */
	public Long save(User user);
	
	/**
	 * 新建用户对象,并为用户分配比特币/莱特币充值地址.
	 * @param user	用户对象
	 * @return	用户ID
	 */
	public Long createUser(User user);
	
	/**
	 * 根据用户ID查找用户对象
	 * @param id	用户ID
	 * @return	用户对象
	 */
    public User get(long id);
    
    /**
     * 根据用户邮箱查找用户对象
     * @param email	邮箱
     * @return	用户对象
     */
    public User find(String email);
    /**
     * 根据手机号找用户
     * @param mobile
     * @return
     */
    public User findByMobile(String mobile);
    /**
     * 根据营业执照号码查询用户
     * @param licenceNumber
     * @return
     */
    public User findByLicence(String licenceNumber);
    /**
     * 校验身份证是否重复，只校验普通用户
     * @param identity_no
     * @return
     */
    public User findByIdentity_no(String identity_no);
    
    /**
     * 根据比特币充值地址查找用户对象
     * @param btcAddr	比特币充值地址
     * @return	用户对象
     */
    public User findByBtcAddr(String btcAddr);
    
    /**
     * 根据莱特币充值地址查找用户对象
     * @param btcAddr	莱特币充值地址
     * @return	用户对象
     */
    public User findByLtcAddr(String btcAddr);
    
    /**
     * 登录
     * @param username	用户帐号
     * @param password	密码
     * @return	操作编码
     */
    public RetCode login(String username,String password);
    
    /**
     * 验证用户是否存在.
     * @param username	用户帐号
     * @return
     */
    public boolean exist(String username);
    /**
     * 验证手机号码是否存在
     * @param mobile
     * @return
     */
    public boolean existMobile(String mobile);
    /**
     * 验证营业执照号码是否重复
     * @param licence
     * @return
     */
    public boolean existLicence(String licence);
    /**
     * 验证身份证是否重复，只校验普通用户
     * @param identity_no
     * @return
     */
    public boolean exisetIdentity_no(String identity_no);
    /**
     * 验证手机mobile2是否重复，只校验role=商铺的数据项
     * @param mobile
     * @return
     */
    public boolean existMobile2(String mobile);
 
    /***
     * 分页查询用户
     * @param searchMap	
     * 搜索条件。举例：
     * <p>name->zs表示name like 'zs%'</p>
     * <p>name+email->zs表示name like 'zs%' or email like 'zs%'</p>
     * @param page	分页参数
     */
    public PageReply<User> findUser(Map searchMap, Page page);
    
    public PageReply<User> findUser(int role,Map searchMap, Page page);
    
    public PageReply<User2Shop> findUser2Shop(int role,Map searchMap, Page page);
    
    public User findPin(String pin);
    /**
     * 修改用户
     * @param user
     * @param id
     * @return
     */
    public long modifyUser(User user,long id);
    
    public long maxUserID();
    
    public int countUser(int role);
}

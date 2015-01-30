package com.bkl.chwl.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import net.sf.json.JSONObject;

import com.bkl.chwl.MainConfig;
import com.bkl.chwl.entity.Tradeorder;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.entity.Weixin;
import com.bkl.chwl.service.ShopService;
import com.bkl.chwl.service.UserService;
import com.bkl.chwl.service.impl.ShopServiceImpl;
import com.bkl.chwl.service.impl.UserServiceImpl;
import com.bkl.chwl.vo.TemplateData;
import com.bkl.chwl.vo.WxTemplate;
import com.km.common.utils.TimeUtil;
import com.unionpay.acp.sdk.BaseHttpSSLSocketFactory.MyX509TrustManager;

public class SendMsgInWeixin {
	public static int RES_OPENID_NOT_SET = 600;
	public static int RES_SUCCESS = 0;
	public static int RES_ERROR = 200;
	
	public static int SEND_TYPE_BUYER=0;
	public static int SEND_TYPE_SELLER=1;
	

	/**
	 * 发送订单信息给用户
	 * 
	 * @param u
	 *            用户实体
	 * @param o
	 *            订单实体
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public static int sendOrderMessage(User u, Tradeorder o,int type) throws UnsupportedEncodingException{
		if (u.getOpenid() == null || u.getOpenid() == "") {
			return RES_OPENID_NOT_SET;
		}
		ShopService shopServ=new ShopServiceImpl();
		String redirectBaseUrl=MainConfig.getContextPath();
		Weixin weixin = WeixinApi.getWeixin();
		String uri = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+ weixin.getAccess_token();
		WxTemplate t = new WxTemplate();  
        t.setUrl(redirectBaseUrl+"user_order.jsp");  
        t.setTouser(u.getOpenid());  
        t.setTopcolor("#000000");  
        t.setTemplate_id("H-Ab1ZTMCKUwPTw_L4p0IF4sNvWe2MPy-d1OKWvR75Q");  
        String firstStr="";
        Map<String,TemplateData> m = new HashMap<String,TemplateData>();  
        if(type==SendMsgInWeixin.SEND_TYPE_BUYER){
        	firstStr = "您好，您在"+shopServ.getByUid(o.getSeller()).getTitle()+"发生交易。";
        }else if(type==SendMsgInWeixin.SEND_TYPE_SELLER){
        	firstStr = "您好，"+o.getUid()+"在您的店铺 "+shopServ.getByUid(o.getSeller()).getTitle()+"发生交易。";
        }
        TemplateData first = new TemplateData();  
        first.setColor("#000000");  
        first.setValue(firstStr);  
        m.put("first", first);  
        
        TemplateData tradeDateTime = new TemplateData();  
        tradeDateTime.setColor("#000000");  
        tradeDateTime.setValue(o.getCtimeString());  
        m.put("tradeDateTime", tradeDateTime);  
        
        TemplateData tradeType = new TemplateData();  
        tradeType.setColor("#000000");  
        tradeType.setValue(o.getTypeString());  
        m.put("tradeType", tradeType);  
        
        TemplateData curAmount = new TemplateData();  
        curAmount.setColor("#000000");  
        curAmount.setValue(FrontUtil.formatRmbDouble(o.getPrice()));  
        m.put("curAmount", curAmount);  
        
        TemplateData remark = new TemplateData();  
        remark.setColor("#000000");  
        remark.setValue("祝您生活愉快");  
        m.put("remark", remark);  
        t.setData(m);  
        JSONObject jsonobj = httpRequest(uri,"POST",JSONObject.fromObject(t).toString());
        int errorcode=Integer.parseInt(jsonobj.get("errcode").toString());
        return errorcode;
	}
	
	public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr) {  
        JSONObject jsonObject = null;  
        StringBuffer buffer = new StringBuffer();  
        try {  
            // 创建SSLContext对象，并使用我们指定的信任管理器初始化  
            TrustManager[] tm = { new MyX509TrustManager() };  
            SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");  
            sslContext.init(null, tm, new java.security.SecureRandom());  
            // 从上述SSLContext对象中得到SSLSocketFactory对象  
            SSLSocketFactory ssf = sslContext.getSocketFactory();  
  
            URL url = new URL(requestUrl);  
            HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();  
            httpUrlConn.setSSLSocketFactory(ssf);  
  
            httpUrlConn.setDoOutput(true);  
            httpUrlConn.setDoInput(true);  
            httpUrlConn.setUseCaches(false);  
            // 设置请求方式（GET/POST）  
            httpUrlConn.setRequestMethod(requestMethod);  
  
            if ("GET".equalsIgnoreCase(requestMethod))  
                httpUrlConn.connect();  
  
            // 当有数据需要提交时  
            if (null != outputStr) {  
                OutputStream outputStream = httpUrlConn.getOutputStream();  
                // 注意编码格式，防止中文乱码  
                outputStream.write(outputStr.getBytes("UTF-8"));  
                outputStream.close();  
            }  
  
            // 将返回的输入流转换成字符串  
            InputStream inputStream = httpUrlConn.getInputStream();  
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");  
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);  
  
            String str = null;  
            while ((str = bufferedReader.readLine()) != null) {  
                buffer.append(str);  
            }  
            bufferedReader.close();  
            inputStreamReader.close();  
            // 释放资源  
            inputStream.close();  
            inputStream = null;  
            httpUrlConn.disconnect();  
            jsonObject = JSONObject.fromObject(buffer.toString());  
        } catch (ConnectException ce) {  
            ce.printStackTrace();  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return jsonObject;  
    }  
	
	
	public static void main(String[] args) throws UnsupportedEncodingException{
		UserService  userService=new UserServiceImpl();
		
		User u=userService.findByMobile("18688164055");
		Tradeorder o=new Tradeorder();
		o.setPrice(200);
		o.setCtime(TimeUtil.getUnixTime());
		o.setType(o.TYPE_NOPAYBACK);
	}
}

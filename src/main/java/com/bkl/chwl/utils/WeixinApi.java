package com.bkl.chwl.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import net.sf.json.JSONObject;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.mortbay.log.Log;

import com.bkl.chwl.MainConfig;
import com.bkl.chwl.entity.Weixin;
import com.bkl.chwl.service.WeixinService;
import com.bkl.chwl.service.impl.WeixinServiceImpl;
import com.km.common.utils.TimeUtil;

public class WeixinApi {
	public static Weixin getAccess_token() throws Exception{
		HttpClient httpClient = new DefaultHttpClient();
		String uri="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+MainConfig.getWechatappid()+"&secret="+MainConfig.getWechatappsecret();
		HttpGet getRequest = new HttpGet(uri);
		HttpResponse response = httpClient.execute(getRequest);
		if (response.getStatusLine().getStatusCode() != 200) {
			httpClient.getConnectionManager().shutdown();
			throw new IOException();
		}
		
		InputStream content = response.getEntity().getContent();
		BufferedReader in = new BufferedReader(new InputStreamReader(content));

		StringBuffer result = new StringBuffer();
		String line;
		while ((line = in.readLine()) != null) {
			System.out.println(line);
			result.append(line);	
		}
		httpClient.getConnectionManager().shutdown();
		System.out.println(result.toString());
		JSONObject jsonObject = JSONObject.fromObject(result.toString());
		Weixin weixin = (Weixin)JSONObject.toBean(jsonObject, Weixin.class);
		
		WeixinService weixinServ=new WeixinServiceImpl();
		
		Weixin weixinDB=weixinServ.getWeixin();
		if(weixinDB!=null){
			weixinDB.setAccess_token(weixin.getAccess_token());
			weixinDB.setAccess_token_expires(weixin.getExpires_in()-360+TimeUtil.getUnixTime());
			weixinServ.saveWeixin(weixinDB);
			return weixinDB;
		}else{
			weixin.setAccess_token_expires(weixin.getExpires_in()-360+TimeUtil.getUnixTime());
			weixin.setId(weixinServ.saveWeixin(weixin));
			return weixin;
			
		}
	}
	
	public static Weixin getTicket() throws Exception{
		long now=TimeUtil.getUnixTime();
		WeixinService weixinServ=new WeixinServiceImpl();
		Weixin weixinDB=new Weixin();
		Weixin weixinTemp=weixinServ.getWeixin();
		//如果过期则重新获取access_token
		if(weixinTemp==null||now>weixinTemp.getAccess_token_expires()){
			try {
				weixinDB=getAccess_token();
			} catch (Exception e) {
				return null;
			}
		}else{
			weixinDB=weixinTemp;
		}
		HttpClient httpClient = new DefaultHttpClient();
		String uri="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+weixinDB.getAccess_token()+"&type=jsapi";
		HttpGet getRequest = new HttpGet(uri);
		HttpResponse response = httpClient.execute(getRequest);
		if (response.getStatusLine().getStatusCode() != 200) {
			httpClient.getConnectionManager().shutdown();
			throw new IOException();
		}
		
		InputStream content = response.getEntity().getContent();
		BufferedReader in = new BufferedReader(new InputStreamReader(content));

		StringBuffer result = new StringBuffer();
		String line;
		while ((line = in.readLine()) != null) {
			System.out.println(line);
			result.append(line);	
		}
		httpClient.getConnectionManager().shutdown();
		System.out.println(result.toString());
		JSONObject jsonObject = JSONObject.fromObject(result.toString());
		Weixin weixin = (Weixin)JSONObject.toBean(jsonObject, Weixin.class);
		
		weixinDB.setTicket(weixin.getTicket());
		weixinDB.setTicket_expires(weixin.getExpires_in()-360+TimeUtil.getUnixTime());
		weixinServ.saveWeixin(weixinDB);
		return weixinDB;
	}
	
	public static Weixin getWeixin(){
		WeixinService weixinServ=new WeixinServiceImpl();
		Weixin weixinTemp=weixinServ.getWeixin();
		long now=TimeUtil.getUnixTime();
		if(weixinTemp==null||now>weixinTemp.getAccess_token_expires()||now>weixinTemp.getTicket_expires()){
			try {
				getAccess_token();
				return getTicket();
			} catch (Exception e) {
				return null;
			}
		}
		return weixinTemp;
	}
	public static void main(String[] args){
		try {
			getWeixin();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

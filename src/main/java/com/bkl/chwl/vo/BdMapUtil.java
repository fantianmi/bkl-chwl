package com.bkl.chwl.vo;

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
import org.junit.Test;

import com.baiyi.data.model.User;

public class BdMapUtil {
	private static String BASE_URL = "http://api.map.baidu.com/location/ip";
	private static String AUTHKEY = "mQO2QyHBKdGM6OX0OwGMyqmr";

	public static BdMapRes getLocation(String ip) throws ClientProtocolException,
			IOException {
		HttpClient httpClient = new DefaultHttpClient();
		String uri=BASE_URL+"?ak="+AUTHKEY+"&ip="+ip+"&coor=bd09ll";
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
		BdMapRes bdMapRes = (BdMapRes)JSONObject.toBean(jsonObject, BdMapRes.class);
		return bdMapRes;
	}
	@Test
	public void bdmapTEST(){
		String ip="115.173.122.78";
		try {
			BdMapRes bdMapRes=this.getLocation(ip);
			System.out.println();
		} catch (IOException e) {
		}
	}
}
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

public class HttpUtils {
	public static JSONObject httpGet(String uri) throws ClientProtocolException, IOException{
		HttpClient httpClient = new DefaultHttpClient();
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
			result.append(line);	
		}
		httpClient.getConnectionManager().shutdown();
		System.out.println(result.toString());
		JSONObject jsonObject = JSONObject.fromObject(result.toString());
		return jsonObject;
	}

}

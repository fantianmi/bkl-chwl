package com.bkl.chwl.vo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;

public class HttpUtil
{
  private static String BASE_URL = "http://localhost:8081";
  private static String AUTHKEY;

  public static void init(String serverUrl, String authKey, String authPass)
  {
    BASE_URL = serverUrl;
    AUTHKEY = authKey + ":" + authPass;
  }

  public static String post(String uri, String param) throws ClientProtocolException, IOException
  {
    HttpClient httpClient = new DefaultHttpClient();
    HttpPost httpPost = new HttpPost(BASE_URL + uri);

    StringEntity entity = new StringEntity(param);

    entity.setContentType("application/x-www-form-urlencoded");
    httpPost.setEntity(entity);

    String authEncoded = Base64.encodeBase64String(AUTHKEY.getBytes()).replace("\r\n","");

    httpPost.setHeader("Authorization", "Basic " + authEncoded);

    HttpResponse response = httpClient.execute(httpPost);
    if (response.getStatusLine().getStatusCode() != 200)
    {
      httpClient.getConnectionManager().shutdown();
      throw new IOException();
    }
    InputStream content = response.getEntity().getContent();
    BufferedReader in = 
      new BufferedReader(new InputStreamReader(content));

    StringBuffer result = new StringBuffer();
    String line;
    while ((line = in.readLine()) != null)
    {
      System.out.println(line);
      result.append(line);
    }
    httpClient.getConnectionManager().shutdown();

    return result.toString();
  }

  public static String get(String uri)
    throws ClientProtocolException, IOException
  {
    HttpClient httpClient = new DefaultHttpClient();
    HttpGet getRequest = new HttpGet(BASE_URL + uri);

    String authEncoded = Base64.encodeBase64String(AUTHKEY.getBytes()).replace("\r\n","");

    getRequest.setHeader("Authorization", "Basic " + authEncoded);

    HttpResponse response = httpClient.execute(getRequest);
    if (response.getStatusLine().getStatusCode() != 200)
    {
      httpClient.getConnectionManager().shutdown();
      throw new IOException();
    }
    InputStream content = response.getEntity().getContent();
    BufferedReader in = 
      new BufferedReader(new InputStreamReader(content));

    StringBuffer result = new StringBuffer();
    String line;
    while ((line = in.readLine()) != null)
    {
      System.out.println(line);
      result.append(line);
    }
    httpClient.getConnectionManager().shutdown();
    return result.toString();
  }
}
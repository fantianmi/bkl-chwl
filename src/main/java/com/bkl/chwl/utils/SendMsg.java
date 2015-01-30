package com.bkl.chwl.utils;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.bkl.chwl.utils.msg.Client;
import com.km.common.config.Config;

public class SendMsg {
	private static Log log = LogFactory.getLog(SendMsg.class);

	/*
	 * public static boolean sendMsg(String mobile,String content) throws
	 * IllegalStateException, IOException{ HttpClient httpClient = new
	 * DefaultHttpClient(); String
	 * uri="http://116.213.72.20/SMSHttpService/send.aspx?username="
	 * +MainConfig.getSendmsgUsr
	 * ()+"&password="+MainConfig.getSendmsgPwd()+"&mobile="
	 * +mobile+"&content="+content+"&Extcode=&senddate=&batchID=";
	 * System.out.println(uri); HttpGet getRequest = new HttpGet(uri);
	 * HttpResponse response; try { response = httpClient.execute(getRequest); }
	 * catch (ClientProtocolException e) { return false; } catch (IOException e)
	 * { return false; } if (response.getStatusLine().getStatusCode() != 200) {
	 * httpClient.getConnectionManager().shutdown(); return false; } InputStream
	 * res_content = response.getEntity().getContent(); BufferedReader in = new
	 * BufferedReader(new InputStreamReader(res_content));
	 * 
	 * StringBuffer result = new StringBuffer(); String line; while ((line =
	 * in.readLine()) != null) { result.append(line); }
	 * httpClient.getConnectionManager().shutdown();
	 * log.info("发送用户"+mobile+"，发送内容："
	 * +URLDecoder.decode(content)+"，返回结果："+result.toString()); return true; }
	 */

	public static boolean sendMsg(String mobile, String content,
			HttpServletRequest request) throws IllegalStateException,
			IOException {
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(2*60);
		if(session.getAttribute("sendMobileNumber")!=null){
			return false;
		}
		session.setAttribute("sendMobileNumber", mobile);
		
		String sn = Config.getString("zucp.sn");
		String pwd = Config.getString("zucp.password");
		;
		Client client = new Client(sn, pwd);
		// 获取信息
		// String result = client.mdgetSninfo();
		// System.out.print(result);
		// 短信发送
		String result_mt = client.mdsmssend(mobile, content, "", "", "", "");
		System.out.print(result_mt);
		log.info("发送用户" + mobile + "，发送内容：" + URLDecoder.decode(content)
				+ "，返回结果：" + result_mt);
		return true;
	}
}

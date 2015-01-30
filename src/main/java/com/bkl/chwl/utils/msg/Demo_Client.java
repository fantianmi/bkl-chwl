package com.bkl.chwl.utils.msg;

import java.io.UnsupportedEncodingException;
import java.net.*;

import com.km.common.config.Config;

public class Demo_Client {
	


	public static void main(String[] args) throws UnsupportedEncodingException
	{

		String sn=Config.getString("zucp.sn");
		String pwd=Config.getString("zucp.password");;
		Client client=new Client(sn,pwd);
		//获取信息
//		String result = client.mdgetSninfo();
//		System.out.print(result);
		//短信发送	
        String content=URLEncoder.encode("【点头财神】您正在使用找回密码，您的验证码是123456,有效期10分钟，大小王科技。", "utf8");
		String result_mt = client.mdsmssend("18688164055", content, "", "", "", "");
		System.out.print(result_mt);
		//个性短信发送
//		String result_gxmt = client.mdgxsend("13800138", "测试", "", "", "", "");
//		System.out.print(result_gxmt);

	}
}

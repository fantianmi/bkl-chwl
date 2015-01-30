package com.unionpay.acp.pay;

import java.util.HashMap;
import java.util.Map;

import com.unionpay.acp.sdk.SDKConfig;

/**
 * 名称： 第一卷 商户卷 第6部分 手机支付 ——WAP页面支付产品 <br>
 * 功能： 6.4　退货类交易<br>
 * 版本： 5.0<br>
 * 日期： 2014-07<br>
 * 作者： 中国银联ACP团队<br>
 * 版权： 中国银联<br>
 * 说明：以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己需要，按照技术文档编写。该代码仅供参考。<br>
 */
public class Form06_6_4 extends DemoBase {

	public static Map<String, Object> setFormDate() {

		Map<String, Object> contentData = new HashMap<String, Object>();

		String merId = "802290049000180";
		String txnTime = "20140820145625";// --订单发送时间
		String orderId = "201408201508395217";// --商户订单号

		String origQryId = "201408201508395217";
		// 固定填写
		contentData.put("version", version);// M

		// 默认取值：UTF-8
		contentData.put("encoding", encoding);// M

		// //通过MPI插件获取
		// contentData.put("certId", certId);//M

		// 填写对报文摘要的签名
		// contentData.put("signature", signature);//M

		// 01RSA02 MD5 (暂不支持)
		contentData.put("signMethod", "01");// M

		// 取值：31
		contentData.put("txnType", "31");// M

		// 默认:00
		contentData.put("txnSubType", "00");// M

		contentData.put("bizType", "00");// M

		contentData.put("channelType", "07");// M

		// 后台返回商户结果时使用，如上送，则发送商户后台交易结果通知
		contentData.put("backUrl", backUrl);// M

		// 0：普通商户直连接入2：平台类商户接入
		contentData.put("accessType", "0");// M

		// 　
		contentData.put("merId", merId);// M

		// 商户类型为平台类商户接入时必须上送
		contentData.put("subMerId", "");// C

		// 商户类型为平台类商户接入时必须上送
		contentData.put("subMerName", "");// C

		// 商户类型为平台类商户接入时必须上送
		contentData.put("subMerAbbr", "");// C

		// 消费撤销的订单号，由商户生成
		contentData.put("orderId", orderId);// M

		// 原始交易的queryId
		contentData.put("origQryId", origQryId);// M

		// 　
		contentData.put("txnTime", txnTime);// M

		// 与原消费交易一致
		contentData.put("txnAmt", "1");// M

		// 　
		contentData.put("termId", "");// O

		// 商户自定义保留域，交易应答时会原样返回
		contentData.put("reqReserved", "");// O

		// 格式如下：{子域名1=值&子域名2=值&子域名3=值} 移动支付参考消费
		contentData.put("reserved", "");// O

		// 渠道类型为语音支付时使用用法见VPC交易信息组合域子域用法
		contentData.put("vpcTransData", "");// C
		return contentData;
	}

	public static void main(String[] args) {

	/**
		 * 参数初始化
		 * 在java main 方式运行时必须每次都执行加载
		 * 如果是在web应用开发里,这个方写在可使用监听的方式写入缓存,无须在这出现
		 */
		SDKConfig.getConfig().loadPropertiesFromSrc();

		/**
		 * 交易请求url 从配置文件读取
		 */
		 String requestBackUrl = SDKConfig.getConfig()
				.getBackRequestUrl();
		Map<String, String> resmap = submitDate(setFormDate(),requestBackUrl);

		System.out.println(resmap.toString());
	}
}

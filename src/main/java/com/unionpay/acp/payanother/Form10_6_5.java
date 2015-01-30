package com.unionpay.acp.payanother;

import java.util.HashMap;
import java.util.Map;

import com.unionpay.acp.sdk.SDKConfig;

/**
 * 名称： 第一卷 商户卷 第10部分 代付产品<br>
 * 功能： 6.5　批量类交易<br>
 * 版本： 5.0<br>
 * 日期： 2014-07<br>
 * 作者： 中国银联ACP团队<br>
 * 版权： 中国银联<br>
 * 说明：以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己需要，按照技术文档编写。该代码仅供参考。<br>
 */
public class Form10_6_5 extends DemoBase {

	public static Map<String, Object> setFormDate() {
		Map<String, Object> contentData = new HashMap<String, Object>();

		String merId = "802290049000180";
		String txnTime = "20140820145625";// --订单发送时间

		// 固定填写
		contentData.put("version", version);// M

		// 默认取值：UTF-8
		contentData.put("encoding", encoding);// M

		// //通过MPI插件获取
		// contentData.put("certId", certId);//M
		//
		// //填写对报文摘要的签名
		// contentData.put("signature", signature);//M

		// 01RSA02 MD5 (暂不支持)
		contentData.put("signMethod", "01");// M

		// 取值：21 批量交易
		contentData.put("txnType", "21");// M

		// 填写：01：退货02：代收03：代付
		contentData.put("txnSubType", "02");// M

		// 默认:000000
		contentData.put("bizType", "000000");// M

		contentData.put("channelType", "07");// M

		// 0：普通商户直连接入1：收单机构接入2：平台类商户接入
		contentData.put("accessType", "0");// M

		// 接入类型为商户接入时需上送
		contentData.put("merId", merId);// C
		//
		// //商户类型为平台类商户接入时必须上送
		// contentData.put("subMerId", subMerId);//C
		//
		// //商户类型为平台类商户接入时必须上送
		// contentData.put("subMerName", subMerName);//C
		//
		// //商户类型为平台类商户接入时必须上送
		// contentData.put("subMerAbbr", subMerAbbr);//C

		// 批量交易时填写，当天唯一,0001-9999，商户号+批次号+上交易时间确定一笔交易
		contentData.put("batchNo", "9999");// M

		// 前8位需与文件中的委托日期保持一致
		contentData.put("txnTime", txnTime);// M

		// 批量交易时填写，填写批量中，总的交易比数
		contentData.put("totalQty", "9999");// M

		// 批量交易时填写，填写批量中，总的交易金额
		contentData.put("totalAmt", "9999");// M

		// 使用DEFLATE压缩算法压缩后，Base64编码的方式传输经压缩编码的文件内容，一个文件中必须只能有一个商户号出现。
		contentData.put("fileContent", "fileContent文件流");// M

		// //商户自定义保留域，交易应答时会原样返回
		// contentData.put("reqReserved", reqReserved);//O
		//
		// //交易包含多个子域，所有子域需用“{}”包含，子域间以“&”符号链接。格式如下：{子域名1=值&子域名2=值&子域名3=值}。具体子域的名称、取值根据商户不同而定。
		// contentData.put("reserved", reserved);//O
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

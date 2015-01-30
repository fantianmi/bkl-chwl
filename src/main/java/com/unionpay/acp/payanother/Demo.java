package com.unionpay.acp.payanother;

import java.util.HashMap;
import java.util.Map;

import com.km.common.utils.TimeUtil;
import com.unionpay.acp.sdk.SDKConfig;

/**
 * 
 * 名称： 第一卷 商户卷 第10部分 代付产品<br>
 * 功能： 6.2　代付交易<br>
 * 版本： 5.0<br>
 * 日期： 2014-07<br>
 * 作者： 中国银联ACP团队<br>
 * 版权： 中国银联<br>
 * 说明：以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己需要，按照技术文档编写。该代码仅供参考。<br>
 */
public class Demo extends DemoBase {

	/**
	 * 6.2　代付交易 表单填写
	 * 
	 * @return
	 */
	public static Map<String, Object> setFormDate() {

		Map<String, Object> contentData = new HashMap<String, Object>();

		String merId = "777290058110260";
		String txnTime = TimeUtil.getNowDateTime4NotSplit();// --订单发送时间
		String orderId = TimeUtil.getNowDateTime4NotSplit();// --商户订单号

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

		// 取值：12
		contentData.put("txnType", "12");// M

		// 默认：00
		contentData.put("txnSubType", "00");// M

		contentData.put("bizType", "000000");// M

		contentData.put("channelType", "07");// M

		// 交易后台返回商户结果时使用，如上送，则发送商户后台交易结果通知
		contentData.put("backUrl", backUrl);// M

		// 0：普通商户直连接入2：平台类商户接入
		contentData.put("accessType", "0");// M

		// 交易
		contentData.put("merId", merId);// M
		//
		// //商户类型为平台类商户接入时必须上送
		// contentData.put("subMerId", subMerId);//C
		//
		// //商户类型为平台类商户接入时必须上送
		// contentData.put("subMerName", subMerName);//C
		//
		// //商户类型为平台类商户接入时必须上送
		// contentData.put("subMerAbbr", subMerAbbr);//C

		// 交易
		contentData.put("orderId", orderId);// M

		// 交易
		contentData.put("txnTime", txnTime);// M

		// //　01：银行卡02：存折03：IC卡帐号类型(卡介质)
		//
		// contentData.put("accType", accType);//O

		// 非绑定类交易时需上送卡号
		contentData.put("accNo", "6216261000000000018");// M

		// 　
		contentData.put("txnAmt", "200");// M

		// 默认为156交易，填写参考公参
		contentData.put("currencyCode", "156");// M

		// //　
		// contentData.put("customerInfo", getCustomer(encoding));//O
		//
		// //用于唯一标识绑定关系
		// contentData.put("bindId", bindId);//O
		//
		// contentData.put("billType", billType);//O
		//
		// //账单查询/支付类交易中填写具体账单号码用法一：账单查询/支付类交易中网上缴税用法，填写纳税人编码用法二：账单查询/支付类交易中信用卡还款用法，填写信用卡卡号
		// contentData.put("billNo", billNo);//O
		//
		// //格式为：yyyyMMdd-yyyyMMdd
		// contentData.put("billPeriod", billPeriod);//O
		//
		// //商户自定义保留域，交易应答时会原样返回
		// contentData.put("reqReserved", reqReserved);//O
		//
		// //格式如下：{子域名1=值&子域名2=值&子域名3=值} 移动支付参考消费
		// contentData.put("reserved", reserved);//O
		//
		// //格式如下：{子域名1=值&子域名2=值&子域名3=值}有风险级别要求的商户必填 风险级别 {riskLevel=XX}
		// contentData.put("riskRateInfo", riskRateInfo);//O
		//
		// //当使用银联公钥加密密码等信息时，需上送加密证书的CertID
		// contentData.put("encryptCertId", encryptCertId);//C
		//
		// //　
		// contentData.put("termId", termId);//O
		//
		// //有卡交易必填
		// contentData.put("cardTransData", cardTransData);//C
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

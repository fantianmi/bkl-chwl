package com.bkl.chwl.utils;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import javax.imageio.ImageIO;
import jp.sourceforge.qrcode.QRCodeDecoder;
import sun.misc.BASE64Decoder;

public class QRCodeDecoderHandlerUtil {
	/**
	 * 解析二维码（QRCode）
	 * 
	 * @param input
	 *            输入流
	 * @return
	 */
	public static String decoderQRCode(InputStream input) throws Exception {
		BufferedImage bufImg = null;
		String content = null;

		bufImg = ImageIO.read(input);
		QRCodeDecoder decoder = new QRCodeDecoder();
		content = new String(decoder.decode(new TwoDimensionCodeImage(bufImg)),
				"utf-8");

		return content;
	}

	/**
	 * 解析二维码（QRCode）
	 * 
	 * @param imgPath
	 *            图片路径
	 * @return
	 */
	public static String decoderQRCode(String imgPath) throws Exception {
		// QRCode 二维码图片的文件
		File imageFile = new File(imgPath);
		BufferedImage bufImg = null;
		String content = null;

		bufImg = ImageIO.read(imageFile);
		QRCodeDecoder decoder = new QRCodeDecoder();
		content = new String(decoder.decode(new TwoDimensionCodeImage(bufImg)),
				"utf-8");

		return content;
	}

	/**
	 * 解析二维码
	 * 
	 * @param imgStr
	 *            图片的Base64信息
	 * @return
	 */
	public static String decoderQRCodeForBase64(String imgStr) throws Exception {
		if (imgStr == null) {
			return "";
		}

		BASE64Decoder decoder = new BASE64Decoder();

		byte[] b = decoder.decodeBuffer(imgStr);
		for (int i = 0; i < b.length; ++i) {
			if (b[i] < 0) {// 调整异常数据
				b[i] += 256;
			}
		}

		InputStream input = new ByteArrayInputStream(b);

		String content = decoderQRCode(input);

		return content;

	}
	public static void main(String[] args) {
	}
}

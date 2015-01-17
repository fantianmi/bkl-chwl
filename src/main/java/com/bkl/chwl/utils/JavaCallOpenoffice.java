package com.bkl.chwl.utils;

import java.io.File;
import java.io.FileWriter;
/**
 * 功能：开启openoffice服务
 * 使用方法：直接生成该类对象
 * *****由于本机openoffice安装路径不同，需要更改openoffice的安装路径
 * @author botao
 *
 */
public class JavaCallOpenoffice {
	/**
	 * 将启动程序定义在构造函数中，直接生成该类对象，即可启动openoffice服务
	 */
	public JavaCallOpenoffice() {
		Runtime rn = Runtime.getRuntime();
		Process p = null;
		try {
			File file = new File("d:\\openoprenoffice.bat");
			if (false == file.exists()) {
				System.out.println("...loading");
				FileWriter writer = new FileWriter("d:\\openoprenoffice.bat ");
				writer.write("@echo   off ");
				writer.write("\r\n ");
				writer.write("d:");
				writer.write("\r\n ");
				// D:\\Program Files\\OpenOffice 4\\program： openoffice的安装路径路径
				writer.write("cd d:\\Program Files (x86)\\OpenOffice 4\\program");
				writer.write("\r\n ");
				writer.write("soffice -headless -accept=" + "socket,host=127.0.0.1,port=8100;urp;" + " -nofirststartwizard");
				writer.write("\r\n ");
				writer.write("@echo   on ");
				writer.close();
			}
			p = rn.exec("cmd.exe /C d:\\openoprenoffice.bat");
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	}

}

package com.bkl.chwl.utils;
import java.io.IOException;
import java.util.Scanner;
/**
 * 功能：关闭openoffice服务
 * 使用方法：直接生成该类对象即可
 * @author botao
 *
 */
public class DistorySoffice {
	private Process process = null;
	/**
	 * 构造方法，实现关闭soffice进程
	 */
	public DistorySoffice() {
		try {
			// 显示进程
			process = Runtime.getRuntime().exec("tasklist");
			Scanner in = new Scanner(process.getInputStream());
			while (in.hasNextLine()) {
				String processString = in.nextLine();
				if (processString.contains("soffice.exe")) {
					// 关闭soffice进程的命令
					String cmd = "taskkill /f /im soffice.exe";
					process = Runtime.getRuntime().exec(cmd);
					System.out.println("openoffice正常关闭.......");
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

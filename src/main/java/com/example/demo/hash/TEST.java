package com.example.demo.hash;

import java.security.MessageDigest;
import com.example.demo.KeyUtil;

public class TEST {

	public static void main(String[] args) throws Exception {
		// 資料庫中的密碼雜湊值
		String hash = "8992c680550fe08bf8ba0cdc7626d6d7a844ac70d352e26863b606d723aa95a7";

		// 資料庫中的鹽值
		String salt = "4e4c7ffa1e249b912d024684cde37ac3";

		// 前端輸入的密碼
		String password = "amy123";

		// 獲取 SHA-256 消息摘要物件來幫助我們生成密碼的雜湊值
		MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");

		// 將鹽值從十六進位字串轉換為位元組陣列並添加到消息摘要中
		messageDigest.update(KeyUtil.hexStringToByteArray(salt));

		// 將前端輸入的密碼轉換為位元組陣列並進行雜湊計算，得到雜湊位元組陣列
		byte[] inputHashedBytes = messageDigest.digest(password.getBytes());

		// 將生成的雜湊位元組陣列轉換為十六進位字串
		String inputHashedHexString = KeyUtil.bytesToHex(inputHashedBytes);

		// 比較生成的雜湊十六進位字串是否與資料庫中的雜湊值相等
		System.out.println(inputHashedHexString.equals(hash));


	}

}

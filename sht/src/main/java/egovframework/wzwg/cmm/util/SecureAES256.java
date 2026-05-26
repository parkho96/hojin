package egovframework.wzwg.cmm.util;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class SecureAES256 {
	//public final static byte[] KEY_SECURETY = Base64.decode("MDk4NzY1NDMyMTA5ODc2NQ==".getBytes(), Base64.URL_SAFE);

    /**
     * hex to byte[] : 16진수 문자열을 바이트 배열로 변환한다.
     *
     * @param hex    hex string
     * @return
     */
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() == 0) {
            return null;
        }

        byte[] ba = new byte[hex.length() / 2];
        for (int i = 0; i < ba.length; i++) {
            ba[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
        }
        return ba;
    }

    /**
     * byte[] to hex : unsigned byte(바이트) 배열을 16진수 문자열로 바꾼다.
     *
     * @param ba        byte[]
     * @return
     */
    public static String byteArrayToHex(byte[] ba) {
        if (ba == null || ba.length == 0) {
            return null;
        }

        StringBuffer sb = new StringBuffer(ba.length * 2);
        String hexNumber;
        for (int x = 0; x < ba.length; x++) {
            hexNumber = "0" + Integer.toHexString(0xff & ba[x]);

            sb.append(hexNumber.substring(hexNumber.length() - 2));
        }
        return sb.toString();
    }

    /**
     * AES 256 방식의 암호화
     *
     * @param message
     * @return
     * @throws Exception
     */
    public static String encrypt(byte[] seed, byte[] seed128, String message) throws Exception {
    	
        SecretKeySpec skeySpec = new SecretKeySpec(seed, "AES");

        // Instantiate the cipher
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec, new IvParameterSpec(seed128));

        byte[] encrypted = cipher.doFinal(message.getBytes());

        return Base64.encodeToString(byteArrayToHex(encrypted).getBytes(), Base64.URL_SAFE);
    }
    
    public static String encrypt(String seed, String message) throws Exception {

//    	return encrypt(seed.getBytes(), "0000000000000000".getBytes(), message);
    	return encrypt(seed.getBytes(), seed.substring(0, 128/8).getBytes(), message);
    }
    
    public static String encryptP(String seed, String message) throws Exception {
    	
    	return encrypt(new String(Base64.decode(seed.getBytes(), Base64.URL_SAFE)), message).replaceAll("\n", "").replaceAll("\r", "");
    }

    /**
     * AES 방식의 복호화
     *
     * @param
     * @return
     * @throws Exception
     */
    public static String decrypt(byte[] seed, byte[] seed128, String encrypted) throws Exception {

        byte[] data = Base64.decode(encrypted.getBytes(), Base64.URL_SAFE);

        SecretKeySpec skeySpec = new SecretKeySpec(seed, "AES");

        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, skeySpec, new IvParameterSpec(seed128));
        byte[] original = cipher.doFinal(hexToByteArray(new String(data)));
        String originalString = new String(original);
        return originalString;
    }
    
    public static String decrypt(String seed, String encrypted) throws Exception {
    	return decrypt(seed.getBytes(), seed.substring(0, 128/8).getBytes(), encrypted);
    }
    
    public static String decryptP(String seed, String encrypted) throws Exception {
    	return decrypt(new String(Base64.decode(seed.getBytes(), Base64.URL_SAFE)), encrypted);
    }

    public static String makeKey(String baseKey){
        if(baseKey == null || baseKey.length() != 32){
            return "";
        }

        String key = Base64.encodeToString(baseKey.getBytes(), Base64.URL_SAFE);
        return key;
    }
    
    public static String makeRandomKey(){
        String baseKey = String.valueOf(Math.random()) + "abcedfghijklmn";

        String key = Base64.encodeToString(baseKey.getBytes(), Base64.URL_SAFE);
        return key;
    }
    
    
    public static void main(String[] args) {
    	
		//String key = makeKey("fkeifkeidkdk49givkfjkdjei40f94kf"); // 32자 자릿수 맞춰야함
		String key = makeRandomKey(); // 32자 자릿수 맞춰야함
		
		System.out.println(key);
		
		String str = "test String 가나다라마바사 뷁 \"하이\" ! @ # $ % ^ & * \\ \" ' + = ` | ( ) [ ] { } : ; - _ - ＃ ＆ ＆ ＠ § ※ ☆ ★ ○ ● ◎ ◇ ◆ □ ■ △ ▲ ▽ ▼ → ← ← ↑ ↓ ↔ 〓◁ ◀ ▷ ▶ ♤ ♠ ♡ ♥ ♧ ♣ ⊙ ◈ ▣ ◐ ◑ ▒ ▤ ▥ ▨ ▧ ▦ ▩ ♨ ☏ ☎ ☜ ☞ ¶ † ‡ ↕ ↗ ↙ ↖ ↘ ♭ ♩ ♪ ♬ ㉿ ㈜";

		try {
			String enc = encryptP(key, str);
			System.out.println(enc);
			System.out.println(decryptP(key, enc));
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
    
}

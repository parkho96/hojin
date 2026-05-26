/**
 *  Class Name : EgovFileScrty.java
 *  Description : Base64인코딩/디코딩 방식을 이용한 데이터를 암호화/복호화하는 Business Interface class
 *  Modification Information
 *
 *     수정일         수정자                   수정내용
 *   -------    --------    ---------------------------
 *   2009.02.04    박지욱          최초 생성
 *
 *  @author 공통 서비스 개발팀 박지욱
 *  @since 2009. 02. 04
 *  @version 1.0
 *  @see
 *
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */
package egovframework.com.utl.sim.service;

import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class EgovFileScrty {


    /**
     * 비밀번호를 암호화하는 기능(복호화가 되면 안되므로 SHA-256 인코딩 방식 적용)
     *
     * @param String data 암호화할 비밀번호
     * @return String result 암호화된 비밀번호
     * @exception Exception
     */
    public static String encryptPassword(String data) throws Exception {

		if (data == null) {
		    return "";
		}
	
		byte[] plainText = null; // 평문
		byte[] hashValue = null; // 해쉬값
		plainText = data.getBytes();
	
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(plainText);
		hashValue = md.digest(plainText);
		return new String(Base64.encodeBase64(hashValue));
    }
    
    public strictfp static String decrypt(String ciphertext, String passphrase) {
        try {
            final int keySize = 256;
            final int ivSize = 128;
 
            // 텍스트를 BASE64 형식으로 디코드 한다.
            byte[] ctBytes = Base64.decodeBase64(ciphertext.getBytes("UTF-8"));
 
            // 솔트를 구한다. (생략된 8비트는 Salted__ 시작되는 문자열이다.) 
            byte[] saltBytes = Arrays.copyOfRange(ctBytes, 8, 16);
           //System.out.println( Hex.encodeHexString(saltBytes) );
            
            // 암호화된 테스트를 구한다.( 솔트값 이후가 암호화된 텍스트 값이다.)
            byte[] ciphertextBytes = Arrays.copyOfRange(ctBytes, 16, ctBytes.length);
                       
            // 비밀번호와 솔트에서 키와 IV값을 가져온다.
            byte[] key = new byte[keySize / 8];
            byte[] iv = new byte[ivSize / 8];
            EvpKDF(passphrase.getBytes("UTF-8"), keySize, ivSize, saltBytes, key, iv);
            
            // 복호화 
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, new SecretKeySpec(key, "AES"), new IvParameterSpec(iv));
            byte[] recoveredPlaintextBytes = cipher.doFinal(ciphertextBytes);
 
            return new String(recoveredPlaintextBytes);
        } catch (IllegalArgumentException e) {
            log.error("Base64 decoding failed", e);
        } catch (GeneralSecurityException e) {
            log.error("Cryptography error occurred", e);
        } catch (Exception e) {
            // 예상치 못한 시스템 오류 처리
            log.error("Unexpected error during decryption", e);
        }
 
        return null;
    }
    
    
    private static byte[] EvpKDF(byte[] password, int keySize, int ivSize, byte[] salt, byte[] resultKey, byte[] resultIv) throws NoSuchAlgorithmException {
        return EvpKDF(password, keySize, ivSize, salt, 1, "MD5", resultKey, resultIv);
    }
 
    private strictfp static byte[] EvpKDF(byte[] password, int keySize, int ivSize, byte[] salt, int iterations, String hashAlgorithm, byte[] resultKey, byte[] resultIv) throws NoSuchAlgorithmException {
        keySize = keySize / 32;
        ivSize = ivSize / 32;
        int targetKeySize = keySize + ivSize;
        byte[] derivedBytes = new byte[targetKeySize * 4];
        int numberOfDerivedWords = 0;
        byte[] block = null;
        MessageDigest hasher = MessageDigest.getInstance(hashAlgorithm);
        while (numberOfDerivedWords < targetKeySize) {
            if (block != null) {
                hasher.update(block);
            }
            hasher.update(password);            
            // Salting 
            block = hasher.digest(salt);
            hasher.reset();
            // Iterations : 키 스트레칭(key stretching)  
            for (int i = 1; i < iterations; i++) {
                block = hasher.digest(block);
                hasher.reset();
            }
            System.arraycopy(block, 0, derivedBytes, numberOfDerivedWords * 4, Math.min(block.length, (targetKeySize - numberOfDerivedWords) * 4));
            numberOfDerivedWords += block.length / 4;
        }
        System.arraycopy(derivedBytes, 0, resultKey, 0, keySize * 4);
        System.arraycopy(derivedBytes, keySize * 4, resultIv, 0, ivSize * 4);
        return derivedBytes; // key + iv
    }   
}
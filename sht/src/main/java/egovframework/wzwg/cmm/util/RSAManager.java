package egovframework.wzwg.cmm.util;

import java.io.*;
import java.security.*;
import java.security.spec.*;

import javax.crypto.*;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
 

public class RSAManager {
	
	public static void genKeyRsa(HttpServletRequest request){ 
		// 서버측 키 파일 생성 하기
		PublicKey publicKey1 = null;
		PrivateKey privateKey1 = null;
		
		SecureRandom secureRandom = new SecureRandom();
		KeyPairGenerator keyPairGenerator;
		try {
			keyPairGenerator = KeyPairGenerator.getInstance("RSA");
		keyPairGenerator.initialize(2048, secureRandom);
		
		KeyPair keyPair = keyPairGenerator.genKeyPair();
		publicKey1 = keyPair.getPublic();
		privateKey1 = keyPair.getPrivate();
		
		KeyFactory keyFactory1 = KeyFactory.getInstance("RSA");
		RSAPublicKeySpec rsaPublicKeySpec = keyFactory1.getKeySpec(publicKey1, RSAPublicKeySpec.class);
		RSAPrivateKeySpec rsaPrivateKeySpec = keyFactory1.getKeySpec(privateKey1, RSAPrivateKeySpec.class);
		 
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		}
        
        byte[] bPublicKey1 = publicKey1.getEncoded();
        String sPublicKey1 = Base64.encodeBase64String(bPublicKey1);

        byte[] bPrivateKey1 = privateKey1.getEncoded();
        String sPrivateKey1 = Base64.encodeBase64String(bPrivateKey1);

        try {
            BufferedWriter bw1 = new BufferedWriter(new FileWriter(request.getServletContext().getRealPath("")+"/key/PublicKey.txt"));
            bw1.write(sPublicKey1);
            bw1.newLine();
            bw1.close();
            BufferedWriter bw2 = new BufferedWriter(new FileWriter(request.getServletContext().getRealPath("")+"/key/PrivateKey.txt"));
            bw2.write(sPrivateKey1);
            bw2.newLine();
            bw2.close();
        } catch (IOException e) {
        	e.printStackTrace();
        }
        
	}
	
	public static String encryptRsa(HttpServletRequest request,String sPlain1 ) throws Exception{
	      String sPublicKey2 = null; 
	          
	      BufferedReader brPublicKey = null; 
	      try {
	          brPublicKey = new BufferedReader(new FileReader(request.getServletContext().getRealPath("")+"/key/PublicKey.txt"));
	          sPublicKey2 = brPublicKey.readLine();   // First Line Read 
	      } catch (IOException e) {
	          e.printStackTrace();
	      } finally {
	          try {
	              if (brPublicKey != null)
	                  brPublicKey.close(); 
	          } catch (IOException e) {
	              e.printStackTrace();
	          }
	      }
 
		 byte[] bPublicKey2 = Base64.decodeBase64(sPublicKey2.getBytes());
	      PublicKey  publicKey2 = null;
	           
	          
	      try {
	          KeyFactory keyFactory2 = KeyFactory.getInstance("RSA");
	              
	          X509EncodedKeySpec publicKeySpec 

	                                          = new X509EncodedKeySpec(bPublicKey2);
	          publicKey2 = keyFactory2.generatePublic(publicKeySpec);
	              
	       
	      
	      } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
	          e.printStackTrace();
	      }
 
		 Cipher cipher = Cipher.getInstance("RSA");

         // 공개키 이용 암호화
         cipher.init(Cipher.ENCRYPT_MODE, publicKey2);
         byte[] bCipher1 = cipher.doFinal(sPlain1.getBytes());
         String sCipherBase64 = Base64.encodeBase64String(bCipher1);
         return sCipherBase64;
	}
	
	public static String decryptRsa(HttpServletRequest request,String sCipherBase64  ) throws Exception{ 
	      String sPublicKey2 = null;
	      String sPrivateKey2 = null;
	           
	      BufferedReader brPrivateKey = null;
	      try {
	         
	          brPrivateKey = new BufferedReader(new FileReader(request.getServletContext().getRealPath("")+"/key/PrivateKey.txt"));
	          sPrivateKey2 = brPrivateKey.readLine(); // First Line Read
	      } catch (IOException e) {
	          e.printStackTrace();
	      } finally {
	          try { 
	              if (brPrivateKey != null)
	                  brPrivateKey.close();
	          } catch (IOException e) {
	              e.printStackTrace();
	          }
	      }
 
	          
	      byte[] bPrivateKey2 = Base64.decodeBase64(sPrivateKey2.getBytes());
	      PrivateKey privateKey2 = null;
	          
	      try {
	          KeyFactory keyFactory2 = KeyFactory.getInstance("RSA");
	              
	          PKCS8EncodedKeySpec privateKeySpec 
	                                          = new PKCS8EncodedKeySpec(bPrivateKey2);
	          privateKey2 = keyFactory2.generatePrivate(privateKeySpec);
	      
	      } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
	          e.printStackTrace();
	      }

		 Cipher cipher = Cipher.getInstance("RSA");

		 // 개인키 이용 복호화
         byte[] bCipher2 = Base64.decodeBase64(sCipherBase64.getBytes());
         cipher.init(Cipher.DECRYPT_MODE, privateKey2);
         byte[] bPlain2 = cipher.doFinal(bCipher2);
         String sPlain2 = new String(bPlain2);
         return sPlain2;

	}
}

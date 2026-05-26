package egovframework.com.cmm.crypto;

import org.egovframe.rte.fdl.crypto.EgovEnvCryptoService;
import org.egovframe.rte.fdl.crypto.config.EgovCryptoConfiguration;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import lombok.extern.slf4j.Slf4j;
 @Slf4j
public class EgovEnvCryptoUserTest {
 
	public static void main(String[] args) {
 
		String[] arrCryptoString = { 
		"wizbuilder",         //데이터베이스 접속 계정 설정
		"dnlwmdnlrm#123",   //데이터베이스 접속 패드워드 설정
		"jdbc:CUBRID:49.247.4.173:30000:WIZBUILDER_DEV:::",            //데이터베이스 접속 주소 설정
		"cubrid.jdbc.driver.CUBRIDDriver"  //데이터베이스 드라이버
              };
 
 
		log.info("------------------------------------------------------");
		/* context-crypto-test.xml에는 messageSource만 있음. 암복호화 빈은 EgovCryptoConfiguration + egovframework/egovProps/conf/egov-crypto-config.properties */
		try (AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(EgovCryptoConfiguration.class)) {
			EgovEnvCryptoService cryptoService = context.getBean(EgovEnvCryptoService.class);
			log.info("------------------------------------------------------");
 
		String label = "";
		try {
			for(int i=0; i < arrCryptoString.length; i++) {		
				if(i==0)label = "사용자 아이디";
				if(i==1)label = "사용자 비밀번호";
				if(i==2)label = "접속 주소";
				if(i==3)label = "데이터 베이스 드라이버";
				log.info(label+" 원본(orignal):" + arrCryptoString[i]);
				log.info(label+" 인코딩(encrypted):" + cryptoService.encrypt(arrCryptoString[i]));
				log.info("------------------------------------------------------");
			} 
		} catch (IllegalArgumentException e) { 
			log.error("["+e.getClass()+"] IllegalArgumentException : " + e.getMessage());
		} catch (Exception e) {
			log.error("["+e.getClass()+"] Exception : " + e.getMessage());
		}
		}
	}

}
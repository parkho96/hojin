package egovframework.com.utl.fcc.service;

import org.egovframe.rte.fdl.crypto.EgovEnvCryptoService;

import egovframework.com.cmm.service.EgovProperties;
import jakarta.annotation.Resource;
import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;
import lombok.extern.slf4j.Slf4j;
@Slf4j
public class MailAuthorize extends Authenticator {
	
	@Resource(name = "egovEnvCryptoService")
    private EgovEnvCryptoService cryptoService;
	
	PasswordAuthentication pwAuthentication;

    public MailAuthorize(){ 

	    // 1. 설정값 가져오기
        String encryptedId = EgovProperties.getProperty("mail.id");
        String encryptedPw = EgovProperties.getProperty("mail.passwd");

        // 2. Sparrow 대응: null 및 서비스 주입 여부 체크
        if (cryptoService != null && encryptedId != null && encryptedPw != null) {
            try {
                String mailId = cryptoService.decrypt(encryptedId);
                String mailPw = cryptoService.decrypt(encryptedPw);
                
                if (mailId != null && mailPw != null) {
                    pwAuthentication = new PasswordAuthentication(mailId, mailPw);
                }
            } catch (RuntimeException e) {
            	log.error("Mail credentials decryption failed: {}", e.getMessage());
            }catch (Exception e) {
                log.error("An unexpected error occurred during mail initialization", e);
            }
        }else {
        	log.warn("Mail properties or CryptoService is missing.");
        }
    }

    // 시스템에서 사용하는 인증정보
    public PasswordAuthentication getPasswordAuthentication() {

        return pwAuthentication;

    }

} 
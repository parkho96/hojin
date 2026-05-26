/**
 * @Class Name  : EgovStringUtil.java
 * @Description : 문자열 데이터 처리 관련 유틸리티
 * @Modification Information
 *
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2009.01.13     박정규          최초 생성
 *   2009.02.13     이삼섭          내용 추가
 *
 * @author 공통 서비스 개발팀 박정규
 * @since 2009. 01. 13
 * @version 1.0
 * @see
 *
 */

package egovframework.com.utl.fcc.service;
 
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;
import java.util.Properties;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import jakarta.activation.DataHandler;
import jakarta.activation.FileDataSource;
import jakarta.annotation.Resource;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import jakarta.mail.internet.MimeUtility;
import lombok.extern.slf4j.Slf4j;
@Slf4j
public class EgovMailUtil {

    @Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;

    public void mailSend(String user, String subject, String content, MultipartHttpServletRequest multiRequest) throws UnsupportedEncodingException{

        Properties props = System.getProperties();
 
        props.put("mail.smtp.host",  EgovProperties.getProperty("mail.smtp.host")); 
        props.put("mail.smtp.port", EgovProperties.getProperty("mail.smtp.port")); 
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable",  EgovProperties.getProperty("mail.isSSL"));
        props.put("mail.smtp.starttls.enable",  EgovProperties.getProperty("mail.isTLS"));  
        
        if(EgovProperties.getProperty("mail.isSSL").equals("true")){
            props.put("mail.smtp.ssl.trust", EgovProperties.getProperty("mail.smtp.host"));
        }

        Authenticator auth = new MailAuthorize(); 
        Session session = Session.getDefaultInstance(props, auth);
        session.setDebug(false);

        try{ 
	
        	Message msg = new MimeMessage(session);
	        msg.setFrom(new InternetAddress(EgovProperties.getProperty("mail.send.email"))); 
	        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user));
	        msg.setSubject(subject);
	        msg.setText(content); 
	
	        MimeMultipart mp = new MimeMultipart();
	        MimeBodyPart part = new MimeBodyPart(); 
	        part.setContent(content,"text/html;charset=utf-8");
	        part.setHeader("Content-Transfer-Encoding","base64"); 
	        mp.addBodyPart(part);

	        Iterator<String> itr = multiRequest.getFileNames();
	
	        MultipartFile mf = null;
	        String origName = "";
	        String filePath = "";
	
	        int i=0;
	        while(itr.hasNext()){
	        	part = new MimeBodyPart();
	        	mf = multiRequest.getFile(itr.next());

	            if (mf == null || mf.isEmpty()) {
	                log.warn("Empty multiRequest skipped");
	                continue;
	            }
	            
	            String originalFilename = mf.getOriginalFilename();
	            if (originalFilename != null && !originalFilename.isEmpty()) {
	                origName = new String(originalFilename.getBytes("UTF-8")); 
	            } else {
	                log.warn("Empty filename skipped");
	                continue;
	            }
	            
		        String whiteFileExtStr = "";
	            whiteFileExtStr = EgovProperties.getProperty("Globals.WhiteFileExt");
	            
	            if(whiteFileExtStr != null && whiteFileExtStr.indexOf(origName.toLowerCase().trim()) > -1) {
	            	if(!origName.equals("")){
			        	i++;
			        	String fileStre = multiRequest.getSession().getServletContext().getRealPath("")+"/upload/email/"+multiRequest.getSession().getAttribute("SITE_SEQ")+"/";
			        	File fileStreDir = new File(fileStre);
			        	if(!fileStreDir.exists()){
			        		 if(!fileStreDir.mkdirs()) {
			        			 log.info(fileStreDir+" : directory make fail ");
			        		 }
			        	}
			            filePath = fileStreDir+"/"+getTimeStamp()+i; 
			            File file = new File(filePath);
			            
			            if (file != null && mf != null) {
				            try {
				            	mf.transferTo(file);
					        } catch (IllegalStateException e) { 
					    	    log.error("IllegalStateException : "+e);
					        } catch (IOException e) {
					    	    log.error("IOException : "+e);
					        }
			            }
			            
			            FileDataSource fds = new FileDataSource(filePath);
			            part.setDataHandler(new DataHandler(fds));
			
			            try {
			            	part.setFileName(MimeUtility.encodeText(origName));
				        } catch (UnsupportedEncodingException e) { 
				    	    log.error("UnsupportedEncodingException : "+e);
				        }
		
			            mp.addBodyPart(part);
	            	}
	             } else {
		        	try {
						fileUtil.deleteFile(EgovWebUtil.filePathBlackList(filePath));
					} catch (FileNotFoundException e) {
						// TODO Auto-generated catch block
						log.error("FileNotFoundException : ",e);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						log.error("IOException : ",e);
					}
	            }
	
	        }
	
	        msg.setContent(mp,"text/html; charset=utf-8");
			msg.setSentDate(new Date());
			Transport.send(msg);  
        }catch (AddressException addr_e) {  //주소를 입력하지 않을 경우
        	log.error("AddressException : "+addr_e);

        }catch (MessagingException msg_e) { //메시지에 이상이 있을 경우
        	log.error("AddressException : "+msg_e);
        }

    }

 
	 public void mailSend(String user, String subject, String content) throws UnsupportedEncodingException{

        Properties props = System.getProperties();


        //properties.put("mail.smtp.auth","false"); //인증없이 자체 smtp를 사용할 경우

        //properties.put("mail.smtp.host", "mail.wiz-wig.com"); 

        //properties.put("mail.smtp.port", "25"); 
       
        props.put("mail.smtp.host",  EgovProperties.getProperty("mail.smtp.host")); 
        props.put("mail.smtp.port", EgovProperties.getProperty("mail.smtp.port")); 
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable",  EgovProperties.getProperty("mail.isSSL"));
        props.put("mail.smtp.starttls.enable",  EgovProperties.getProperty("mail.isTLS"));  
        
        if("true".equals(EgovProperties.getProperty("mail.isSSL"))){
            props.put("mail.smtp.ssl.trust", EgovProperties.getProperty("mail.smtp.host"));
        }

        Authenticator auth = new MailAuthorize(); 

        Session session = Session.getDefaultInstance(props, auth);


        session.setDebug(false);

        try{ 
			
			 Message msg = new MimeMessage(session);
			 msg.setFrom(new InternetAddress(EgovProperties.getProperty("mail.send.email"))); 
			
			 msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user));
			
			 msg.setSubject(subject);
			
			 msg.setText(content); 
			
			 MimeMultipart mp = new MimeMultipart();
			
			 MimeBodyPart part = new MimeBodyPart(); 
			 part.setContent(content,"text/html;charset=utf-8");
			
			 part.setHeader("Content-Transfer-Encoding","base64"); 
			
			 mp.addBodyPart(part);
			 
			 msg.setContent(mp,"text/html; charset=utf-8");
			
			 msg.setSentDate(new Date());
			
			
			 Transport.send(msg);  

        }catch (AddressException addr_e) {  //주소를 입력하지 않을 경우
        	log.error("AddressException : "+addr_e);

        }catch (MessagingException msg_e) { //메시지에 이상이 있을 경우
        	log.error("MessagingException : "+msg_e);

        }

    } 


    private String getTimeStamp() {

    	String rtnStr = null;

    	// 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
    	String pattern = "yyyyMMddhhmmssSSS";

	    SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
	    Timestamp ts = new Timestamp(System.currentTimeMillis());

	    rtnStr = sdfCurrent.format(ts.getTime());

    	return rtnStr;
    }
 


}

package egovframework.com.cmm.web;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.util.RSAManager;
import egovframework.wzwg.cmm.util.SecureAES256;




@Controller

public class LicenseInfoController {
    
    @RequestMapping("/genLicenseInfoForm.do")
    public String genLicenseInfoForm(  HttpServletRequest request
            , Model model) throws Exception {

        
        return "wzwg/cmm/license/getLicenseForm";
    }
    
    @RequestMapping("/genLicenseInfo.do")
    public void selectPageCallCtrl(  HttpServletRequest request
    		, HttpServletResponse response
            , Model model) throws Exception {
    	String ip = request.getParameter("ip");
    	String date = request.getParameter("date");
    	String siteCnt = request.getParameter("siteCnt");
    	String key="wizbuilder3.5www.wiz-builder.com";
    	key =  SecureAES256.makeKey(key);
    	String license=ip+"wizwig"+date+"wizwig"+siteCnt;
    	String encText1 = SecureAES256.encryptP(key, license);
    	String encLicense1 =key+"wizwig"+encText1 ; 
    	//RSAManager.genKeyRsa(request); 
    	String encText2 = RSAManager.encryptRsa(request,encLicense1);
    	
    	 response.setContentType("application/octet-stream");
    	  response.setHeader("Content-Disposition", "attachment;filename=license.txt;");
    	  ServletOutputStream outwr = response.getOutputStream();
    	  outwr.write(encText2.getBytes());
    	  outwr.close();
    }
} 
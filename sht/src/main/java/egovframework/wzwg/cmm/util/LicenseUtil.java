package egovframework.wzwg.cmm.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public class LicenseUtil {
    protected final static Log LOG = LogFactory.getLog(LicenseUtil.class);
	public static String getLicenseInfo(HttpServletRequest request) throws Exception{ 
		BufferedReader brPrivateKey = null;
		FileReader brFileReader=null;
		String decStr ="";
		try {
			brFileReader=new FileReader(request.getServletContext().getRealPath("")+"/license/license.txt");
			brPrivateKey = new BufferedReader(brFileReader);
			String license = brPrivateKey.readLine(); // First Line Read
			String decText = RSAManager.decryptRsa(request,license);
			String[] decArray =decText.split("wizwig");
			String key = decArray[0];

		 	decStr =SecureAES256.decryptP(decArray[0], decArray[1]);
		}catch (IOException e) {
			LOG.error(e);
		}finally {
			brFileReader.close();
			brPrivateKey.close();
		}
		return decStr;

	}
}

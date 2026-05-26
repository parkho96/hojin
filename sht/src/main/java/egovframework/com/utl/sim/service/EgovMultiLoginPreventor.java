package egovframework.com.utl.sim.service;

import java.util.Enumeration;
import java.util.concurrent.ConcurrentHashMap;

import jakarta.servlet.http.HttpSession;
 
public class EgovMultiLoginPreventor {
    public static final ConcurrentHashMap<String, HttpSession> loginUsers = new ConcurrentHashMap<String, HttpSession>();
 
    public static boolean findByLoginId(String loginId){
        return loginUsers.containsKey(loginId);
    }
 
    public static void invalidateByLoginId(String loginId){
        Enumeration<String> e = loginUsers.keys();
        while (e.hasMoreElements()){
            String key = (String) e.nextElement();
            if (key.equals(loginId)){
               // loginUsers.get(key).invalidate();
            	HttpSession saveSession = loginUsers.get(key); 
            	if (saveSession != null) { // null 체크 추가
	            	saveSession.removeAttribute("loginVO");
	            	saveSession.setAttribute("logout", "Y");
	            	
	                EgovMultiLoginPreventor.loginUsers.remove(loginId, saveSession); // saveSession == loginUsers.get(loginId)와 같음

	                String sadminAt =  String.valueOf(saveSession.getAttribute("SADMIN_AT"));
	                String nadminAt =  String.valueOf(saveSession.getAttribute("NADMIN_AT"));
	                
	                if(sadminAt != null && sadminAt.equals("true")) {
	                	saveSession.removeAttribute("SADMIN_AT");
	                }
	                if(nadminAt != null && nadminAt.equals("true")) {
	                	saveSession.removeAttribute("NADMIN_AT");
	                }
	                
	                saveSession.setAttribute("OtherLoginAt", "Y");
            	}
            }
        }
    }
}


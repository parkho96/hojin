package egovframework.com.utl.sim.service;

import java.util.Enumeration;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionBindingEvent;
import jakarta.servlet.http.HttpSessionBindingListener;
 
public class EgovHttpSessionBindingListener implements HttpSessionBindingListener{
 
    @Override
    public void valueBound(HttpSessionBindingEvent event){ 
     
        if (EgovMultiLoginPreventor.findByLoginId(event.getName())){
            EgovMultiLoginPreventor.invalidateByLoginId(event.getName());
        }
            EgovMultiLoginPreventor.loginUsers.put(event.getName(), event.getSession());
    }
 
    @Override
    public void valueUnbound(HttpSessionBindingEvent event) {  
    		// EgovMultiLoginPreventor.loginUsers.remove(event.getName(), event.getSession()); 
    }
}

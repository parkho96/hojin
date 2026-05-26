package egovframework.com.cmm.context;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SpringApplicationContext implements ApplicationContextAware {
 
  	private static ApplicationContext CONTEXT;
	
	public SpringApplicationContext() {
		log.info("init SpringApplicationContext");
	}
	
	public void setApplicationContext(ApplicationContext context) throws BeansException {
		CONTEXT = context;
	}
 
	public static Object getBean(String beanName) {
		return CONTEXT.getBean(beanName);
	}
	
	public static <T> T getBean(String beanName, Class<T> requiredType) {
		return CONTEXT.getBean(beanName, requiredType);
	}
}
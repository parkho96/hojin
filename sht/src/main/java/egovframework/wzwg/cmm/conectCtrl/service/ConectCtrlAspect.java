//package egovframework.wzwg.cmm.conectCtrl.service;
//
//import java.lang.reflect.Method;
//import java.util.HashMap;
//
//import org.aspectj.lang.JoinPoint;
//import org.aspectj.lang.annotation.Aspect;
//import org.aspectj.lang.annotation.Before;
//import org.springframework.stereotype.Component;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//@Aspect
//@Component
//public class ConectCtrlAspect {
//
//	@Before(value="execution(* egovframework.wzwg.cmm.conectCtrl.web(..))")
//    public void doBeforeProfiling(JoinPoint jp) throws Throwable {
//
//        HashMap urlLogger = new HashMap();
//        Method[] methods =  jp.getTarget().getClass().getMethods();
//        for ( Method method : methods) {
//            if ( method.getName().equals( jp.getSignature().getName()))
//            {
//                String[] values = method.getAnnotation( RequestMapping.class).value();
//                urlLogger.put("url", values[0]);
//            }
//        }
//        urlLogger.get( "url");
//        
//    }
//
//}
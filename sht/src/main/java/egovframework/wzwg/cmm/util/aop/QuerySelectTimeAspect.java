package egovframework.wzwg.cmm.util.aop;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Aspect
@Component
@Slf4j
public class QuerySelectTimeAspect {

	@Around("execution(* egovframework..*DAO.*(..))")
	public Object aroundAdvice(ProceedingJoinPoint pjp) throws Throwable {
        
		StopWatch sw = new StopWatch();
		sw.start();
 
		Object[] signatureArgs = pjp.getArgs();
		Object result = pjp.proceed();

		sw.stop();
		
		
		Long total = sw.getTotalTimeMillis();

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat todayFormat = new SimpleDateFormat("yyyyMMdd");

		Date time = new Date();
		String strTime = format.format(time) + "\r\n";
		String strToday = todayFormat.format(time);
 
		String className = pjp.getTarget().getClass().getName();
		String methodName = pjp.getSignature().getName();
		String taskName = "[ExecutionTime] " + className + "." + methodName + ", " + total + "(ms)\r\n";
		String gubun = "=====================================================\r\n";
		
		

		if (total >= 1000) {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
					.getRequest();

			String realPath = request.getServletContext().getRealPath("/");
			String siteDirStr = realPath + "QueryExecuteLog";
			String strParameter = "";
			File siteDir = new File(siteDirStr);
			if (!siteDir.exists()) {
				siteDir.mkdirs();
			}
			File file = new File(siteDir + "/QueryExecuteLog" + strToday + ".txt");
			FileWriter writer = null;

			try {
				writer = new FileWriter(file, true);
				writer.write(gubun);
				writer.write(strTime);
				writer.write(taskName);
				for (Object signatureArg : signatureArgs) {
					
					if(signatureArg instanceof String) {
						strParameter = "[Parameters] : " + signatureArg + "\r\n";
					}else {
						strParameter = "[Parameters] : " + ToStringBuilder.reflectionToString(signatureArg,CustomToStringStyle.MULTI_LINE_JSON_STYLE) + "\r\n";
					}
					
					writer.write(strParameter);
				}

				writer.write(gubun);
				writer.flush();

			} catch (IOException e) {
				log.error("IOException",e);
			} finally {
				try {
					if (writer != null)
						writer.close();
				} catch (IOException e) {
					log.error("IOException occurred while closing writer", e);
				}

			}
		}

		return result;
	}

}

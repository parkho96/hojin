package egovframework.com.utl.fcc.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;

import egovframework.com.cmm.service.EgovProperties;
import org.egovframe.rte.fdl.string.EgovDateUtil;

@Slf4j
public class ExcelCreater {

    /**
     * JXLS를 이용한 엑셀 다운로드 공통 메서드
     * @param request      HttpServletRequest
     * @param response     HttpServletResponse
     * @param beans        엑셀에 주입할 데이터 맵 (Key: 템플릿에서 사용할 변수명, Value: 객체 또는 리스트)
     * @param propertyName 템플릿 경로가 설정된 egovProperty 키값
     * @param fileName     다운로드될 파일명 (날짜와 확장자는 자동 부여)
     */
    public static void excelCreate(HttpServletRequest request, HttpServletResponse response, Map<String, Object> beans, String propertyName, String fileName) throws Exception {
        
        // 1. 템플릿 파일 경로 파악
        String templatePath = request.getSession().getServletContext().getRealPath("/") + EgovProperties.getProperty(propertyName);
        File uFile = new File(templatePath);
		log.debug("Excel propertyName: {}", EgovProperties.getProperty(propertyName));

        if (!uFile.exists()) {
            log.error("Excel Template File Not Found: {}", templatePath);
            throw new RuntimeException("엑셀 템플릿 파일을 찾을 수 없습니다.");
        }

        // 2. 다운로드 파일명 생성 (파일명-현재시간.xlsx)
        String fullFileName = fileName + "-" + EgovDateUtil.getCurrentDateTimeAsString() + ".xlsx";
        String encodedFileName = URLEncoder.encode(fullFileName, StandardCharsets.UTF_8).replaceAll("\\+", "%20");

        // 3. Response Header 설정 (Jakarta EE / Spring Boot 3 대응)
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\";");

        // 4. JXLS 처리
        try (InputStream is = new FileInputStream(uFile);
             OutputStream os = response.getOutputStream()) {
            
            // JXLS Context 생성 및 데이터 주입
            Context context = new Context();
            if (beans != null) {
				log.debug("beans data: {}", beans);
                beans.forEach(context::putVar);
            }

            log.debug("Excel Creation Started: {}", fullFileName);

            /* 
             * JxlsHelper.processTemplate 핵심 로직:
             * - 템플릿 파일의 jx:area 및 jx:each 등 메모 태그를 자동으로 파싱합니다.
             * - 수식을 자동으로 처리하며, 데이터 양에 따라 셀 영역을 동적으로 확장합니다.
             */
			JxlsHelper jxlsHelper = JxlsHelper.getInstance();
			
			// 이 설정을 추가하면 ${list.statDate} 와 같은 JEXL 표현식을 강제로 빌드하고 해석합니다.
			jxlsHelper.setUseFastFormulaProcessor(false); 
			
			// 템플릿 실행
			jxlsHelper.processTemplate(is, os, context);
            
            os.flush();
            log.debug("Excel Creation Completed");
            
        } catch (Exception e) {
            log.error("Excel Creation Error: {}", e.getMessage());
            throw e;
        }
    }
}
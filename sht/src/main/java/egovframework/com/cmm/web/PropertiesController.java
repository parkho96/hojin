package egovframework.com.cmm.web;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PropertiesController {
		
	@RequestMapping("/properties/{propertiesName}")
	public void getProperties(@PathVariable String propertiesName, HttpServletResponse response) throws IOException {
		InputStream inputStream = null;
		OutputStream outputStream = null;
		try {
		if(propertiesName != null && propertiesName.indexOf("_")>-1){
			outputStream = response.getOutputStream();
			
			String resourcePath = "egovframework/message/com/"+propertiesName;
			
			// 만약 파일명에 .properties가 포함되어 있지 않을 때만 붙여주도록 수정
			if (!resourcePath.endsWith(".properties")) {
				resourcePath += ".properties";
			}
		Resource resource = new ClassPathResource(resourcePath );
		//  "src/main/resources/" + 
			inputStream = resource.getInputStream();
		
		@SuppressWarnings("unchecked")
		List<String> readLines = IOUtils.readLines(inputStream);
		IOUtils.writeLines(readLines, null, outputStream);
		IOUtils.closeQuietly(inputStream);
		IOUtils.closeQuietly(outputStream);
		}
		}catch (IOException e) {
				// TODO: handle exception
				log.error("IOException",e);
			}finally {
				if(inputStream != null) try { inputStream.close(); } catch(IOException e) {log.error("IOException",e);}
				if(outputStream != null) try { outputStream.close(); } catch(IOException e) {log.error("IOException",e);}
			}
		
	}
	
	@RequestMapping("/wzwg/properties/{propertiesDir}/{propertiesName}")
	public void getWzWgProperties(@PathVariable String propertiesName,@PathVariable String propertiesDir, HttpServletResponse response, HttpServletRequest request) throws IOException {
		InputStream inputStream = null;
		OutputStream outputStream = null;
		
		String urlPath = request.getServletPath() + "?" +request.getQueryString();
		String fileName = FilenameUtils.getName(urlPath);
		
		if(fileName.indexOf("properties") == -1) {
			//프로퍼티 일 경우에만 통과 시킴
			return;
		}
		
		try {
			if(propertiesName != null && propertiesName.indexOf("_")>-1){
				outputStream = response.getOutputStream();
				String resourcePath = "egovframework/message/wzwg/"+propertiesDir+"/"+propertiesName;
				
				// 만약 파일명에 .properties가 포함되어 있지 않을 때만 붙여주도록 수정
				if (!resourcePath.endsWith(".properties")) {
					resourcePath += ".properties";
				}
			Resource resource = new ClassPathResource(resourcePath);
			//  "src/main/resources/" + 
				inputStream = resource.getInputStream();
			
			@SuppressWarnings("unchecked")
			List<String> readLines = IOUtils.readLines(inputStream);
			IOUtils.writeLines(readLines, null, outputStream);
			IOUtils.closeQuietly(inputStream);
			IOUtils.closeQuietly(outputStream);
			}
		}catch (IOException e) {
			// TODO: handle exception
				log.error("IOException",e);
		}finally {
			if(inputStream != null) try { inputStream.close(); } catch(IOException e) {log.error("IOException",e);}
			if(outputStream != null) try { outputStream.close(); } catch(IOException e) {log.error("IOException",e);}
		}
	}
} 
package egovframework.wzwg.cmm.util;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JacksonMapperUtil {
	static ObjectMapper m = new ObjectMapper();

	public static Map<String, Object> convertJsonToMap(String jsonString){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map = m.readValue(jsonString, new TypeReference<Map<String,Object>>() {} );
		} catch (JsonParseException e) {
			// TODO Auto-generated JsonParseException block
			log.error("JsonParseException",e);
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			log.error("JsonMappingException",e);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.error("IOException",e);
		}catch (NullPointerException e) {
			// TODO Auto-generated catch block
			log.error("NullPointerException",e);
		}catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			log.error("NumberFormatException",e);
		}
		
		return map;
	}
	
	public static String convertMapToJson(Object o) {
		try {
			return m.writeValueAsString(o);
		} catch (JsonProcessingException e) {
			//e.printStackTrace();
			log.error("JsonProcessingException",e);
		}
		
		return null;
	}
}

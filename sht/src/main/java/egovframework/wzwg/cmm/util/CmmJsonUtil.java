package egovframework.wzwg.cmm.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
 
import jakarta.servlet.http.HttpServletRequest;

//import org.codehaus.jackson.map.ObjectMapper;
//import org.json.simple.JSONArray;
//import org.json.simple.JSONObject;
//import org.json.simple.parser.JSONParser;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;

public class CmmJsonUtil {

	public CmmJsonUtil() {
		super();
	}

	private static final ObjectMapper mapper = new ObjectMapper();
	
	/*private static Object getInputStreamByJsonObject(HttpServletRequest request) throws Exception {

	    String body = null;
	    StringBuilder stringBuilder = new StringBuilder();
	    BufferedReader bufferedReader = null;
	    Object obj = null;
	    
	    try {
	        InputStream inputStream = request.getInputStream();
	        if (inputStream != null) {
	            bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
	            char[] charBuffer = new char[128];
	            int bytesRead = -1;
	            while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
	                stringBuilder.append(charBuffer, 0, bytesRead);
	            }
	        } else {
	            stringBuilder.append("");
	        }

		    body = stringBuilder.toString();
		    
		    JSONParser parser = new JSONParser();
		    obj = parser.parse(body);
	    } catch (Exception e) {
	    	e.printStackTrace();
	        throw e;
	    } finally {
	        if (bufferedReader != null) {
	            try {
	                bufferedReader.close();
	            } catch (IOException e) {
	            	e.printStackTrace();
	                throw e;
	            }
	        }
	    }
	    
	    return obj;
	}*/

    // request body 값을 json 으로 변환 List 리턴
    public static List<Object> getRequestParamToJsonClassList(HttpServletRequest request, Class classObj) throws Exception {
	    
	    // request body의 json 데이터를 가져온다
	    /*Object obj = getInputStreamByJsonObject(request);
	    
	    JSONArray jsonArray = (JSONArray)obj;

	    List<Object> resultList = new ArrayList<Object>();
	    
	    for(int i=0;i<jsonArray.size();i++){
		    JSONObject jsonObj = (JSONObject)jsonArray.get(i);
		    Object setVO = new ObjectMapper().readValue(jsonObj.toString(), classObj) ;
		    resultList.add(setVO);
	    }
	    
	    return resultList;*/
		// 1. request.getInputStream()에서 직접 List<T>로 파싱합니다.
		// 기존 getInputStreamByJsonObject와 JSONArray 변환 과정을 생략할 수 있습니다.
		try {
			// Jackson의 TypeFactory를 사용하여 List<classObj> 형태의 타입을 생성합니다.
			return mapper.readValue(
				request.getInputStream(), 
				mapper.getTypeFactory().constructCollectionType(List.class, classObj)
			);
		} catch (Exception e) {
			// 파싱 실패 시 빈 리스트 반환 또는 예외 처리
			return new ArrayList<>();
		}
    }

    // request body 값을 json 으로 변환 List 리턴
    public static JsonNode getRequestParamToJson(HttpServletRequest request) throws Exception {

	    //return (JSONObject)getInputStreamByJsonObject(request);
		try {
            // getInputStreamByJsonObject의 로직을 직접 구현하거나 호출합니다.
            // Jackson은 InputStream을 직접 읽어 JsonNode 트리로 변환하는 기능을 제공합니다.
            return mapper.readTree(request.getInputStream());
        } catch (IOException e) {
            // 로깅 처리 후 필요에 따라 예외를 던지거나 빈 노드를 반환합니다.
            throw new Exception("JSON 파싱 중 오류가 발생했습니다.", e);
        }
    }

    // json data 를 vo 로 변환
    /*public static List<Object> getJsonToKeyValueClass(JsonNode jsonNode, Class classObj, String keyNm) throws Exception {

	    JSONParser parser = new JSONParser();
	    
	    List<Object> resultList = new ArrayList<Object>();
	    
	    if (jsonObj.get(keyNm) != null) {*/
//			    String jsonValue = jsonObj.get(keyNm).toString();
//			    setVO = new ObjectMapper().readValue(jsonValue, classObj) ;

		    /*Object getObj = parser.parse(jsonObj.get(keyNm).toString());
		    JSONArray jsonArray = (JSONArray)getObj;
		    
		    for(int i=0;i<jsonArray.size();i++){
			    JSONObject getJson = (JSONObject)jsonArray.get(i);
			    Object setVO = new ObjectMapper().readValue(getJson.toString(), classObj) ;
			    resultList.add(setVO);
		    }
	    }
	    
	    return resultList;
    }*/

}

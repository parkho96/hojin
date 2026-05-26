package egovframework.wzwg.cmm.util.snsAPI.service;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.json.simple.parser.JSONParser;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
//import com.google.gson.Gson;
@Slf4j
public class KakaoRestApiHelper {

    public enum HttpMethodType { POST, GET, DELETE }

    // static 제거: 인스턴스별로 관리하여 세션 등에서 주입받을 수 있도록 함
    private String clientId;
    
    private String accessToken;
    private String adminKey;

    private static final String API_SERVER_HOST  = "https://kapi.kakao.com";
    private static final String AUTH_SERVER_HOST  = "https://kauth.kakao.com";

    private static final String USER_SIGNUP_PATH = "/v2/user/signup";
    private static final String USER_UNLINK_PATH = "/v2/user/unlink";
    private static final String USER_LOGOUT_PATH = "/v2/user/logout";
    private static final String USER_ME_PATH = "/v2/user/me";
    private static final String USER_UPDATE_PROFILE_PATH = "/v2/user/update_profile";
    private static final String USER_IDS_PATH = "/v2/user/ids";

    private static final String STORY_PROFILE_PATH = "/v2/api/story/profile";
    private static final String STORY_ISSTORYUSER_PATH = "/v2/api/story/isstoryuser";
    private static final String STORY_MYSTORIES_PATH = "/v2/api/story/mystories";
    private static final String STORY_MYSTORY_PATH = "/v2/api/story/mystory";
    private static final String STORY_DELETE_MYSTORY_PATH = "/v2/api/story/delete/mystory";
    private static final String STORY_POST_NOTE_PATH = "/v2/api/story/post/note";
    private static final String STORY_UPLOAD_MULTI_PATH = "/v2/api/story/upload/multi";
    private static final String STORY_POST_PHOTO_PATH = "/v2/api/story/post/photo";
    private static final String STORY_LINKINFO_PATH = "/v2/api/story/linkinfo";
    private static final String STORY_POST_LINK_PATH = "/v2/api/story/post/link";

    private static final String TALK_PROFILE_PATH = "/v2/api/talk/profile";

    private static final String PUSH_REGISTER_PATH = "/v2/push/register";
    private static final String PUSH_TOKENS_PATH = "/oauth/token";
    private static final String PUSH_DEREGISTER_PATH = "/v2/push/deregister";
    private static final String PUSH_SEND_PATH = "/v2/push/send";

    private static final ObjectMapper JACKSON_OBJECT_MAPPER = new ObjectMapper();
    private static final String PROPERTIES_PARAM_NAME = "properties";

    private static final List<String> adminApiPaths = new ArrayList<String>();

    static {
        adminApiPaths.add(USER_IDS_PATH);
        adminApiPaths.add(PUSH_REGISTER_PATH);
        adminApiPaths.add(PUSH_TOKENS_PATH);
        adminApiPaths.add(PUSH_DEREGISTER_PATH);
        adminApiPaths.add(PUSH_SEND_PATH);
    }

    // Getter & Setter (인스턴스 변수로 변경됨)
    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public void setAccessToken(final String accessToken) {
        this.accessToken = accessToken;
    }

    public void setAdminKey(final String adminKey) {
        this.adminKey = adminKey;
    }

    ///////////////////////////////////////////////////////////////
    // User Management
    ///////////////////////////////////////////////////////////////

    public String signup() { 
        return request(HttpMethodType.POST, USER_SIGNUP_PATH);
    }

    public String signup(final Map<String, String> params) {
        return request(HttpMethodType.POST, USER_SIGNUP_PATH, PROPERTIES_PARAM_NAME + "=" + mapToJsonStr(params));
    }

    public String unlink() {
        return request(HttpMethodType.POST, USER_UNLINK_PATH);
    }

    public String logout() {
        return request(HttpMethodType.POST, USER_LOGOUT_PATH);
    }

    public String me() {
        return request(USER_ME_PATH);
    }

    public String updatProfile(final Map<String, String> params) {
        return request(HttpMethodType.POST, USER_UPDATE_PROFILE_PATH, PROPERTIES_PARAM_NAME + "=" + mapToJsonStr(params));
    }

    public String getUserIds() {
        return request(USER_IDS_PATH);
    }

    public String getUserIds(final Map<String, String> params) {
        return request(HttpMethodType.GET, USER_IDS_PATH, mapToParams(params));
    }

    ///////////////////////////////////////////////////////////////
    // Kakao Story
    ///////////////////////////////////////////////////////////////

    public String isStoryUser() {
        return request(STORY_ISSTORYUSER_PATH);
    }

    public String storyProfile() {
        return request(STORY_PROFILE_PATH);
    }

    public String postNote(final Map<String, String> params) {
        return request(HttpMethodType.POST, STORY_POST_NOTE_PATH, mapToParams(params));
    }

    public String postLink(final Map<String, String> params) {
        return request(HttpMethodType.POST, STORY_POST_LINK_PATH, mapToParams(params));
    }

    public String postPhoto(final Map<String, String> params) {
        return request(HttpMethodType.POST, STORY_POST_PHOTO_PATH, mapToParams(params));
    }

    public String getMyStory(final Map<String, String> params) {
        return request(HttpMethodType.GET, STORY_MYSTORY_PATH, mapToParams(params));
    }

    public String getMyStories() {
        return request(STORY_MYSTORIES_PATH);
    }

    public String getMyStories(final Map<String, String> params) {
        return request(HttpMethodType.GET, STORY_MYSTORIES_PATH, mapToParams(params));
    }

    public String deleteMyStory(final String id) {
        return request(HttpMethodType.DELETE, STORY_DELETE_MYSTORY_PATH, "?id=" + id);
    }

    public String deleteMyStory(final Map<String, String> params) {
        return request(HttpMethodType.DELETE, STORY_DELETE_MYSTORY_PATH, mapToParams(params));
    }

    public String getLinkInfo(String url) {
        return request(HttpMethodType.GET, STORY_LINKINFO_PATH, "?url=" + url);
    }

    public String uploadMulti(File[] files) {
        // 1. 초기 방어 로직
        if (files == null || files.length == 0) {
            return null;
        }

        // 전송에 필요한 상수 설정
        String CRLF = "\r\n";
        String TWO_HYPHENS = "--";
        String BOUNDARY = "---------------------------012345678901234567890123456";
        int maxBufferSize = 1 * 1024 * 1024; // 1MB buffer

        HttpsURLConnection conn = null;

        try {
            // 2. 연결 설정
            URL url = new URL(API_SERVER_HOST + STORY_UPLOAD_MULTI_PATH);
            conn = (HttpsURLConnection) url.openConnection();
            conn.setDoInput(true);
            conn.setDoOutput(true);
            conn.setUseCaches(false);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Connection", "Keep-Alive");
            conn.setRequestProperty("Content-Type", "multipart/form-data;boundary=" + BOUNDARY);
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            conn.setRequestProperty("Cache-Control", "no-cache");
            
            // 타임아웃 설정 (권장: 무한 대기 방지)
            conn.setConnectTimeout(10000); 
            conn.setReadTimeout(30000);

            // 3. 자원 누수 방지를 위한 Try-with-resources (DataOutputStream)
            try (DataOutputStream dos = new DataOutputStream(conn.getOutputStream())) {
                
                for (File f : files) {
                    // 개별 파일의 시작 경계선 작성
                    dos.writeBytes(TWO_HYPHENS + BOUNDARY + CRLF);
                    // 헤더 작성 시 UTF-8 처리를 위해 write 사용 (한글 파일명 대비)
                    String header = "Content-Disposition: form-data; name=\"file\"; filename=\"" + f.getName() + "\"" + CRLF;
                    dos.write(header.getBytes(StandardCharsets.UTF_8));
                    dos.writeBytes(CRLF);

                    // 4. 개별 파일 읽기를 위한 Try-with-resources (FileInputStream)
                    // 루프 내부에서 생성되므로 각 파일마다 즉시 close됨
                    try (FileInputStream fis = new FileInputStream(f)) {
                        byte[] buffer = new byte[maxBufferSize];
                        int bytesRead;
                        while ((bytesRead = fis.read(buffer)) != -1) {
                            dos.write(buffer, 0, bytesRead);
                        }
                    } 
                    // 위 괄호를 벗어나는 순간 fis.close()가 자동으로 호출
                    
                    dos.writeBytes(CRLF);
                }

                // 요청 종료 경계선 작성
                dos.writeBytes(TWO_HYPHENS + BOUNDARY + TWO_HYPHENS + CRLF);
                dos.flush();
            } 
            // 위 괄호를 벗어나는 순간 dos.close()가 자동으로 호출됩니다.

            // 5. 응답 처리 및 응답 스트림 자원 해제
            try (InputStream inputStream = new BufferedInputStream(conn.getInputStream());
                 BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
                
                StringBuilder builder = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    builder.append(line).append("\n");
                }
                return builder.toString();
            }

        } catch (IOException ex) {
            log.error("IOException in uploadMulti", ex);
            // 에러 발생 시 에러 스트림이 있다면 읽어서 로그를 남기는 것도 좋습니다.
        } finally {
            // HttpsURLConnection은 close 대상이 아니며 disconnect()로 연결을 정리합니다.
            if (conn != null) {
                conn.disconnect();
            }
        }

        return null;
    }

    ///////////////////////////////////////////////////////////////
    // Kakao Talk
    ///////////////////////////////////////////////////////////////

    public String talkProfile() {
        return request(TALK_PROFILE_PATH);
    }

    ///////////////////////////////////////////////////////////////
    // Push Notification / OAuth Token
    ///////////////////////////////////////////////////////////////

    public String registerPush(final Map<String, String> params) {
        return request(HttpMethodType.POST, PUSH_REGISTER_PATH, mapToParams(params));
    }

    public String getPushTokens(final String code) throws Exception {
        Map<String, String> params = new HashMap<String, String>();
        
        params.put("grant_type", "authorization_code");
        // 세션에서 주입받은 인스턴스 변수 clientId 사용
        params.put("client_id", this.clientId);
        params.put("code", code);
        
        // OAuth 토큰 요청은 Auth 서버를 사용하므로 "A" 구분자 전달
        String resToken = request(HttpMethodType.POST, PUSH_TOKENS_PATH, mapToParams(params), "A");

        if (resToken == null) return "";

        JSONParser jsonParser = new JSONParser();
        org.json.simple.JSONObject jsonObject = (org.json.simple.JSONObject) jsonParser.parse(resToken);
        
        // null 체크 및 처리
        Object tokenObj = jsonObject.get("access_token");
        return tokenObj != null ? tokenObj.toString() : "";
    }

    public String deregisterPush(final Map<String, String> params) {
        return request(HttpMethodType.POST, PUSH_DEREGISTER_PATH, mapToParams(params));
    }

    public String sendPush(final Map<String, String> params) {
        return request(HttpMethodType.POST, PUSH_SEND_PATH, mapToParams(params));
    }

    ///////////////////////////////////////////////////////////////
    // Request Core
    ///////////////////////////////////////////////////////////////

    public String request(final String apiPath) {
        return request(HttpMethodType.GET, apiPath, null);
    }

    public String request(final HttpMethodType httpMethod, final String apiPath) {
        return request(httpMethod, apiPath, null);
    }

    public String request(HttpMethodType httpMethod, final String apiPath, final String params) {
        return request(httpMethod, apiPath, params, null);
    }

    public String request(HttpMethodType httpMethod, final String apiPath, final String params, final String hostSe) {

        String host = "A".equals(hostSe) ? AUTH_SERVER_HOST : API_SERVER_HOST;
        String requestUrl = host + apiPath;

        if (httpMethod == null) {
            httpMethod = HttpMethodType.GET;
        }

        // GET/DELETE 파라미터 연결
        if (params != null && params.length() > 0 && (httpMethod == HttpMethodType.GET || httpMethod == HttpMethodType.DELETE)) {
            requestUrl += (params.startsWith("?") ? params : "?" + params);
        }

        HttpsURLConnection conn = null;

        try {
            final URL url = new URL(requestUrl);
            conn = (HttpsURLConnection) url.openConnection();
            conn.setRequestMethod(httpMethod.toString());

            // Authorization 헤더 설정
            if (adminApiPaths.contains(apiPath)) {
                conn.setRequestProperty("Authorization", "KakaoAK " + this.adminKey);
            } else {
                conn.setRequestProperty("Authorization", "Bearer " + this.accessToken);
            }

            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("charset", "utf-8");

            // [자원관리 1] OutputStream 처리
            if (params != null && params.length() > 0 && httpMethod == HttpMethodType.POST) {
                conn.setDoOutput(true);
                try (OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream(), StandardCharsets.UTF_8)) {
                    writer.write(params);
                    writer.flush();
                } // 여기서 writer가 자동으로 close
            }

            final int responseCode = conn.getResponseCode();
            
            // 응답 스트림 결정 (정상 200번대 vs 에러)
            try(
        		InputStream is = (responseCode >= 200 && responseCode < 300) 
                ? conn.getInputStream() 
                : conn.getErrorStream();
    		){
                if (is != null) {
                    try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                        final StringBuilder buffer = new StringBuilder();
                        String line;
                        while ((line = reader.readLine()) != null) {
                            buffer.append(line);
                        }
                        return buffer.toString();
                    }
                }
            }
            
        } catch (IOException e) {
            log.error("IOException in request: " + apiPath, e);
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
        return null;
    }

    public String urlEncodeUTF8(String s) {
        try {
            return URLEncoder.encode(s, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new UnsupportedOperationException(e);
        }
    }

    public String mapToParams(Map<String, String> map) {
        StringBuilder paramBuilder = new StringBuilder();
        for (String key : map.keySet()) {
            paramBuilder.append(paramBuilder.length() > 0 ? "&" : "");
            paramBuilder.append(String.format("%s=%s", urlEncodeUTF8(key),
                    urlEncodeUTF8(map.get(key))));
        }
        return paramBuilder.toString();
    }

    public String mapToJsonStr(Map<String, String> map) {
        try {
            return JACKSON_OBJECT_MAPPER.writeValueAsString(map);
        } catch (JsonProcessingException e) {
            log.error("JsonProcessingException", e);
        }
        return null;
    }
}
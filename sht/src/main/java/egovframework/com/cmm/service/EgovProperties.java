package egovframework.com.cmm.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import com.ibatis.common.resources.Resources;

import egovframework.com.cmm.EgovWebUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * Class Name : EgovProperties.java
 * Description : properties값들을 파일로부터 읽어와 Globals클래스의 정적변수로 로드시켜주는 클래스로
 * 문자열 정보 기준으로 사용할 전역변수를 시스템 재시작으로 반영할 수 있도록 한다.
 * Modification Information
 *
 * 수정일 수정자 수정내용
 * ------- -------- ---------------------------
 * 2009.01.19 박지욱 최초 생성
 * 2011.07.20 서준식 Globals파일의 상대경로를 읽은 메서드 추가
 * 
 * @author 공통 서비스 개발팀 박지욱
 * @since 2009. 01. 19
 * @version 1.0
 * @see
 *
 */

@Slf4j
public class EgovProperties {
	// 프로퍼티값 로드시 에러발생하면 반환되는 에러문자열
	public static final String ERR_CODE = " EXCEPTION OCCURRED";
	public static final String ERR_CODE_FNFE = " EXCEPTION(FNFE) OCCURRED";
	public static final String ERR_CODE_IOE = " EXCEPTION(IOE) OCCURRED";

	// 파일구분자
	static final char FILE_SEPARATOR = File.separatorChar;

	// 프로퍼티 파일의 물리적 위치
	/*
	 * public static final String GLOBALS_PROPERTIES_FILE
	 * = System.getProperty("user.home") + System.getProperty("file.separator") +
	 * "egovProps"
	 * + System.getProperty("file.separator") + "globals.properties";
	 */

	// public static final String RELATIVE_PATH_PREFIX =
	// EgovProperties.class.getResource("").getPath()
	// + System.getProperty("file.separator") + ".." +
	// System.getProperty("file.separator")
	// + ".." + System.getProperty("file.separator") + ".." +
	// System.getProperty("file.separator");

	// public static final String CONTEXT_ROOT_PATH = context.getRealPath("");

	// public static final String RELATIVE_PATH_PREFIX =
	// EgovProperties.class.getResource("").getPath().substring(0,
	// EgovProperties.class.getResource("").getPath().lastIndexOf("com"));
	// public static final String RELATIVE_PATH_PREFIX = context.getRealPath("")+
	// System.getProperty("file.separator") +
	// "WEB-INF"+System.getProperty("file.separator")+"classes"+
	// System.getProperty("file.separator");

	// EgovProperties.class.getResource("").getPath().substring(0,
	// EgovProperties.class.getResource("").getPath().lastIndexOf("com"));

	// public static final String GLOBALS_PROPERTIES_FILE
	// = RELATIVE_PATH_PREFIX + "egovProps" + System.getProperty("file.separator") +
	// "globals.properties";

	/**
	 * 인자로 주어진 문자열을 Key값으로 하는 프로퍼티 값을 반환한다(Globals.java 전용)
	 * 
	 * @param keyName String
	 * @return String
	 */
	public static String getProperty(String keyName) {
		String value = ERR_CODE;
		value = "99";
		// debug(GLOBALS_PROPERTIES_FILE + " : " + keyName);
		FileInputStream fis = null;
		try {
			Properties props = new Properties();
			Reader reader = Resources.getResourceAsReader("egovframework/egovProps/globals.properties");
			props.load(reader);
			// fis = new
			// FileInputStream(EgovWebUtil.filePathBlackList(GLOBALS_PROPERTIES_FILE));
			// props.load(new java.io.BufferedInputStream(fis));
			if (keyName != null && props != null && props.getProperty(keyName) != null) {
				value = props.getProperty(keyName).trim();
			}
		} catch (FileNotFoundException fne) {
			debug(fne);
			try {
				if (fis != null)
					fis.close();
			} catch (IOException ex) {
				log.debug("IGNORED: " + "오류");
			} finally {
			}
		} catch (IOException ioe) {
			debug(ioe);
			try {
				if (fis != null)
					fis.close();
			} catch (IOException ex) {
				log.debug("IGNORED: " + "오류");
			} finally {
			}
		} catch (Exception e) {
			debug(e);
			try {
				if (fis != null)
					fis.close();
			} catch (IOException ex) {
				log.debug("IGNORED: " + "오류");
			} finally {
			}
		} finally {
			try {
				if (fis != null)
					fis.close();
			} catch (IOException ex) {
				log.debug("IGNORED: " + "오류");
			} finally {
			}

		}
		return value;
	}

	/**
	 * 주어진 파일에서 인자로 주어진 문자열을 Key값으로 하는 프로퍼티 값을 반환한다
	 * 
	 * @param fileName String
	 * @param key      String
	 * @return String
	 */
	public static String getProperty(String fileName, String key) {
		String returnCode = "";

		// try-with-resources 문법 사용: 괄호 안에 선언된 리소스는 블록 종료 시 자동 close됨
		try (
				FileInputStream fis = new FileInputStream(EgovWebUtil.filePathBlackList(fileName));
				java.io.BufferedInputStream bis = new java.io.BufferedInputStream(fis)) {
			java.util.Properties props = new java.util.Properties();
			props.load(bis);

			String value = props.getProperty(key);
			return value;

		} catch (java.io.FileNotFoundException fne) {
			log.debug("Property file not found: " + fileName, fne);
			returnCode = ERR_CODE_FNFE;
		} catch (java.io.IOException ioe) {
			log.debug("IO Exception while reading: " + fileName, ioe);
			returnCode = ERR_CODE_IOE;
		}

		// 에러 발생 시 에러 코드 반환
		return returnCode;
	}

	/**
	 * 주어진 프로파일의 내용을 파싱하여 (key-value) 형태의 구조체 배열을 반환한다.
	 * 
	 * @param property String
	 * @return ArrayList
	 */
	public static ArrayList loadPropertyFile(String property) {

		// 결과 값을 담을 리스트
		ArrayList keyList = new ArrayList();

		// 경로 정규화 및 보안 점검
		String src = property.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
		File srcFile = new File(EgovWebUtil.filePathBlackList(src));

		if (!srcFile.exists()) {
			return keyList;
		}

		// try-with-resources 문법 사용: 괄호 안에 선언된 리소스는 블록 종료 시 자동 close됨
		try (FileInputStream fis = new FileInputStream(src);
				java.io.BufferedInputStream bis = new java.io.BufferedInputStream(fis)) {

			java.util.Properties props = new java.util.Properties();
			props.load(bis);

			Enumeration<?> plist = props.propertyNames();
			if (plist != null) {
				while (plist.hasMoreElements()) {
					Map map = new HashMap();
					String key = (String) plist.nextElement();
					map.put(key, props.getProperty(key));
					keyList.add(map);
				}
			}

		} catch (IOException ex) {
			debug(ex);
		} catch (Exception ex) {
			debug(ex);
		}

		return keyList;
	}

	/**
	 * 시스템 로그를 출력한다.
	 * 
	 * @param obj Object
	 */
	private static void debug(Object obj) {
		if (obj instanceof java.lang.Exception) {
			log.debug("IGNORED: " + "오류");
		}
	}
}

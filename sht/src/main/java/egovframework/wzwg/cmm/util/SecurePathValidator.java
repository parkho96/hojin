package egovframework.wzwg.cmm.util;

public class SecurePathValidator {

    /**
     * 입력값이 오직 숫자(0-9)로만 구성되어 있는지 검증
     * @param path 검증할 문자열
     * @return 숫자만 포함된 경우 true (공백, 특수문자, 영문 등이 섞이면 false)
     */
    public static boolean isValidNumericPath(String path) {
        if (path == null || path.trim().isEmpty()) {
            return false;
        }
        // 정규식: ^ (시작), [0-9]+ (숫자 1개 이상), $ (끝)
        return path.matches("^[0-9]+$");
    }
}

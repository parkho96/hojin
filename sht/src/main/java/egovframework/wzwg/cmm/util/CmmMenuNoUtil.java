package egovframework.wzwg.cmm.util;

import jakarta.servlet.http.HttpServletRequest;

public class CmmMenuNoUtil {

    public CmmMenuNoUtil() {
        super();
    }

    // 사용자 컨텐츠 화면
    private static String SUB_MENU_URL = "/subMenu.do";

    // 관리자 화면편집 컨텐츠 화면
    private static String ADMIN_SUB_MENU_URL = "/scrinEdit/subMenu.do";

    // 화면편집 URL
    private static String ADMIN_SCRIN_EDIT_URL = "/scrinEdit";
    
    // 사용자 컨텐츠화면
    private static String MAIN_MENU_URL = "/index.do";
    
    // URL에서 메뉴NO를 찾는다
    public static String getUrlByMenuNo(HttpServletRequest request) {

        String getMenu = "";
        
        String getUrl = request.getRequestURI();
        /**
        if (getUrl.indexOf(SUB_MENU_URL) > -1) {
            //화면편집모드 URL 컨트롤
            if (getUrl.indexOf(ADMIN_SUB_MENU_URL) > -1) {
                getUrl = getUrl.replaceAll(ADMIN_SCRIN_EDIT_URL, "");
            }
            getUrl = getUrl.substring(getUrl.lastIndexOf("/" ,2), getUrl.indexOf(SUB_MENU_URL));
            getMenu = getUrl.replaceAll("/", "");
        }
        **/
        if (getUrl.indexOf("/subList")>-1) {
            // 화면편집모드 URL 컨트롤
            if (getUrl.indexOf(ADMIN_SUB_MENU_URL) > -1) {
                getUrl = getUrl.replaceAll(ADMIN_SCRIN_EDIT_URL, "");
            }
            getUrl = getUrl.substring(getUrl.lastIndexOf("/")+1);
            getMenu = getUrl.replaceAll("/", "");
        }
        try {
            double menuNo = Double.parseDouble(getMenu);
            
            return getMenu;
        } catch (NumberFormatException ne) { 
            return "";
        }
    }

}

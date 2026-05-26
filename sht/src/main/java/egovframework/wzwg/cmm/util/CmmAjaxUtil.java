package egovframework.wzwg.cmm.util;

import java.util.Collection;

import jakarta.annotation.Resource;

import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.wzwg.cmm.util.ajax.AjaxXmlView;

public class CmmAjaxUtil {

    public CmmAjaxUtil() {
        super();
    }

    @Resource(name="egovMessageSource")
    static EgovMessageSource egovMessageSource;
    
    // MsgMap
    private static String[] MSG_ARR = {"fail", "success"};

    public static String[] getMSG_ARR() {
    	String[] ret = null;
    	ret = new String[MSG_ARR.length];
    	for (int i = 0; i < MSG_ARR.length; i++) {
    	ret[i] = MSG_ARR[i];
    	}
    	return ret;
    }

    // 공통메세지코드
    public static ModelAndView getAjaxReturnCmmMessage(String msgCode) {
        
        return getAjaxReturn(egovMessageSource.getMessage(msgCode));
    }
    
    // MsgMap메세지
    public static ModelAndView getAjaxReturnCmmMap(int msgCode) {
        
        msgCode = (msgCode > 1)? 1:msgCode;
        
        return getAjaxReturn(getMSG_ARR()[msgCode]);
    }
    
    // 화면에서 처리할 메세지코드
    public static ModelAndView getAjaxReturnCmmMsgCode(int msgCode) {
        
        return getAjaxReturn(Integer.toString(msgCode));
    }
    
    // 화면에서 처리할 메세지코드
    public static ModelAndView getAjaxReturnCmmMsgCode(String msgCode) {
        
        return getAjaxReturn(StringUtils.defaultString(msgCode));
    }
    
    // 화면에서 처리할 메세지코드
    public static ModelAndView getAjaxReturnDefault() {
        
        return getAjaxReturn("");
    }

    public static ModelAndView getAjaxReturn(String msg) {
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", msg).toString());
        
        return ajaxModel;
    }
    
    public static ModelAndView getAjaxReturnList(Collection<?> list, String name, String value, boolean gbn) throws Exception {
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        
        ajaxModel.addObject("ajaxXml", new AjaxXmlBuilder().addItems(list, name, value, gbn).toString());
        
        return ajaxModel;
    }

}

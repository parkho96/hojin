package egovframework.wzwg.module.smarteditor.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.custom.service.ModuleBbsCustomBassInfoService;

@Controller
public class SmartEditorController {
	/** ModuleBbsCustomBassInfoService */
    @Resource(name="ModuleBbsCustomBassInfoService")
    protected ModuleBbsCustomBassInfoService bbsCustomBassInfoService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
	/**
     * ㅁ 시스템 - 약관 초기화면(사용자)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value= {"/smartEditor2.8.2.1/smartEditor2Skin.do","/{siteKey}/smartEditor2.8.2.1/smartEditor2Skin.do"})
    public String smartEditor2Skin(
             HttpServletRequest request 
            , ModelMap model) throws Exception{

    	//System.out.println("smartEditor2Skin.do call");

    	String bbsSeq = request.getParameter("bbsSeq");
    	String noLoginAt = "N";
    	try {
    		if(bbsSeq != null && bbsSeq.equals("") == false) {
    			// 커스텀 게시판 비회원 글쓰기 때문에 추가함
    			ModuleBbsVO resultVO = new ModuleBbsVO();
    			resultVO.setBbsSeq(bbsSeq);
    			resultVO = bbsCustomBassInfoService.selectBbsBassInfoDetail(resultVO);
    			if(resultVO != null) {
    				//커스텀 게시판이 아니라면 작업하지 않는다
    				ModuleBbsVO funcVO = bbsCustomBassInfoService.selectBbsCustomFunctionDetail(resultVO);
    				noLoginAt = funcVO.getNolognAt();
    			}
    		}
    	}catch(RuntimeException e) {
    		noLoginAt = "N";
    	}
    	
    	String loginID = CmmSessionUtil.getSessionUserId();
    	if(noLoginAt.equals("Y") || loginID != null) {
    		return "wzwg/webModule/smartEditor/SmartEditor2Skin";
    		
    	}else {
    		model.addAttribute("message", "authCtrl.err01");
            model.addAttribute("retUrl", "/index.do");
            return "wzwg/cmm/errorMsgForward";
    	}
    }
    
    /**
     * ㅁ 시스템 - 약관 초기화면(사용자)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value= {"/smartEditor2.8.2.1/sample/photo_uploader/photo_uploader.do","/{siteKey}/smartEditor2.8.2.1/sample/photo_uploader/photo_uploader.do"})
    public String photo_uploader(
    		HttpServletRequest request 
    		, ModelMap model) throws Exception{
    	
    	//System.out.println("photo_uploader.do call");
    	String bbsSeq = request.getParameter("bbsSeq");
    	String noLoginAt = "N";
    	try {
    		if(bbsSeq != null && bbsSeq.equals("") == false) {
    			// 커스텀 게시판 비회원 글쓰기 때문에 추가함
    			ModuleBbsVO resultVO = new ModuleBbsVO();
    			resultVO.setBbsSeq(bbsSeq);
    			resultVO = bbsCustomBassInfoService.selectBbsBassInfoDetail(resultVO);
    			ModuleBbsVO funcVO = bbsCustomBassInfoService.selectBbsCustomFunctionDetail(resultVO);
    			noLoginAt = funcVO.getNolognAt();
    		}
    		
    	}catch(RuntimeException e) {
    		noLoginAt = "N";
    	}
    	String loginID = CmmSessionUtil.getSessionUserId();
    	if(noLoginAt.equals("Y") || loginID != null) {
    		return "wzwg/webModule/smartEditor/photo_uploader";
    		
    	}else {
    		model.addAttribute("message", "authCtrl.err01");
            model.addAttribute("retUrl", "/index.do");
            return "wzwg/cmm/errorMsgForward";
    	}
    	
    }
}

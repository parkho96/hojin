package egovframework.wzwg.module.bbs.custom.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.IllegalFormatException;
import java.util.List;
import java.util.Map;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.custom.service.ModuleBbsCustomBassInfoService;
import egovframework.wzwg.module.bbs.custom.service.ModuleBbsCustomVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ModuleBbsCustomBassInfoController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    /** ModuleBbsUnityBassInfoService */
    @Resource(name="ModuleBbsCustomBassInfoService")
    protected ModuleBbsCustomBassInfoService bbsCustomBassInfoService;
    
    /** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;;
    
    /**
	 * ㅁ 커스텀게시판 - 메인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/bbs/custom/selectBbsInc.do","/{siteKey}/**/module/bbs/custom/selectBbsInc.do"})
	public String selectBbsInc(HttpServletRequest request, ModelMap model, @RequestParam Map<String, String> paramVO,@ModelAttribute("paramVO") ModuleBbsVO moduleBbsVO) throws Exception{
		
		paramVO.put("siteSeq", (CmmSessionUtil.getSessionSiteSeq(request)));
    	
    	List<CntntsInfoVO> resultList = bbsCmmnService.selectBbsList(paramVO.get("siteSeq"));
    	
    	/*
    	if(paramVO.getBbsSeq() == null && resultList.size() > 0){
    		paramVO.setBbsSeq(resultList.get(0).getCntntsSeq());
    	}
    	*/
    	
    	//List<Map<String, String>> fieldList = bbsCustomBassInfoService.selectBbsBassInfoCustomFieldList(paramVO);
    	//model.addAttribute("fieldList", fieldList);
    	
		paramVO.put("bbsSeq", ((String) request.getParameter("cntntsSeq")));
		
		model.addAttribute("bbsList", resultList);
    	
    	String reqUrl = request.getRequestURI();
    	String mngrAt = "N";

    	if(reqUrl.indexOf("/mngr/") > -1 || reqUrl.indexOf("/sysMngr/") > -1) {
    		if(reqUrl.indexOf("/mngr/screen/") == -1 || reqUrl.indexOf("/sysMngr/screen/") == -1) {
    			mngrAt = "Y";
    		}
    	}
    	moduleBbsVO.setBbsSeq(((String) request.getParameter("cntntsSeq")));
    	ModuleBbsVO funcVO = bbsCustomBassInfoService.selectBbsCustomFunctionDetail(moduleBbsVO);
		model.addAttribute("funcVO", funcVO); 
    	model.addAttribute("mngrAt", mngrAt);
    	model.addAttribute("paramVO", paramVO);
		
		return "wzwg/module/bbs/custom/bbsInc"; 
	}
	
	/**
	 * ㅁ 커스텀게시판 - 기본정보
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/bbs/custom/selectUnityBbsBassInfoAjax.do", "/**/module/bbs/custom/bbsFormAjax.do"})
	public String selectUnityBbsBassInfo(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	//List<ModuleBbsVO> formList = bbsCmmnService.selectBbsFormList(paramVO.getSiteSeq());
    	//model.addAttribute("formList", formList);
		
		ModuleBbsVO resultVO = new ModuleBbsVO();
		
		// 게시판 기본정보
		resultVO = bbsCustomBassInfoService.selectBbsBassInfoDetail(paramVO);
		
		ModuleBbsVO funcVO = bbsCustomBassInfoService.selectBbsCustomFunctionDetail(paramVO);
		model.addAttribute("funcVO", funcVO); 
		if(resultVO != null){
			Map<String, String> fieldVO = new HashMap<String, String>();
			fieldVO.put("siteSeq", CmmSessionUtil.getSessionSiteSeq(request));
			fieldVO.put("bbsSeq", resultVO.getBbsSeq());
			List<ModuleBbsCustomVO> fieldList = bbsCustomBassInfoService.selectBbsBassInfoCustomFieldList(fieldVO);
			model.addAttribute("fieldList", fieldList);
		}
		
		if(resultVO != null){
		    resultVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
			model.addAttribute("resultVO", resultVO);
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		return "wzwg/module/bbs/custom/bbsBassForm"; 
	}

	/**
	 * ㅁ 커스텀게시판 - 기본정보 저장
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/bbs/custom/modifyBbsBassInfoAjax.do")
	public ModelAndView modifyBbsBassInfo(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
    	int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

		if(loginVO != null && loginVO.getUserId() != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = bbsCustomBassInfoService.modifyBbsBassInfo(paramVO);	// 저장
        
		/* 커스텀 기능 저장 */
		if(result > 0){
			bbsCustomBassInfoService.modifyBbsCustomFunctionInfo(paramVO);
		}
		
		/* 비밀번호 필드는 파라미터로 넘어오기 때문에 무조건 삭제한다 */
		//if(paramVO.getNolognAt().equals("N")){
		if(loginVO != null && loginVO.getUserId() != null) {
			Map<String, String> pwFieldVO = new HashMap<String, String>();
			pwFieldVO.put("userId", loginVO.getUserId());
			pwFieldVO.put("siteSeq", CmmSessionUtil.getSessionSiteSeq(request));
			pwFieldVO.put("bbsSeq", paramVO.getBbsSeq());
			bbsCustomBassInfoService.deleteBbsBassInfoCustomPasswordField(pwFieldVO);
		}
		//}
		
		/* 커스텀 필드 저장 */
		if(result > 0 && loginVO != null){
			String fieldCnt = request.getParameter("fieldCnt");
			List<Map<String, String>> fieldList = getArrayParameterList(request, Integer.parseInt(fieldCnt), "fieldNm", "fieldTy", "listAt", "fieldSel", "useAt", "fieldId", "fieldSeq");
			//System.out.println(fieldList);
		
			/*
			Map<String, String> deleteVO = new HashMap<String, String>();
			deleteVO.put("siteSeq", CmmSessionUtil.getSessionSiteSeq(request));
			deleteVO.put("bbsSeq", paramVO.getBbsSeq());
			bbsCustomBassInfoService.deleteBbsBassInfoCustomField(deleteVO);
			*/
			
			for (Map<String, String> fieldVO : fieldList) {
				fieldVO.put("userId", loginVO.getUserId());
				fieldVO.put("siteSeq", CmmSessionUtil.getSessionSiteSeq(request));
				fieldVO.put("bbsSeq", paramVO.getBbsSeq());
				
				bbsCustomBassInfoService.registBbsBassInfoCustomField(fieldVO);
			}
		}
		
		
		
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
	}

    /**
     * ㅁ 커스텀게시판 - 기본정보 저장
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/module/bbs/custom/registBbsBassInfoAjax.do")
    public ModelAndView registBbsBassInfo(
            @ModelAttribute("paramVO") ModuleBbsVO paramVO
            /*, @RequestParam Map<String, String>[] fieldsVO*/
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
    	/*List<Map<String, String>> fieldList = Arrays.asList(fieldsVO);
    	
    	System.out.println(fieldList);*/
    	
        int result = 0;
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

        if(loginVO != null && loginVO.getUserId() != null) {
        	paramVO.setFrstRegisterId(loginVO.getUserId());
        }

        result = bbsCustomBassInfoService.registBbsBassInfo(paramVO);    // 저장
        
        /* 커스텀 기능 저장 */
        if(result > 0){
        	bbsCustomBassInfoService.registBbsCustomFunctionInfo(paramVO);
        }
        
        /* 커스텀 필드 저장 */
        if(result > 0 && loginVO != null){
			String fieldCnt = request.getParameter("fieldCnt");
			List<Map<String, String>> fieldList = getArrayParameterList(request, Integer.parseInt(fieldCnt), "fieldNm", "fieldTy", "listAt", "fieldSel", "useAt", "fieldId", "fieldSeq");
//			System.out.println(fieldList);
			
			for (Map<String, String> fieldVO : fieldList) {
				fieldVO.put("userId", loginVO.getUserId());
				fieldVO.put("siteSeq", CmmSessionUtil.getSessionSiteSeq(request));
				fieldVO.put("bbsSeq", paramVO.getBbsSeq());
				
				bbsCustomBassInfoService.registBbsBassInfoCustomField(fieldVO);
			}
		}
        
        
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
    }
    
    private List<Map<String, String>> getArrayParameterList(HttpServletRequest request, int row, String ...names){
    	List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();
    	
    	int fieldCnt = names.length;
    	
    	
    	for(int i = 0 ; i < row; i++){
    		
    		Map<String, String> result = new HashMap<String, String>();
    		for (String key : names) {
    			String value = "";
    			try {
    				value = request.getParameterValues(key)[i];
    			} catch (NullPointerException e) {	
					log.error("NullPointerException",e);
				}catch (NumberFormatException e) {	
					log.error("NumberFormatException",e);
				}catch (IllegalFormatException e) {	
					log.error("NullPointerException",e);
				}catch (ArrayIndexOutOfBoundsException e) {	
					log.error("NullPointerException",e);
				}
				result.put(key, value);
			}
    		result.put("sortOrder", String.valueOf(i+1));
    		resultList.add(result);
    	}
    	
    	
    	return resultList;
    }
	
}

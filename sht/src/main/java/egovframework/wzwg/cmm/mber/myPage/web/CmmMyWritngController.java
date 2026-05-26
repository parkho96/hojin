package egovframework.wzwg.cmm.mber.myPage.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.mber.myPage.service.CmmMyWritngService;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerVO;
import egovframework.wzwg.module.ntt.module.scrap.service.ModuleNttScrapService;
import egovframework.wzwg.module.ntt.module.scrap.service.ModuleNttScrapVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;

@Controller
public class CmmMyWritngController {

    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="CmmMyWritngService")
    private CmmMyWritngService cmmMyWritngService;
    
    /** ModuleNttScrapService */
    @Resource(name="ModuleNttScrapService")
    protected ModuleNttScrapService nttScrapService;
    
    
    /**
     * 내가 작성한 게시물 / 댓글 매인
     * @param paramVO
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value={"/cmm/mber/myPage/selectMyWritngInc.do","/{siteKey}/cmm/mber/myPage/selectMyWritngInc.do"})
    public String selectMyWritngInc(
    		@ModelAttribute("paramVO") ModuleNttVO paramVO
    		, HttpServletRequest request 
    		, ModelMap model
    		) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
    	CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
    	
    	if (loginVO != null) {
    		paramVO.setUsrSeq(loginVO.getUsrSeq());
    		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    		
    		return "wzwg/cmm/mber/myPage/myWritng/myWritngInc"; 
    	} else {
    		model.addAttribute("message", "fail.common.login");
    		return "forward:"+wzwgContext+"/loginForm.do";
    	}
    }
    
    /**
     * 내가 작성한 게시물 목록
     * @param paramVO
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value={"/cmm/mber/myPage/selectMyWritngNttListAjax.do","/{siteKey}/cmm/mber/myPage/selectMyWritngNttListAjax.do"})
    public String selectMyWritngNttList(
    		@ModelAttribute("paramVO") ModuleNttVO paramVO
    		, HttpServletRequest request 
    		, ModelMap model
    		) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
    	CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
    	
    	if (loginVO != null) {
    		paramVO.setUsrSeq(loginVO.getUsrSeq());
    		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    		
    		PaginationInfo paginationInfo = new PaginationInfo();
            paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
            paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
            paginationInfo.setPageSize(paramVO.getPageSize());
           
            paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
            paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
            paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		
    		List<ModuleNttVO> resultList = cmmMyWritngService.selectMyWritngNttList(paramVO);
    		
    		Integer resultCnt = cmmMyWritngService.selectMyWritngNttListTotCnt(paramVO);
    		
    		paginationInfo.setTotalRecordCount(resultCnt.intValue());
    		
    		/* 모바일 페이지네이션 설정 */
    		PaginationInfo mobilePaginationInfo = new PaginationInfo();
    		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
    		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
    		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		mobilePaginationInfo.setPageSize(5);
    		
    		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
    		model.addAttribute("resultList", 		resultList);
    		model.addAttribute("resultCnt", 		resultCnt);
    		model.addAttribute("paginationInfo", 	paginationInfo);
    		
    		return "wzwg/cmm/mber/myPage/myWritng/myWritngNttList"; 
    	} else {
    		model.addAttribute("message", "fail.common.login");
    		return "forward:"+wzwgContext+"/loginForm.do";
    	}
    }
    
    /**
     * 내가 작성한 댓글 목록
     * @param paramVO
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value={"/cmm/mber/myPage/selectMyWritngAnswerListAjax.do","/{siteKey}/cmm/mber/myPage/selectMyWritngAnswerListAjax.do"})
    public String selectMyWritngAnswerList(
    		@ModelAttribute("paramVO") ModuleNttAnswerVO paramVO
    		, HttpServletRequest request 
    		, ModelMap model
    		) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
    	CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
    	
    	if (loginVO != null) {
    		paramVO.setUsrSeq(loginVO.getUsrSeq());
    		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    		
    		PaginationInfo paginationInfo = new PaginationInfo();
            paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
            paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
            paginationInfo.setPageSize(paramVO.getPageSize());
           
            paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
            paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
            paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
            
    		List<ModuleNttAnswerVO> resultList = cmmMyWritngService.selectMyWritngAnswerList(paramVO);
    		
    		Integer resultCnt = cmmMyWritngService.selectMyWritngAnswerListTotCnt(paramVO);
    		
    		paginationInfo.setTotalRecordCount(resultCnt.intValue());
    		
    		/* 모바일 페이지네이션 설정 */
    		PaginationInfo mobilePaginationInfo = new PaginationInfo();
    		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
    		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
    		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		mobilePaginationInfo.setPageSize(5);
    		
    		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
    		model.addAttribute("resultList", 		resultList);
    		model.addAttribute("resultCnt", 		resultCnt);
    		model.addAttribute("paginationInfo", 	paginationInfo);
    		
    		return "wzwg/cmm/mber/myPage/myWritng/myWritngAnswerList"; 
    	} else {
    		model.addAttribute("message", "fail.common.login");
    		return "forward:"+wzwgContext+"/loginForm.do";
    	}
    }
    
    /**
     * 내가 스크랩한 게시물 매인
     * @param paramVO
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value={"/cmm/mber/myPage/selectMyScrapInc.do","/{siteKey}/cmm/mber/myPage/selectMyScrapInc.do"})
    public String selectMyScrapInc(
    		@ModelAttribute("paramVO") ModuleNttScrapVO paramVO
    		, HttpServletRequest request 
    		, ModelMap model
    		) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
    	CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
    	
    	if (loginVO != null) {
    		paramVO.setUsrSeq(loginVO.getUsrSeq());
    		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    		
    		List<ModuleNttScrapVO> scrapgroupList = nttScrapService.selectNttScrapgroupList(paramVO);
    		model.addAttribute("scrapgroupList", scrapgroupList);
        		
    		return "wzwg/cmm/mber/myPage/myWritng/myScrapInc"; 
    	} else {
    		model.addAttribute("message", "fail.common.login");
    		return "forward:"+wzwgContext+"/loginForm.do";
    	}
    }
    
    /**
     * 내가 스크랩한 게시물 목록
     * @param paramVO
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value={"/cmm/mber/myPage/selectMyScrapListAjax.do","/{siteKey}/cmm/mber/myPage/selectMyScrapListAjax.do"})
    public String selectMyScrapList(
    		@ModelAttribute("paramVO") ModuleNttScrapVO paramVO
    		, HttpServletRequest request 
    		, ModelMap model
    		) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
    	CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
    	
    	if (loginVO != null) {
    		paramVO.setUsrSeq(loginVO.getUsrSeq());
    		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    		
    		PaginationInfo paginationInfo = new PaginationInfo();
            paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
            paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
            paginationInfo.setPageSize(paramVO.getPageSize());
           
            paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
            paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
            paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		
    		List<ModuleNttScrapVO> resultList = cmmMyWritngService.selectMyScrapList(paramVO);
    		
    		Integer resultCnt = cmmMyWritngService.selectMyScrapListTotCnt(paramVO);
    		
    		paginationInfo.setTotalRecordCount(resultCnt.intValue());
    		
    		/* 모바일 페이지네이션 설정 */
    		PaginationInfo mobilePaginationInfo = new PaginationInfo();
    		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
    		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
    		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		mobilePaginationInfo.setPageSize(5);
    		
    		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
    		model.addAttribute("resultList", 		resultList);
    		model.addAttribute("resultCnt", 		resultCnt);
    		model.addAttribute("paginationInfo", 	paginationInfo);
    		
    		return "wzwg/cmm/mber/myPage/myWritng/myScrapList"; 
    	} else {
    		model.addAttribute("message", "fail.common.login");
    		return "forward:"+wzwgContext+"/loginForm.do";
    	}
    }
}

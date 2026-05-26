package egovframework.wzwg.module.usr.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoService;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoVO;

/**
 * ㅁ 모듈 - 사용자정보
 * ㅁ DC   
 * - 사이트내에서 사용하는 사용자 호출 정보
 * @author 효꽁
 *
 */
@Controller
public class UsrController {

    /** 사용자정보 **/
    @Resource(name="SysMngrUsrInfoService")
    private SysMngrUsrInfoService usrInfoService;
    
    /**
     * ㅁ 사용자 목록
     * @param SysMngrUsrInfoVO
     * @return
     */
    @RequestMapping(value= {"/module/usr/selectUsrListJson.do","/{siteKey}/module/usr/selectUsrListJson.do"})
    public ModelAndView selectUsrListJson (
        @ModelAttribute("paramVO") SysMngrUsrInfoVO paramVO
        , HttpServletRequest request ) throws Exception {
    
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setSiteSeq(siteSeq);
        
        // 컨텐츠 정보를 가져옴
        List<SysMngrUsrInfoVO> usrList = usrInfoService.selectUsrList(paramVO);

        ModelAndView model = new ModelAndView();
    
        model.setViewName("jsonView");
        
        // 컨텐츠 데이터를 JSON 변환하여 넘김
        model.addObject("usrList", usrList);
        
        return model;
    }

}

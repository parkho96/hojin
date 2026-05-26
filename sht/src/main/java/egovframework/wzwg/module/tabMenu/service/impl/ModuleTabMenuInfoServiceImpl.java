package egovframework.wzwg.module.tabMenu.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.wzwg.module.tabMenu.service.ModuleTabMenuInfoService;
import egovframework.wzwg.module.tabMenu.service.ModuleTabMenuInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;

@Service("ModuleTabMenuInfoService")
public class ModuleTabMenuInfoServiceImpl extends EgovAbstractServiceImpl implements ModuleTabMenuInfoService{
	
	@Resource(name="CntntsInfoDAO")
    CntntsInfoDAO cntntsInfoDAO;
	
	@Resource(name="ModuleTabMenuInfoDAO")
	ModuleTabMenuInfoDAO tabMenuInfoDAO;
	
	/**
	 * ㅁ 탭메뉴 - 탭메뉴 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectTabMenuInfoList(String siteSeq) throws Exception{
		return tabMenuInfoDAO.selectTabMenuList(siteSeq);
	}
	
	/**
	 * ㅁ 텝메뉴 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleTabMenuInfoVO selectTabMenuInfoDetail(ModuleTabMenuInfoVO moduleTabInfoVO) throws Exception{
		return tabMenuInfoDAO.selectTabMenuInfoDetail(moduleTabInfoVO);
	}
	
	/**
     * ㅁ 텝메뉴 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyTabMenuBassInfo(ModuleTabMenuInfoVO moduleTabInfoVO) throws Exception {
        
        CntntsInfoVO paramVO = new CntntsInfoVO();
        
        paramVO.setCntntsNm(moduleTabInfoVO.getTabNm());
        paramVO.setCntntsDc(moduleTabInfoVO.getTabDc());
        paramVO.setSitecntntsSeq(moduleTabInfoVO.getSitecntntsSeq());
        paramVO.setLastUpdusrId(moduleTabInfoVO.getLastUpdusrId());
        
        cntntsInfoDAO.modifyCntntsInfoInit(paramVO);
        
        return tabMenuInfoDAO.modifyTabMenuInfo(moduleTabInfoVO);
    }
    
    /**
     * ㅁ 텝메뉴 기본정보 수정(cssNm)
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyTabMenuCssNm(ModuleTabMenuInfoVO moduleTabInfoVO) throws Exception{
    	return tabMenuInfoDAO.modifyTabMenuCssNm(moduleTabInfoVO);
    }
    
    /**
     * ㅁ 텝메뉴 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registTabMenuBassInfo(ModuleTabMenuInfoVO moduleTabInfoVO) throws Exception {
        String tabSeq = tabMenuInfoDAO.selectTabMenuSeq();
        moduleTabInfoVO.setTabSeq(tabSeq);

        if (RequestContextHolder.getRequestAttributes() != null) {
            RequestContextHolder.getRequestAttributes().setAttribute("regist_sysModuleSeq", tabSeq, RequestAttributes.SCOPE_SESSION);
        }
        
        return tabMenuInfoDAO.registTabMenuInfo(moduleTabInfoVO);
    }
    
    /**
     * ㅁ 텝메뉴 초기 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String registTabMenuBassInfoInit(ModuleTabMenuInfoVO moduleTabInfoVO) throws Exception {
        String tabSeq = tabMenuInfoDAO.selectTabMenuSeq();
        moduleTabInfoVO.setTabSeq(tabSeq);
        tabMenuInfoDAO.registTabMenuInfo(moduleTabInfoVO);
        return tabSeq;
    }
}

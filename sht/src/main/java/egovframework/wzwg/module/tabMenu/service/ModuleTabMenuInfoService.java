package egovframework.wzwg.module.tabMenu.service;

import java.util.List;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

public interface ModuleTabMenuInfoService {
	/**
	 * ㅁ 텝메뉴 - 텝메뉴 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectTabMenuInfoList(String siteSeq) throws Exception;
	
	/**
	 * ㅁ 텝메뉴 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleTabMenuInfoVO selectTabMenuInfoDetail(ModuleTabMenuInfoVO moduleTabInfoVO) throws Exception;
    
    /**
     * ㅁ 텝메뉴 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyTabMenuBassInfo(ModuleTabMenuInfoVO moduleTabInfoVO) throws Exception;
    
    /**
     * ㅁ 기본정보 수정(cssNm)
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyTabMenuCssNm(ModuleTabMenuInfoVO moduleTabInfoVO) throws Exception;
    
    /**
     * ㅁ 텝메뉴 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registTabMenuBassInfo(ModuleTabMenuInfoVO moduleTabInfoVO) throws Exception;
    
    /**
     * ㅁ 텝메뉴 초기 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String registTabMenuBassInfoInit(ModuleTabMenuInfoVO moduleTabInfoVO) throws Exception;
}

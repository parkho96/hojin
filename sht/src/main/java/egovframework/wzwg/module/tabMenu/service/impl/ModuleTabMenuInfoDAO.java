package egovframework.wzwg.module.tabMenu.service.impl;

import java.util.IllegalFormatException;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCssVO;
import egovframework.wzwg.module.tabMenu.service.ModuleTabMenuInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

@Repository("ModuleTabMenuInfoDAO")
public class ModuleTabMenuInfoDAO extends EgovAbstractMapper{
	/**
     * ㅁ 컨텐츠관리 - 탭메뉴SEQ
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String selectTabMenuSeq() throws Exception {
        return (String)selectOne("ModuleTabMenuInfoDAO_selectTabMenuSeq");
    }
    
	/**
	 * ㅁ 컨텐츠관리 - 탭메뉴 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectTabMenuList(String siteSeq) throws Exception {
		return selectList("ModuleTabMenuInfoDAO_selectTabMenuList_S", siteSeq);
	}
	
	/**
	 * ㅁ 탭메뉴 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleTabMenuInfoVO selectTabMenuInfoDetail(ModuleTabMenuInfoVO moduleTabMenuInfoVO) throws Exception {
		return (ModuleTabMenuInfoVO) selectOne("ModuleTabMenuInfoDAO_selectTabMenuInfoDetail_S", moduleTabMenuInfoVO);
	}
	
	/**
     * ㅁ 탭메뉴 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyTabMenuInfo(ModuleTabMenuInfoVO moduleTabMenuInfoVO) throws Exception {
		
		// 기본정보 등록
		return update("ModuleTabMenuInfoDAO_modifyBbsBassInfo_U", moduleTabMenuInfoVO);
		
		// 양식정보 등록
		//return update("ModuleBbsClBassInfoDAO_modifyBbsFormInfo_U", moduleTabMenuInfoVO);
	}
	
	/**
	 * ㅁ 탭메뉴 기본정보 수정(cssNm)
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyTabMenuCssNm(ModuleTabMenuInfoVO moduleTabMenuInfoVO) throws Exception {
		
		// 기본정보 등록
		return update("ModuleTabMenuInfoDAO_modifyBbsBassCssNm_U", moduleTabMenuInfoVO);
		
	}
    
    /**
     * ㅁ 탭메뉴 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registTabMenuInfo(ModuleTabMenuInfoVO moduleTabMenuInfoVO) throws Exception {
    	
    	int resultInt = 1;
        
        try {
            // 기본정보 등록
            insert("ModuleTabMenuInfoDAO_registBbsBassInfo_I", moduleTabMenuInfoVO);
            
            //if (!"".equals(StringUtils.defaultString(moduleTabMenuInfoVO.getTabSeq()))) {
            //   update("ModuleBbsClBassInfoDAO_modifyBbsFormInfo_U", moduleTabMenuInfoVO);
            //}   
        } catch(NullPointerException e){
        	resultInt = 0;
    	} catch(NumberFormatException e){    		
    		resultInt = 0;
    	} catch(IllegalFormatException e){    		
    		resultInt = 0;
    	} 
        
        return resultInt;
    }
    
    
	
	///**
	// * ㅁ 글양식 목록
    // * @param paramVO
    // * @return
    // * @throws Exception
    // */
	//public List<ModuleTabMenuInfoVO> selectTabMenuFormList(String siteSeq) throws Exception {
	//	return selectList("ModuleBbsCmmnDAO_selectBbsFormList_S", siteSeq);
	//}
	//
	///**
	// * ㅁ 말머리 목록
    // * @param paramVO
    // * @return
    // * @throws Exception
    // */
	//public List<ModuleTabMenuInfoVO> selectTabMenuSubospecList(String bbsSeq) throws Exception {
	//	return selectList("ModuleBbsCmmnDAO_selectBbsSubospecList_S", bbsSeq);
	//}
	//
	///**
	// * ㅁ 말머리 등록
    // * @param paramVO
    // * @return
    // * @throws Exception
    // */
	//public int registTabMenuSubospec(ModuleTabMenuInfoVO ModuleTabMenuInfoVO) throws Exception {
	//	return update("ModuleBbsCmmnDAO_registBbsSubospec_I", ModuleTabMenuInfoVO);
	//}
	//
	///**
	// * ㅁ 말머리 수정
    // * @param paramVO
    // * @return
    // * @throws Exception
    // */
	//public int modifyTabMenuSubospec(ModuleTabMenuInfoVO ModuleTabMenuInfoVO) throws Exception {
	//	return update("ModuleBbsCmmnDAO_modifyBbsSubospec_U", ModuleTabMenuInfoVO);
	//}
	//
	///**
	// * ㅁ 말머리 삭제
    // * @param paramVO
    // * @return
    // * @throws Exception
    // */
	//public int deleteTabMenuSubospec(ModuleTabMenuInfoVO ModuleTabMenuInfoVO) throws Exception {
	//	return delete("ModuleBbsCmmnDAO_deleteBbsSubospec_D", ModuleTabMenuInfoVO);
	//}
	
	/**
	 * CSS 리스트 조회
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public List<ModuleBbsCssVO> selectTabMenuCssList(ModuleTabMenuInfoVO ModuleTabMenuInfoVO) {
		return selectList("ModuleBbsCmmnDAO_selectBbsCssList", ModuleTabMenuInfoVO);
	}	
   	
	/**
	 * CSS 리스트 조회
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public List<ModuleBbsCssVO> selectSysmoduleTabMenuCssList(ModuleTabMenuInfoVO ModuleTabMenuInfoVO) {
		return selectList("ModuleBbsCmmnDAO_selectSysmoduleBbsCssList", ModuleTabMenuInfoVO);
	}
	
	
	/**
	 * CSS 상세조회
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public ModuleBbsCssVO selectTabMenuCssDetail(ModuleBbsCssVO moduleBbsCssVO) {
		return (ModuleBbsCssVO) selectOne("ModuleBbsCmmnDAO_selectBbsCssDetail", moduleBbsCssVO);
	}	
	
	/**
	 * ㅁ 탭메뉴 CSS정보 저장
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyTabMenuCssSeq(ModuleTabMenuInfoVO ModuleTabMenuInfoVO) throws Exception {
		return update("ModuleBbsCmmnDAO_modifyBbsCssSeq", ModuleTabMenuInfoVO);
	}	
		
	/**
	 * 탭메뉴 CSS_SEQ 가져오기 
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public ModuleBbsCssVO selectTabMenuCssSeq(ModuleTabMenuInfoVO ModuleTabMenuInfoVO) {
		return (ModuleBbsCssVO) selectOne("ModuleBbsCmmnDAO_selectBbsCssSeq", ModuleTabMenuInfoVO);
	}	
}

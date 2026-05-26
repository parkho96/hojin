package egovframework.wzwg.module.bbs.cmmn.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCssVO;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;


@Repository("ModuleBbsCmmnDAO")

public class ModuleBbsCmmnDAO extends EgovAbstractMapper {

    
    /**
     * ㅁ 컨텐츠관리 - 게시판SEQ
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String selectBbsSeq() throws Exception {
        return (String)selectOne("ModuleBbsCmmnDAO_selectBbsSeq");
    }
    
	/**
	 * ㅁ 컨텐츠관리 - 게시판 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectBbsList(String siteSeq) throws Exception {
		return selectList("ModuleBbsCmmnDAO_selectBbsList_S", siteSeq);
	}
	
	/**
	 * ㅁ 글양식 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleBbsVO> selectBbsFormList(String siteSeq) throws Exception {
		return selectList("ModuleBbsCmmnDAO_selectBbsFormList_S", siteSeq);
	}
	
	/**
	 * ㅁ 말머리 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleBbsVO> selectBbsSubospecList(String bbsSeq) throws Exception {
		return selectList("ModuleBbsCmmnDAO_selectBbsSubospecList_S", bbsSeq);
	}
	
	/**
	 * ㅁ 말머리 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registBbsSubospec(ModuleBbsVO moduleBbsVO) throws Exception {
		return update("ModuleBbsCmmnDAO_registBbsSubospec_I", moduleBbsVO);
	}
	
	/**
	 * ㅁ 말머리 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsSubospec(ModuleBbsVO moduleBbsVO) throws Exception {
		return update("ModuleBbsCmmnDAO_modifyBbsSubospec_U", moduleBbsVO);
	}
	
	/**
	 * ㅁ 말머리 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteBbsSubospec(ModuleBbsVO moduleBbsVO) throws Exception {
		return delete("ModuleBbsCmmnDAO_deleteBbsSubospec_D", moduleBbsVO);
	}
	
	/**
	 * CSS 리스트 조회
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public List<ModuleBbsCssVO> selectBbsCssList(ModuleBbsVO moduleBbsVO) {
		return selectList("ModuleBbsCmmnDAO_selectBbsCssList", moduleBbsVO);
	}	
   	
	/**
	 * CSS 리스트 조회
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public List<ModuleBbsCssVO> selectSysmoduleBbsCssList(ModuleBbsVO moduleBbsVO) {
		return selectList("ModuleBbsCmmnDAO_selectSysmoduleBbsCssList", moduleBbsVO);
	}
	
	
	/**
	 * CSS 상세조회
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public ModuleBbsCssVO selectBbsCssDetail(ModuleBbsCssVO moduleBbsCssVO) {
		return (ModuleBbsCssVO) selectOne("ModuleBbsCmmnDAO_selectBbsCssDetail", moduleBbsCssVO);
	}	
	
	/**
	 * ㅁ 게시판 CSS정보 저장
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsCssSeq(ModuleBbsVO moduleBbsVO) throws Exception {
		return update("ModuleBbsCmmnDAO_modifyBbsCssSeq", moduleBbsVO);
	}	
		
	/**
	 * 게시판 CSS_SEQ 가져오기 
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public ModuleBbsCssVO selectBbsCssSeq(ModuleBbsVO moduleBbsVO) {
		ModuleBbsCssVO resultVO = (ModuleBbsCssVO) selectOne("ModuleBbsCmmnDAO_selectBbsCssSeq", moduleBbsVO);
		if(resultVO == null) {
			return new ModuleBbsCssVO();
		}else{
			return resultVO;
		}
	}		
	
}

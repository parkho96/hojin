package egovframework.wzwg.module.bbs.cmmn.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCssVO;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;



@Service("ModuleBbsCmmnService")
public class ModuleBbsCmmnServiceImpl extends EgovAbstractServiceImpl implements ModuleBbsCmmnService {

	
	@Resource(name="ModuleBbsCmmnDAO")
    protected ModuleBbsCmmnDAO bbsCmmnDAO;
	
	
	/**
	 * ㅁ 컨텐츠관리 - 게시판 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectBbsList(String siteSeq) throws Exception {
		return bbsCmmnDAO.selectBbsList(siteSeq);
	}
	
	/**
	 * ㅁ 글양식 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleBbsVO> selectBbsFormList(String siteSeq) throws Exception {
		return bbsCmmnDAO.selectBbsFormList(siteSeq);
	}

	/**
	 * ㅁ 말머리 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleBbsVO> selectBbsSubospecList(String bbsSeq) throws Exception {
		return bbsCmmnDAO.selectBbsSubospecList(bbsSeq);
	}
    
	/**
	 * ㅁ 말머리 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registBbsSubospec(ModuleBbsVO moduleBbsVO) throws Exception {
		return bbsCmmnDAO.registBbsSubospec(moduleBbsVO);
	}
	
	/**
	 * ㅁ 말머리 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsSubospec(ModuleBbsVO moduleBbsVO) throws Exception {
		return bbsCmmnDAO.modifyBbsSubospec(moduleBbsVO);
	}
	
	/**
	 * ㅁ 말머리 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteBbsSubospec(ModuleBbsVO moduleBbsVO) throws Exception {
		return bbsCmmnDAO.deleteBbsSubospec(moduleBbsVO);
	}
	
	/**
	 * CSS 리스트 조회
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public List<ModuleBbsCssVO> selectBbsCssList(ModuleBbsVO moduleBbsVO) throws Exception {
		return bbsCmmnDAO.selectBbsCssList(moduleBbsVO);
	}	
	
	public List<ModuleBbsCssVO> selectSysmoduleBbsCssList(ModuleBbsVO moduleBbsVO)  throws Exception{
		return bbsCmmnDAO.selectSysmoduleBbsCssList(moduleBbsVO);
	}
	
	/**
	 * CSS 상세조회
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public ModuleBbsCssVO selectBbsCssDetail(ModuleBbsCssVO moduleBbsCssVO) throws Exception {
		return bbsCmmnDAO.selectBbsCssDetail(moduleBbsCssVO);
	}	
	
	/**
	 * ㅁ 게시판 CSS정보 저장
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsCssSeq(ModuleBbsVO moduleBbsVO) throws Exception {
		return bbsCmmnDAO.modifyBbsCssSeq(moduleBbsVO);
	}	
	
	/**
	 * 게시판 CSS_SEQ 가져오기 
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public ModuleBbsCssVO selectBbsCssSeq(ModuleBbsVO moduleBbsVO) {
		return bbsCmmnDAO.selectBbsCssSeq(moduleBbsVO);
	}	
}

package egovframework.wzwg.sysMngr.opnsu.bbs.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsVO;


@Repository("OpnsuBbsCmmnDAO")

public class OpnsuBbsCmmnDAO extends EgovAbstractMapper {

    
    /**
     * ㅁ 컨텐츠관리 - 게시판SEQ
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String selectBbsSeq() throws Exception {
        return (String)selectOne("OpnsuBbsCmmnDAO_selectBbsSeq");
    }
    
	/**
	 * ㅁ 컨텐츠관리 - 게시판 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectBbsList(String siteSeq) throws Exception {
		return selectList("OpnsuBbsCmmnDAO_selectBbsList_S", siteSeq);
	}
	
	/**
	 * ㅁ 글양식 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuBbsVO> selectBbsFormList(String siteSeq) throws Exception {
		return selectList("OpnsuBbsCmmnDAO_selectBbsFormList_S", siteSeq);
	}
	
	/**
	 * ㅁ 말머리 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuBbsVO> selectBbsSubospecList(String bbsSeq) throws Exception {
		return selectList("OpnsuBbsCmmnDAO_selectBbsSubospecList_S", bbsSeq);
	}
	
	/**
	 * ㅁ 말머리 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registBbsSubospec(OpnsuBbsVO bbsVO) throws Exception {
		return update("OpnsuBbsCmmnDAO_registBbsSubospec_I", bbsVO);
	}
	
	/**
	 * ㅁ 말머리 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsSubospec(OpnsuBbsVO bbsVO) throws Exception {
		return update("OpnsuBbsCmmnDAO_modifyBbsSubospec_U", bbsVO);
	}
	
	/**
	 * ㅁ 말머리 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteBbsSubospec(OpnsuBbsVO bbsVO) throws Exception {
		return delete("OpnsuBbsCmmnDAO_deleteBbsSubospec_D", bbsVO);
	}
	
   	
}

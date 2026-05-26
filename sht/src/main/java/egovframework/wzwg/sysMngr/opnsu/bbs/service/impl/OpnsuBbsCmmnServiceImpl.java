package egovframework.wzwg.sysMngr.opnsu.bbs.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsCmmnService;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsVO;



@Service("OpnsuBbsCmmnService")
public class OpnsuBbsCmmnServiceImpl extends EgovAbstractServiceImpl implements OpnsuBbsCmmnService {

	
	@Resource(name="OpnsuBbsCmmnDAO")
    protected OpnsuBbsCmmnDAO bbsCmmnDAO;
	
	
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
	public List<OpnsuBbsVO> selectBbsFormList(String siteSeq) throws Exception {
		return bbsCmmnDAO.selectBbsFormList(siteSeq);
	}

	/**
	 * ㅁ 말머리 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuBbsVO> selectBbsSubospecList(String bbsSeq) throws Exception {
		return bbsCmmnDAO.selectBbsSubospecList(bbsSeq);
	}
    
	/**
	 * ㅁ 말머리 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registBbsSubospec(OpnsuBbsVO bbsVO) throws Exception {
		return bbsCmmnDAO.registBbsSubospec(bbsVO);
	}
	
	/**
	 * ㅁ 말머리 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsSubospec(OpnsuBbsVO bbsVO) throws Exception {
		return bbsCmmnDAO.modifyBbsSubospec(bbsVO);
	}
	
	/**
	 * ㅁ 말머리 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteBbsSubospec(OpnsuBbsVO bbsVO) throws Exception {
		return bbsCmmnDAO.deleteBbsSubospec(bbsVO);
	}
	
}

package egovframework.wzwg.sysMngr.cntntsMngr.cntntsStyle.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.cntntsMngr.cntntsStyle.service.CntntsStyleService;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsStyle.service.CntntsStyleVO;

@Service("CntntsStyleService")
public class CntntsStyleServiceImpl extends EgovAbstractServiceImpl implements CntntsStyleService {
	@Resource(name="CntntsStyleDAO")
	CntntsStyleDAO cntntsStyleDAO;

	/**
	 * 컨텐츠 CSS 리스트 조회
	 */
	public List<CntntsStyleVO> selectCntntsStyleList(CntntsStyleVO cntntsStyleVO) {
		return cntntsStyleDAO.selectCntntsStyleList(cntntsStyleVO);
	}

	/**
	 * 컨텐츠 CSS 등록
	 */
	public int registCntntsStyleAjax(CntntsStyleVO cntntsStyleVO) {
		/** 컨텐츠 CSS 시퀀스 조회 */
		String tmplatSeq = cntntsStyleDAO.selectCntnteStyleSeq();
		cntntsStyleVO.setCssSeq(tmplatSeq);
		
		return cntntsStyleDAO.registCntntsStyleAjax(cntntsStyleVO);
	}

	/**
	 * 컨텐츠 CSS 상세조회
	 */
	public CntntsStyleVO selectCntntsStyleDetail(CntntsStyleVO cntntsStyleVO) {
		return cntntsStyleDAO.selectCntntsStyleDetail(cntntsStyleVO);
	}

	/**
	 * 컨텐츠 CSS 수정
	 */
	public int modifyCntntsStyleAjax(CntntsStyleVO cntntsStyleVO) {
		return cntntsStyleDAO.modifyCntntsStyleAjax(cntntsStyleVO);
	}

	/**
	 * 컨텐츠 CSS 삭제
	 */
	public int deleteCntntsStyleAjax(CntntsStyleVO cntntsStyleVO) {
		return cntntsStyleDAO.deleteCntntsStyleAjax(cntntsStyleVO);
	}

	/**
	 * 컨텐츠 CSS 총 카운트 조회
	 */
	public int selectCntntsStyleTotCnt(CntntsStyleVO cntntsStyleVO) {
		return cntntsStyleDAO.selectCntntsStyleTotCnt(cntntsStyleVO);
	}
	
	/**
	 * CSS 적용가능한 모듈 리스트 조회
	 */
	public List<CntntsStyleVO> selectCssProvdModuleList(CntntsStyleVO cntntsStyleVO) {
		return cntntsStyleDAO.selectCssProvdModuleList(cntntsStyleVO);
	}
}

package egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatService;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatVO;

@Service("CntntsTmplatService")
public class CntntsTmplatServiceImpl extends EgovAbstractServiceImpl implements CntntsTmplatService {
	@Resource(name="CntntsTmplatDAO")
	CntntsTmplatDAO cntntsTmplatDAO;

	/**
	 * 컨텐츠 템플릿 리스트 조회
	 */
	public List<CntntsTmplatVO> selectCntntsTmplatList(CntntsTmplatVO cntntsTmplatVO) {
		return cntntsTmplatDAO.selectCntntsTmplatList(cntntsTmplatVO);
	}

	/**
	 * 컨텐츠 템플릿 등록
	 */
	public int registCntntsTmplatAjax(CntntsTmplatVO cntntsTmplatVO) {
		/** 컨텐츠 템플릿 시퀀스 조회 */
		String tmplatSeq = cntntsTmplatDAO.selectCntnteTmplatSeq();
		cntntsTmplatVO.setTmplatSeq(tmplatSeq);
		
		return cntntsTmplatDAO.registCntntsTmplatAjax(cntntsTmplatVO);
	}

	/**
	 * 컨텐츠 템플릿 상세조회
	 */
	public CntntsTmplatVO selectCntntsTmplatDetail(CntntsTmplatVO cntntsTmplatVO) {
		return cntntsTmplatDAO.selectCntntsTmplatDetail(cntntsTmplatVO);
	}

	/**
	 * 컨텐츠 템플릿 수정
	 */
	public int modifyCntntsTmplatAjax(CntntsTmplatVO cntntsTmplatVO) {
		return cntntsTmplatDAO.modifyCntntsTmplatAjax(cntntsTmplatVO);
	}

	/**
	 * 컨텐츠 템플릿 삭제
	 */
	public int deleteCntntsTmplatAjax(CntntsTmplatVO cntntsTmplatVO) {
		return cntntsTmplatDAO.deleteCntntsTmplatAjax(cntntsTmplatVO);
	}

	/**
	 * 컨텐츠 템플릿 총 카운트 조회
	 */
	public int selectCntntsTmplatTotCnt(CntntsTmplatVO cntntsTmplatVO) {
		return cntntsTmplatDAO.selectCntntsTmplatTotCnt(cntntsTmplatVO);
	}

}

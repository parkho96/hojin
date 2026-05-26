package egovframework.wzwg.site.mngr.cntnts.cntPagadiEstbs.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.cntnts.cntPagadiEstbs.service.CntPageadiEstbsVO;

@Repository("CntPageadiEstbsDAO")
public class CntPageadiEstbsDAO extends EgovAbstractMapper{
	/**
	 * 컨텐츠 페이지 추가설정 SEQ 조회
	 * @return
	 */
	public String selectCntPageadiEstbsSeq() throws Exception{
		return (String) selectOne("CntPagadiEstbsDAO_selectCntPAgeadiEstbsSEQ");
	}

	/**
	 * 컨텐츠 페이지 추가설정 정보 입력
	 * @param paramVO
	 * @return
	 */
	public int registCntPageadiEstbs(CntPageadiEstbsVO paramVO) throws Exception{
		return Integer.parseInt(String.valueOf(update("CntPagadiEstbsDAO_registCntPAgeadiEstbs", paramVO)));
				
	}
	
	/**
	 * 컨텐츠 페이지 추가설정 정보 조회
	 * @param paramVO
	 * @return
	 */
	public CntPageadiEstbsVO selectCntPageadiEstbs(CntPageadiEstbsVO paramVO) throws Exception{
		return (CntPageadiEstbsVO)selectOne("CntPagadiEstbsDAO_selectCntPAgeadiEstbs", paramVO);
	}
	
	/**
	 * 담당관 SEQ 조회
	 * @return
	 * @throws Exception
	 */
	public String selectOclhgSeq() throws Exception{
		return (String) selectOne("CntPagadiEstbsDAO_selectOclhgSEQ");
	}
	
	/**
	 * 담당관 정보 입력
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registOclhg(CntPageadiEstbsVO paramVO) throws Exception{
		return Integer.parseInt(String.valueOf(update("CntPagadiEstbsDAO_registOclhg", paramVO)));
	}
	
	/**
	 * 담당관 정보 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyOclhg(CntPageadiEstbsVO paramVO) throws Exception{
		return Integer.parseInt(String.valueOf(update("CntPagadiEstbsDAO_modifyOclhg", paramVO)));
	}
	
	/**
	 * 담당관 목록 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<CntPageadiEstbsVO> selectOclhgList(CntPageadiEstbsVO paramVO) throws Exception{
		return selectList("CntPagadiEstbsDAO_selectOclhgList", paramVO);
	}
	
	/**
	 * 담당관 정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteOclhg(CntPageadiEstbsVO paramVO) throws Exception{
		return update("CntPagadiEstbsDAO_modifyOclhgUseAT", paramVO);
	}
	
	/**
	 * 담당관 순서조회 UP
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public CntPageadiEstbsVO selectoclhgOrdrUp(CntPageadiEstbsVO paramVO) throws Exception{
		return (CntPageadiEstbsVO) selectOne("CntPagadiEstbsDAO_selectoclhgOrdrUp", paramVO);
	}
	
	/**
	 * 담당관 순서조회 DOWN
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public CntPageadiEstbsVO selectoclhgOrdrDown(CntPageadiEstbsVO paramVO) throws Exception{
		return (CntPageadiEstbsVO) selectOne("CntPagadiEstbsDAO_selectoclhgOrdrDown", paramVO);
	}
	
	/**
	 * 담당관 순서변경
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int oclhgOrdrChange(CntPageadiEstbsVO paramVO) throws Exception{
		return update("CntPagadiEstbsDAO_oclhgOrdrChange", paramVO);
	}
	
	
	/**
	 * 저작권 정보 입력
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registPagecpyrht(CntPageadiEstbsVO paramVO) throws Exception{
		paramVO.setPagecpyrhtSeq(paramVO.getPagadiestbsSeq()); // 페이지별 저작권 정보는 1row이기 때문에 같은 키를 사용하도록 한다
		return update("CntPagadiEstbsDAO_registPagecpyrht", paramVO);
	}
	
	/**
	 * 저작권 정보 조회
	 * @param paramVO
	 * @return
	 */
	public CntPageadiEstbsVO selectPagecpyrht(CntPageadiEstbsVO paramVO) throws Exception{
		paramVO.setPagecpyrhtSeq(paramVO.getPagadiestbsSeq()); // 페이지별 저작권 정보는 1row이기 때문에 같은 키를 사용하도록 한다
		return (CntPageadiEstbsVO) selectOne("CntPagadiEstbsDAO_selectPagecpyrht", paramVO);
	}
	

	/**
	 * 평가하기 설정 정보 입력
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registEvlEstbs(CntPageadiEstbsVO paramVO) throws Exception{
		paramVO.setPagevlestbsSeq(paramVO.getPagadiestbsSeq());
		return update("CntPagadiEstbsDAO_registEvlEstbs", paramVO);
	}
	
	/**
	 * 평가하기 설정 정보 조회
	 * @param paramVO
	 * @return
	 */
	public CntPageadiEstbsVO selectEvlEstbs(CntPageadiEstbsVO paramVO) throws Exception{
		paramVO.setPagevlestbsSeq(paramVO.getPagadiestbsSeq());
		return (CntPageadiEstbsVO) selectOne("CntPagadiEstbsDAO_selectEvlEstbs", paramVO);
	}
	
	/**
	 * 평가하기 점수 입력
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registEvlScore(CntPageadiEstbsVO paramVO) throws Exception{
		return update("CntPagadiEstbsDAO_registEvlScore", paramVO);
	}
	
	/**
	 * 평가하기 요약정보
	 * @param paramVO
	 * @return
	 */
	public CntPageadiEstbsVO selectEvlScoreSummary(CntPageadiEstbsVO paramVO) throws Exception{
		return (CntPageadiEstbsVO) selectOne("CntPagadiEstbsDAO_registEvlScoreSummary", paramVO);
	}
	
	/**
	 * 평가점수 목록 상세보기
	 * @param paramVO
	 * @return
	 */
	public List<CntPageadiEstbsVO> selectEvlScoreList(CntPageadiEstbsVO paramVO) throws Exception{
		paramVO.setPagevlestbsSeq(paramVO.getPagadiestbsSeq());
		return selectList("CntPagadiEstbsDAO_selectEvlScoreList", paramVO);
	}
	
	/**
	 * 평가하기 컨텐츠명
	 * @param paramVO
	 * @return
	 */
	public CntPageadiEstbsVO selectCntntsNm(CntPageadiEstbsVO paramVO) throws Exception {
		return (CntPageadiEstbsVO) selectOne("CntPagadiEstbsDAO_selectCntntsNm", paramVO);
	}
	
	
	/**
	 * 스킨 설정 정보 입력
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registSkinEstbs(CntPageadiEstbsVO paramVO) throws Exception{
		paramVO.setPagevlestbsSeq(paramVO.getPagadiestbsSeq());
		return update("CntPagadiEstbsDAO_registSkinEstbs", paramVO);
	}
	
	/**
	 * 스킨 설정 정보 조회
	 * @param paramVO
	 * @return
	 */
	public CntPageadiEstbsVO selectSkinEstbs(CntPageadiEstbsVO paramVO) throws Exception{
		paramVO.setPagevlestbsSeq(paramVO.getPagadiestbsSeq());
		return (CntPageadiEstbsVO) selectOne("CntPagadiEstbsDAO_selectSkinEstbs", paramVO);
	}
}

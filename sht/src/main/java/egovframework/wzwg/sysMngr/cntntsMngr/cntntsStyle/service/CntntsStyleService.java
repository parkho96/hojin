package egovframework.wzwg.sysMngr.cntntsMngr.cntntsStyle.service;

import java.util.List;

public interface CntntsStyleService {

	/** 컨텐츠 CSS 리스트조회 */
	List<CntntsStyleVO> selectCntntsStyleList(CntntsStyleVO cntntsStyleVO);

	/** 컨텐츠 CSS 등록 */
	int registCntntsStyleAjax(CntntsStyleVO cntntsStyleVO);

	/** 컨텐츠 CSS 상세조회 */
	CntntsStyleVO selectCntntsStyleDetail(CntntsStyleVO cntntsStyleVO);

	/** 컨텐츠 CSS 수정 */
	int modifyCntntsStyleAjax(CntntsStyleVO cntntsStyleVO);

	/** 컨텐츠 CSS 삭제 */
	int deleteCntntsStyleAjax(CntntsStyleVO cntntsStyleVO);

	/** 컨텐츠 CSS 총 카운트 조회 */
	int selectCntntsStyleTotCnt(CntntsStyleVO cntntsStyleVO);

	/** CSS 적용가능한 모듈 리스트 조회 */
	List<CntntsStyleVO> selectCssProvdModuleList(CntntsStyleVO cntntsStyleVO);
}

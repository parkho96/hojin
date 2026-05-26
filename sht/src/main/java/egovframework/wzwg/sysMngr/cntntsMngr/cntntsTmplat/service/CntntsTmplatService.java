package egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service;

import java.util.List;

public interface CntntsTmplatService {

	/** 컨텐츠 템플릿 리스트조회 */
	List<CntntsTmplatVO> selectCntntsTmplatList(CntntsTmplatVO cntntsTmplatVO);

	/** 컨텐츠 템플릿 등록 */
	int registCntntsTmplatAjax(CntntsTmplatVO cntntsTmplatVO);

	/** 컨텐츠 템플릿 상세조회 */
	CntntsTmplatVO selectCntntsTmplatDetail(CntntsTmplatVO cntntsTmplatVO);

	/** 컨텐츠 템플릿 수정 */
	int modifyCntntsTmplatAjax(CntntsTmplatVO cntntsTmplatVO);

	/** 컨텐츠 템플릿 삭제 */
	int deleteCntntsTmplatAjax(CntntsTmplatVO cntntsTmplatVO);

	/** 컨텐츠 템플릿 총 카운트 조회 */
	int selectCntntsTmplatTotCnt(CntntsTmplatVO cntntsTmplatVO);

}

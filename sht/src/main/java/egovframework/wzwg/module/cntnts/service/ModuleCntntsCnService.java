package egovframework.wzwg.module.cntnts.service;

import java.util.List;

public interface ModuleCntntsCnService {

	/** 컨텐츠 데이터 리스트 */
	List<ModuleCntntsVO> selectModuleCntntsCnList(ModuleCntntsVO moduleCntntsVO);

	/** 컨텐츠 데이터 상세조회 */
	ModuleCntntsVO selectModuleCntntsCnDetail(ModuleCntntsVO moduleCntntsVO);

	/** 컨텐츠 데이터 등록 */
	int registModuleCntntsCnAjax(ModuleCntntsVO moduleCntntsVO);

	/** 컨텐츠 데이터 삭제 */
	int deleteModuleCntntsCnAjax(ModuleCntntsVO moduleCntntsVO);

	/** 총 카운트 조회 */
	int selectCntntsCnTotCnt(ModuleCntntsVO moduleCntntsVO);

	/** 적용된 템플릿 조회 */
	ModuleCntntsVO selectModuleCntntsCnTmplatDetail(ModuleCntntsVO moduleCntntsVO);

    /**
     * 컨텐츠 상세 - 서비스 화면
     */
    ModuleCntntsVO selectCntntscnScrinCntnts(ModuleCntntsVO moduleCntntsVO);

    /**
     * 컨텐츠 내용 적용된 템플릿으로 초기화 
     */
    int registModuleCntntsCnTemplatInitAjax(ModuleCntntsVO moduleCntntsVO);
    
     int modifyModuleCntntsCnAjax(ModuleCntntsVO moduleCntntsVO) ;
}

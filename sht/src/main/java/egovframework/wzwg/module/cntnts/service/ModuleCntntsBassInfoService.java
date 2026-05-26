package egovframework.wzwg.module.cntnts.service;

import java.util.List;

public interface ModuleCntntsBassInfoService {

	/** 게시판 기본정보 리스트 */
	List<ModuleCntntsVO> selectModuleCntntsList(ModuleCntntsVO moduleCntntsVO);
    
    /** 게시판SEQ */
    String selectCntntsSeq();

	/** 게시판 기본정보 등록 */
	int registModuleCntntsAjax(ModuleCntntsVO moduleCntntsVO);

	/** 게시판 기본정보 상세조회 */
	ModuleCntntsVO selectCntntsBassInfoDetail(ModuleCntntsVO moduleCntntsVO);

	/** 게시판 기본정보 수정 */
	int modifyModuleCntntsAjax(ModuleCntntsVO moduleCntntsVO);
	
	/** 게시판 기본정보 수정 */
	int modifyModuleCntntsTmplatAjax(ModuleCntntsVO moduleCntntsVO);
    
    /**
     * ㅁ 게시판 초기 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String registCntntsBassInfoInit(ModuleCntntsVO moduleCntntsVO) throws Exception;
    
    public int modifyModuleCntnts(ModuleCntntsVO moduleCntntsVO);
    
    /**
     * ㅁ 게시판 초기 기본데이터 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registCntntsDataCopy(ModuleCntntsVO moduleCntntsVO) throws Exception;

}

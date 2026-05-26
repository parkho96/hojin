package egovframework.wzwg.module.bbs.bbsForm.service;

import java.util.List;

public interface ModuleBbsFormService {

	/** 게시판 양식 관리 리스트 조회 */
	List<ModuleBbsFormVO> selectModuleBbsFormList(ModuleBbsFormVO bbsFormVO);

	/** 게시판 양식 관리 상세조회 */
	ModuleBbsFormVO selectModuleBbsFormDetail(ModuleBbsFormVO bbsFormVO);

	/** 게시판 양식 관리 등록 */
	int registModuleBbsFormAjax(ModuleBbsFormVO bbsFormVO);

	/** 게시판 양식 관리 수정 */
	int modifyModuleBbsFormAjax(ModuleBbsFormVO bbsFormVO);

	/** 게시판 양식 관리 삭제 */
	int deleteModuleBbsFormAjax(ModuleBbsFormVO bbsFormVO);

	/** 게시판 양식 총 카운트 조회 */
	int selectModuleBbsFormTotCnt(ModuleBbsFormVO bbsFormVO);

	/** 게시판 리스트 조회 */
	List<ModuleBbsFormVO> selectBbsApplcListPopup(ModuleBbsFormVO bbsFormVO);

	/** 게시판 매핑 리스트 조회 */
	ModuleBbsFormVO selectNttBbsMappingDetail(ModuleBbsFormVO bbsFormVO);

	/** 게시판 매핑 테이블 입력 */
	void registNttBbsForm(ModuleBbsFormVO bbsFormVO);
	
	/** 게시판 매핑 리스트 CRUD 판별 */
	int nttBbsFormDstnctn(ModuleBbsFormVO bbsFormVO);
	

}

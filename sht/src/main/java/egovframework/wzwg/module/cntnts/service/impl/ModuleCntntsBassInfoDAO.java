package egovframework.wzwg.module.cntnts.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.cntnts.service.ModuleCntntsVO;


@Repository("ModuleCntntsBassInfoDAO")
public class ModuleCntntsBassInfoDAO extends EgovAbstractMapper{

	/**
	 * 컨텐츠 기본정보 리스트
	 * @param moduleCntntsVO
	 * @return
	 */
	public List<ModuleCntntsVO> selectModuleCntntsList(ModuleCntntsVO moduleCntntsVO) {
		return selectList("ModuleCntntsBassInfoDAO_selectModuleCntntsList", moduleCntntsVO);
	}

	/**
	 * 컨텐츠 기본정보 시퀀스 조회(CNTNTS_SEQ)
	 * @return
	 */
	public String selectModuleCntntsSeq() {
		return (String) selectOne("ModuleCntntsBassInfoDAO_selectModuleCntntsSeq", null);
	}

	/**
	 * 컨텐츠 기본정보 등록
	 * @param moduleCntntsVO
	 * @return
	 */
	public int registModuleCntntsAjax(ModuleCntntsVO moduleCntntsVO) {
		return update("ModuleCntntsBassInfoDAO_registModuleCntntsAjax", moduleCntntsVO);
	}

	/**
	 * 컨텐츠 기본정보 상세조회
	 * @param moduleCntntsVO
	 * @return
	 */
	public ModuleCntntsVO selectCntntsBassInfoDetail(ModuleCntntsVO moduleCntntsVO) {
		return (ModuleCntntsVO) selectOne("ModuleCntntsBassInfoDAO_selectCntntsBassInfoDetail", moduleCntntsVO);
	}

	/**
	 * 컨텐츠 템플릿정보 수정
	 * @param moduleCntntsVO
	 * @return
	 */
	public int modifyModuleCntntsTmplatAjax(ModuleCntntsVO moduleCntntsVO) {
		return update("ModuleCntntsBassInfoDAO_modifyModuleCntntsTmplatAjax", moduleCntntsVO);
	}
	
	/**
	 * 컨텐츠 기본정보 수정
	 * @param moduleCntntsVO
	 * @return
	 */
	public int modifyModuleCntntsAjax(ModuleCntntsVO moduleCntntsVO) {
		return update("ModuleCntntsBassInfoDAO_modifyModuleCntntsAjax", moduleCntntsVO);
	}
    
    /**
     * ㅁ 게시판 초기 기본데이터 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registCntntsDataCopy(ModuleCntntsVO moduleCntntsVO) throws Exception {
        insert("ModuleCntntsBassInfoDAO_registCntntsDataCopy", moduleCntntsVO);
    }

}

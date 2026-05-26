package egovframework.wzwg.module.cntnts.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.cntnts.service.ModuleCntntsVO;


@Repository("ModuleCntntsCnDAO")
public class ModuleCntntsCnDAO extends EgovAbstractMapper{

	/**
	 * 컨텐츠 데이터 리스트
	 * @param moduleCntntsVO
	 * @return
	 */
	public List<ModuleCntntsVO> selectModuleCntntsCnList(ModuleCntntsVO moduleCntntsVO) {
		return selectList("ModuleCntntsCnDAO_selectModuleCntntsCnList", moduleCntntsVO);
	}

	/**
	 * 컨텐츠 데이터 상세조회
	 * @param moduleCntntsVO
	 * @return
	 */
	public ModuleCntntsVO selectModuleCntntsCnDetail(ModuleCntntsVO moduleCntntsVO) {
		return (ModuleCntntsVO) selectOne("ModuleCntntsCnDAO_selectModuleCntntsCnDetail", moduleCntntsVO);
	}
	
	/**
	 * 컨텐츠 데이터 시퀀스 조회
	 * @return
	 */
	public String selectModuleCntntsCnSeq() {
		return (String) selectOne("ModuleCntntsCnDAO_selectModuleCntntsCnSeq", null);
	}

	/**
	 * 컨텐츠 데이터 등록
	 * @param moduleCntntsVO
	 * @return
	 */
	public int registModuleCntntsCnAjax(ModuleCntntsVO moduleCntntsVO) {
		return update("ModuleCntntsCnDAO_registModuleCntntsCnAjax", moduleCntntsVO);
	}

	/**
	 * 컨텐츠 데이터 삭제
	 * @param moduleCntntsVO
	 * @return
	 */
	public int deleteModuleCntntsCnAjax(ModuleCntntsVO moduleCntntsVO) {
		return update("ModuleCntntsCnDAO_deleteModuleCntntsCnAjax", moduleCntntsVO);
	}
	
	/**
	 * 컨텐츠 데이터 수정
	 * @param moduleCntntsVO
	 * @return
	 */
	public int modifyModuleCntntsCnAjax(ModuleCntntsVO moduleCntntsVO) {
		return update("ModuleCntntsCnDAO_modifyModuleCntntsCnAjax", moduleCntntsVO);
	}

	/**
	 * 총 카운트 조회
	 * @param moduleCntntsVO
	 * @return
	 */
	
	public int selectCntntsCnTotCnt(ModuleCntntsVO moduleCntntsVO) {
		return (Integer)selectOne("ModuleCntntsCnDAO_selectCntntsCnTotCnt", moduleCntntsVO);
	}

	/**
	 * 적용된 템플릿 조회
	 * @param moduleCntntsVO
	 * @return
	 */
	public ModuleCntntsVO selectModuleCntntsCnTmplatDetail(ModuleCntntsVO moduleCntntsVO) {
		return (ModuleCntntsVO) selectOne("ModuleCntntsCnDAO_selectModuleCntntsCnTmplatDetail", moduleCntntsVO);
	}

    /**
     * 컨텐츠 상세 - 서비스 화면
     */
    public ModuleCntntsVO selectCntntscnScrinCntnts(ModuleCntntsVO moduleCntntsVO) {
        return (ModuleCntntsVO)selectOne("ModuleCntntsCnDAO_selectCntntscnScrinCntnts", moduleCntntsVO);
    }

}

package egovframework.wzwg.module.schdul.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.schdul.service.ModuleSchdulBassInfoVO;
import egovframework.wzwg.module.schdul.service.ModuleSchdulCssVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;


@Repository("ModuleSchdulBassInfoDAO")
public class ModuleSchdulBassInfoDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;

	
	/**
	 * ㅁ 일정  목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectSchdulBassInfoList(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return selectList("ModuleSchdulBassInfoDAO_selectSchdulBassInfoList", paramVO);
	}
	
	/**
	 * ㅁ 일정 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleSchdulBassInfoVO selectSchdulBassInfoDetail(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return (ModuleSchdulBassInfoVO)selectOne("ModuleSchdulBassInfoDAO_selectSchdulBassInfoDetail", paramVO);
	}
	
	/**
     * ㅁ 일정 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySchdulBassInfo(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return update("ModuleSchdulBassInfoDAO_modifySchdulBassInfo", paramVO);
	}
    
    /**
     * ㅁ 일정 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSchdulBassInfo(ModuleSchdulBassInfoVO paramVO) throws Exception {
    	return update("ModuleSchdulBassInfoDAO_registSchdulBassInfo", paramVO);
    }
    
    /**
     * ㅁ 일정 기본정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int deleteSchdulBassInfo(ModuleSchdulBassInfoVO paramVO) throws Exception {
    	return update("ModuleSchdulBassInfoDAO_deleteSchdulBassInfo", paramVO);
    }
	
    /**
     * ㅁ 일정 아이디 생성
     * @return
     * @throws Exception
     */
    public String selectSchdulNextSeq() throws Exception {
    	return (String)selectOne("ModuleSchdulBassInfoDAO_selectSchdulNextSeq");
    }
    
	public List<ModuleSchdulBassInfoVO> selectSchdulMainScrinCntnts(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return selectList("ModuleSchdulBassInfoDAO_selectSchdulMainScrinCntnts", paramVO);
	}
	
	public List<ModuleSchdulBassInfoVO> selectSchdulMainScrinCntntsToMonth(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return selectList("ModuleSchdulBassInfoDAO_selectSchdulMainScrinCntntsToMonth", paramVO);
	}
	
	public   ModuleSchdulBassInfoVO  selectSchdulScrinCntnts(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return  (ModuleSchdulBassInfoVO) selectOne("ModuleSchdulBassInfoDAO_selectSchdulScrinCntnts", paramVO);
	}

    /**
     * ㅁ 일정 CSS 리스트 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleSchdulCssVO> selectSchdulCssList(ModuleSchdulBassInfoVO paramVO) {
		return selectList("ModuleSchdulBassInfoDAO_selectSchdulCssList", paramVO);
	}

    /**
     * ㅁ 일정 CSS 상세 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleSchdulCssVO selectSchdulCssDetail(ModuleSchdulCssVO paramVO) {
		return (ModuleSchdulCssVO) selectOne("ModuleSchdulBassInfoDAO_selectSchdulCssDetail", paramVO);
	}

    /**
     * ㅁ 일정 CSS 등록/수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySchdulCss(ModuleSchdulBassInfoVO paramVO) {
		return update("ModuleSchdulBassInfoDAO_modifySchdulCss", paramVO);
	}

    /**
     * ㅁ 일정 CSS 시퀀스 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectSchdulCssSeq(ModuleSchdulBassInfoVO paramVO) {
		return (String) selectOne("ModuleSchdulBassInfoDAO_selectSchdulCssSeq", paramVO);
	}
	
	/**
     * ㅁ 일정 모듈연결 - 생성된 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleSchdulBassInfoVO> selectModuleList(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return selectList("ModuleSchdulBassInfoDAO_selectModuleList_S", paramVO);
	}
	
	/**
     * ㅁ 일정 모듈연결 - 모듈 연결
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registConnModuleList(ModuleSchdulBassInfoVO paramVO) throws Exception {
		
		String ctgrySeq = (String) selectOne("ModuleSchdulBassInfoDAO_getNextCtgrtySeq_S");
		
		paramVO.setCtgrySeq(ctgrySeq);
		
		// 범주 등록
		update("ModuleSchdulBassInfoDAO_registSchdulCtgry_I", paramVO);
		
		// 컨텐츠 매핑 등록
		return update("ModuleSchdulBassInfoDAO_registSchdulSiteCntnts_I", paramVO);
	}
	
	/**
     * ㅁ 일정 모듈연결 - 연결된 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleSchdulBassInfoVO> selectConnModuleList(ModuleSchdulBassInfoVO paramVO) throws Exception {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
		return selectList("ModuleSchdulBassInfoDAO_selectConnModuleList_S", paramVO);
	}
	
	/**
     * ㅁ 일정 모듈연결 - 연결 모듈 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteConnModule(ModuleSchdulBassInfoVO paramVO) throws Exception {
		
		int result = 0;
		
		result = delete("ModuleSchdulBassInfoDAO_deleteConnModuleSitecntnts_D", paramVO);
		
		if(result > 0){
			return delete("ModuleSchdulBassInfoDAO_deleteConnModuleCtgry_D", paramVO);
		}else{
			return result;
		}
		
	}
	
	public List<EgovMap> selectCalMonList(ModuleSchdulBassInfoVO paramVO) {
		return selectList("ModuleSchdulBassInfoDAO_selectCalMonList", paramVO);
	}
	
	public List<EgovMap> selectCalList(ModuleSchdulBassInfoVO paramVO) {
		return selectList("ModuleSchdulBassInfoDAO_selectCalList", paramVO);
	}

}

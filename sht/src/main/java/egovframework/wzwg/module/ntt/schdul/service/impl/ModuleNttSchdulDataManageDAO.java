package egovframework.wzwg.module.ntt.schdul.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.schdul.service.ModuleNttSchdulDataManageVO;

@Repository("ModuleNttSchdulDataManageDAO")
public class ModuleNttSchdulDataManageDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;
	
	/**
	 * ㅁ 일정 데이터  목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	
	public List<ModuleNttSchdulDataManageVO> selectNttSchdulDataList(ModuleNttSchdulDataManageVO paramVO) throws Exception {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
		return selectList("ModuleNttSchdulDataManageDAO_selectNttSchdulDataList", paramVO);
	}
	
	/**
	 * ㅁ 일정 데이터 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttSchdulDataManageVO selectNttSchdulDataDetail(ModuleNttSchdulDataManageVO paramVO) throws Exception {
		return (ModuleNttSchdulDataManageVO)selectOne("ModuleNttSchdulDataManageDAO_selectNttSchdulDataDetail", paramVO);
	}
	
	/**
     * ㅁ 일정 데이터 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttSchdulData(ModuleNttSchdulDataManageVO paramVO) throws Exception {
		
		// 범주 수정
		update("ModuleNttSchdulDataManageDAO_modifySchdulCtgry_U", paramVO);
				
		return update("ModuleNttSchdulDataManageDAO_modifyNttSchdulData", paramVO);
	}
    
    /**
     * ㅁ 일정 데이터 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registNttSchdulData(ModuleNttSchdulDataManageVO paramVO) throws Exception {
    	
    	String ctgrySeq = (String) selectOne("ModuleNttSchdulDataManageDAO_getNextCtgrtySeq_S");
		
		paramVO.setCtgrySeq(ctgrySeq);
		
		// 범주 등록
		update("ModuleNttSchdulDataManageDAO_registSchdulCtgry_I", paramVO);
		
    	return update("ModuleNttSchdulDataManageDAO_registNttSchdulData", paramVO);
    }
    
    /**
     * ㅁ 일정 데이터 기본정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int deleteNttSchdulData(ModuleNttSchdulDataManageVO paramVO) throws Exception {
    	return update("ModuleNttSchdulDataManageDAO_deleteNttSchdulData", paramVO);
    }
	
    /**
     * ㅁ 일정 데이터 아이디 생성
     * @return
     * @throws Exception
     */
    public String selectNttSchdulDataNextSeq() throws Exception {
    	return (String)selectOne("ModuleNttSchdulDataManageDAO_selectNttSchdulDataNextSeq");
    }
    
    /**
     * ㅁ 일정 데이터 부가정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttSchdulAdiData(ModuleNttSchdulDataManageVO paramVO) throws Exception {
		return update("ModuleNttSchdulDataManageDAO_modifyNttSchdulAdiData", paramVO);
	}
    
    /**
     * ㅁ 일정 데이터 부가정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registNttSchdulAdiData(ModuleNttSchdulDataManageVO paramVO) throws Exception {
    	return update("ModuleNttSchdulDataManageDAO_registNttSchdulAdiData", paramVO);
    }
    
    /**
     * ㅁ 일정 데이터 부가정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int deleteNttSchdulAdiData(ModuleNttSchdulDataManageVO paramVO) throws Exception {
    	return update("ModuleNttSchdulDataManageDAO_deleteNttSchdulAdiData", paramVO);
    }
}

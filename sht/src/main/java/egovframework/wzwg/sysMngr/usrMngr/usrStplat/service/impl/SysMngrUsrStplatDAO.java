package egovframework.wzwg.sysMngr.usrMngr.usrStplat.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.usrMngr.usrStplat.service.SysMngrUsrStplatVO;

/**
 * ㅁ 시스템 - 사용자관리 - 가입약관관리
 * ㅁ DC   
 * - 시스템관리자가 사용자를 관리
 * - 생선된 사용자는 사용자 관리자 페이지를 이용하여 접속
 * @author 김c
 *
 */
@Repository("SysMngrUsrStplatDAO")

public class SysMngrUsrStplatDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;

    public List<SysMngrUsrStplatVO> selectSysUsrStplatList(SysMngrUsrStplatVO paramVO) throws Exception {

    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	
        return selectList("SysMngrUsrStplatDAO_selectSysUsrStplatList", paramVO);
    }	
    public int selectSysUsrStplatListCnt(SysMngrUsrStplatVO paramVO) throws Exception {

        return (Integer)selectOne("SysMngrUsrStplatDAO_selectSysUsrStplatListCnt", paramVO);
    }
    public SysMngrUsrStplatVO selectSysUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception {
    	

    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	
        return (SysMngrUsrStplatVO)selectOne("SysMngrUsrStplatDAO_selectSysUsrStplat", paramVO);
    }
    public int registSysUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception {

        return update("SysMngrUsrStplatDAO_registSysUsrStplat", paramVO);
    }
    public int modifySysUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception {

        return update("SysMngrUsrStplatDAO_modifySysUsrStplat", paramVO);
    }
    public int deleteSysUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception {

        return update("SysMngrUsrStplatDAO_deleteSysUsrStplat", paramVO);
    }
    public List<SysMngrUsrStplatVO> selectSysUsrStplatHistList(SysMngrUsrStplatVO paramVO) throws Exception {
    	
    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	
        return selectList("SysMngrUsrStplatDAO_selectSysUsrStplatHistList", paramVO);
    }
    public int registSysUsrStplatHist(SysMngrUsrStplatVO paramVO) throws Exception {

        return update("SysMngrUsrStplatDAO_registSysUsrStplatHist", paramVO);
    }
    public int deleteSysUsrStplatHist(SysMngrUsrStplatVO paramVO) throws Exception {

        return update("SysMngrUsrStplatDAO_deleteSysUsrStplatHist", paramVO);
    }
    
	/**
	 * ㅁ  시스템 - 사용자관리 - 가입약관관리 - 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SysMngrUsrStplatVO> selectUsrStplatList(SysMngrUsrStplatVO paramVO) throws Exception {
    	return selectList("SysMngrUsrStplatDAO_selectUsrStplatList_S", paramVO);
    }

    /**
	 * ㅁ  시스템 - 사용자관리 - 가입약관관리 - 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectUsrStplatListTotCnt(SysMngrUsrStplatVO paramVO) throws Exception {
    	return (Integer)selectOne("SysMngrUsrStplatDAO_selectUsrStplatListTotCnt_S", paramVO);
    }
    
    /**
	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception {
		
		String sbscrbinfoSeq = (String) selectOne("SysMngrUsrStplatDAO_selectNextSbscrbinfoSeq_S", new String());
		
		paramVO.setSbscrbinfoSeq(sbscrbinfoSeq);

		return update("SysMngrUsrStplatDAO_registUsrStplatInfo_I", paramVO);
    }
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 가입문항 SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextSbscrbQesitmSeq() throws Exception {
		return (String) selectOne("SysMngrUsrStplatDAO_selectNextSbscrbQesitmSeq_S", new String());
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 가입문항 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void registUsrStplatQesitm(SysMngrUsrStplatVO paramVO) throws Exception {
		insert("SysMngrUsrStplatDAO_registUsrStplatQesitm_I", paramVO);
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 가입항목 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void registUsrStplatIem(SysMngrUsrStplatVO paramVO) throws Exception {
		insert("SysMngrUsrStplatDAO_registUsrStplatIem_I", paramVO);
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception {
		
		int result = 0;
		
		result = update("SysMngrUsrStplatDAO_updateUsrStplatInfo_I", paramVO);
		
		if("N".equals(paramVO.getSbscrbQestnEstbsAt())){
			delete("SysMngrUsrStplatDAO_deleteUsrStplatQesitmList_D", paramVO);
			delete("SysMngrUsrStplatDAO_deleteUsrStplatIemList_D", paramVO);
		}
		
		return result;
    }

	/**
	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 가입문항 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyUsrStplatQesitm(SysMngrUsrStplatVO paramVO) throws Exception {
		return update("SysMngrUsrStplatDAO_updateUsrStplatQesitm_U", paramVO);
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 가입항목 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyUsrStplatIem(SysMngrUsrStplatVO paramVO) throws Exception {
		return update("SysMngrUsrStplatDAO_updateUsrStplatIem_U", paramVO);
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 객관식 가입항목 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteUsrStplatObjctIemList(SysMngrUsrStplatVO paramVO) throws Exception {
		return update("SysMngrUsrStplatDAO_deleteUsrStplatObjctIemList_D", paramVO);
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 가입정보설정여부 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int selectSbscrbinfoSeq(SysMngrUsrStplatVO paramVO) throws Exception {
		return (Integer) selectOne("SysMngrUsrStplatDAO_selectSbscrbinfoSeq_S", paramVO);
    }
	
    /**
	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public SysMngrUsrStplatVO selectUsrStplatDetail(SysMngrUsrStplatVO paramVO) throws Exception {
    	return (SysMngrUsrStplatVO) selectOne("SysMngrUsrStplatDAO_selectUsrStplatDetail_S", paramVO);
    }
	
	/**
     * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 가입문항 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<SysMngrUsrStplatVO> selectSbscrbQesitmList(SysMngrUsrStplatVO paramVO) throws Exception {
   		return selectList("SysMngrUsrStplatDAO_selectSbscrbQesitmList_S", paramVO);
   	}
	
   	/**
     * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 객관식 항목 목록 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public List<SysMngrUsrStplatVO> selectSbscrbIemList(SysMngrUsrStplatVO paramVO) throws Exception {
   		return selectList("SysMngrUsrStplatDAO_selectSbscrbIemList_S", paramVO);
   	}
	
    
}

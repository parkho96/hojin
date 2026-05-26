package egovframework.wzwg.site.mngr.menu.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.menu.service.SiteMngrBkmkVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuVO;

@Repository("siteMngrBkmkDAO")
public class SiteMngrBkmkDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;
	
	/**
	 * 사이트 메뉴 목록
	 * @return
	 */
	
	public List<SiteMngrMenuVO> selectSiteMngrMenuList(SiteMngrBkmkVO paramVO) {
		return selectList("siteMngrBkmkDAO_selectSiteMngrMenuList", paramVO);
	}
	
	
	
	public List<SiteMngrMenuVO> selectSiteMngrBkmkList(SiteMngrBkmkVO paramVO) {
		return selectList("siteMngrBkmkDAO_selectSiteMngrBkmkList", paramVO);
	}
	  
    
    public String seletSiteMngrBkmkSeq() {
        return (String)selectOne("siteMngrBkmkDAO_seletSiteMngrBkmkSeq");
    }
	
	/**
	 * 사이트 메뉴 등록
	 * @return
	 */
	public void registSiteMngrBkmk(SiteMngrBkmkVO paramVO) {
		insert("siteMngrBkmkDAO_registSiteMngrBkmk", paramVO);
	}
	 
	
	/**
	 * 사이트 메뉴 수정
	 * @return
	 */
	public void modifySiteMngrBkmk(SiteMngrBkmkVO paramVO) {
		update("siteMngrBkmkDAO_modifySiteMngrBkmk", paramVO);
	}

	/**
	 * 사이트 메뉴 삭제
	 * @return
	 */
	public int deleteSiteMngrBkmk(SiteMngrBkmkVO paramVO) {
		return delete("siteMngrBkmkDAO_deleteSiteMngrBkmk", paramVO);
	}
 
}

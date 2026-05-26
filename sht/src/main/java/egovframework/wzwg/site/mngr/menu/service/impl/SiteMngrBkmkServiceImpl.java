package egovframework.wzwg.site.mngr.menu.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.menu.service.SiteMngrBkmkService;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrBkmkVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuVO;

@Service("siteMngrBkmkService")
public class SiteMngrBkmkServiceImpl extends EgovAbstractServiceImpl implements SiteMngrBkmkService {
    
    @Resource(name="siteMngrBkmkDAO")
    private SiteMngrBkmkDAO siteMngrBkmkDAO;
 
	
	/**
	 * 사이트 메뉴 목록
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SiteMngrMenuVO> selectSiteMngrMenuList(SiteMngrBkmkVO paramVO) {
		return siteMngrBkmkDAO.selectSiteMngrMenuList(paramVO);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<SiteMngrMenuVO> selectSiteMngrBkmkList(SiteMngrBkmkVO paramVO) {
		return siteMngrBkmkDAO.selectSiteMngrBkmkList(paramVO);
	}
	  
    
    public String seletSiteMngrBkmkSeq() {
        return siteMngrBkmkDAO.seletSiteMngrBkmkSeq();
    }
	
	/**
	 * 사이트 메뉴 등록
	 * @return
	 */
	public void registSiteMngrBkmk(SiteMngrBkmkVO paramVO) {
		paramVO.setMngrBkmkSeq(seletSiteMngrBkmkSeq());
		siteMngrBkmkDAO.registSiteMngrBkmk(paramVO);
	}
	 
	
	/**
	 * 사이트 메뉴 수정
	 * @return
	 */
	public void modifySiteMngrBkmk(SiteMngrBkmkVO paramVO) {
		siteMngrBkmkDAO.modifySiteMngrBkmk(paramVO);
	}

	/**
	 * 사이트 메뉴 삭제
	 * @return
	 */
	public int deleteSiteMngrBkmk(SiteMngrBkmkVO paramVO) {
		return siteMngrBkmkDAO.deleteSiteMngrBkmk(paramVO);
	}
 
}

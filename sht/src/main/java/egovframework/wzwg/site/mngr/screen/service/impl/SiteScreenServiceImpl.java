package egovframework.wzwg.site.mngr.screen.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.scrin.service.ScrinCntntsService;
import egovframework.wzwg.module.scrin.service.ScrinMenuVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.site.mngr.screen.service.SiteScreenService;
import egovframework.wzwg.site.mngr.screen.service.SiteScreenVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmGrpCodeVO;

@Service("SiteScreenService")
public class SiteScreenServiceImpl extends EgovAbstractServiceImpl implements SiteScreenService {
     

	/** 공통코드 **/
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
    
    /** 화면 컨텐츠 **/
    @Resource(name="ScrinCntntsService")
    private ScrinCntntsService scrinCntntsService;
    
    /** 화면 컨텐츠 **/
    @Resource(name="SiteScreenDAO")
    private SiteScreenDAO siteScreenDAO;
     
	@Resource(name="SiteMenuService")
	private SiteMenuService siteMenuService;

	@Override
	public Map<String, Object> selectSiteMenuMngrList(SiteScreenVO siteScreenVO) throws Exception {
		SiteMenuVO siteMenuVO = new SiteMenuVO();
		siteMenuVO.setSiteSeq(siteScreenVO.getSiteSeq());
		Map<String, Object> siteMenuList = siteMenuService.selectSiteMenuMngrList(siteMenuVO);
		return siteMenuList;
	}

	@Override
	public List<Object> selectModuleList(String moduleCode,String siteSeq) throws Exception {
		// TODO Auto-generated method stub
		List<CmmGrpCodeVO> list = codeService.selectCmmGrpCodeList(moduleCode);
		List<Object> moduleList= new ArrayList<Object>();
		for(int i =0;i<list.size();i++){
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("grpVo", list.get(i));
			ScrinMenuVO paramVO = new ScrinMenuVO(); 
			paramVO.setSiteSeq(siteSeq);
			paramVO.setMenuMclCode(list.get(i).getGrpcode()); 
			map.put("subList",scrinCntntsService.selectSampleModuleList(paramVO));
			moduleList.add(map);
		}
		return moduleList;
	}
	
	public List<ScrinMenuVO> selectModuleListType(String grpcode,String siteSeq) throws Exception {
		// TODO Auto-generated method stub
	  
			ScrinMenuVO paramVO = new ScrinMenuVO(); 
			paramVO.setSiteSeq(siteSeq);
			paramVO.setMenuMclCode(grpcode);   
		return scrinCntntsService.selectSampleModuleList(paramVO);
	}
	
	public List<ScrinMenuVO> selectModuleMenuList(String sysmoduleSeq,String siteSeq) throws Exception {
		// TODO Auto-generated method stub
	  
			ScrinMenuVO paramVO = new ScrinMenuVO(); 
			paramVO.setSiteSeq(siteSeq);
			paramVO.setSysmoduleSeq(sysmoduleSeq);   
		return scrinCntntsService.selectSampleModuleMenuList(paramVO);
	}

	 
	public ScrinMenuVO selectFirstNttMenuSeq(ScrinMenuVO paramVO) {
		// TODO Auto-generated method stub
		return scrinCntntsService.selectFirstNttMenuSeq(paramVO);
	}

	@Override
	public void registTemplateBackupInfo(SiteScreenVO siteScreenVO)
			throws Exception {
		// TODO Auto-generated method stub
		siteScreenDAO.registTemplateBackupInfo(siteScreenVO);
	}
	
	
	public List<SiteScreenVO> selectTemplateBackupInfoList(SiteScreenVO paramVO) throws Exception {
		// TODO Auto-generated method stub
	   
		return siteScreenDAO.selectTemplateBackupInfoList(paramVO);
	}
	
	
	public SiteScreenVO selectTemplateBackupInfo(SiteScreenVO paramVO) throws Exception {
		// TODO Auto-generated method stub
	   
		return siteScreenDAO.selectTemplateBackupInfo(paramVO);
	}

	@Override
	public List<SiteMenuVO> selectModuleMenuList(SiteScreenVO siteScreenVO) {
		SiteMenuVO siteMenuVO = new SiteMenuVO();
		siteMenuVO.setSiteSeq(siteScreenVO.getSiteSeq());
		siteMenuVO.setSysmoduleSeq(siteScreenVO.getSysmoduleSeq());
	   
		return siteScreenDAO.selectModuleMenuList(siteMenuVO);
	}
    
	/**
	 * 탭메뉴 연결 게시판 목록
	 * @param siteScreenVO
	 * @return
	 */
	public List<SiteScreenVO> selectTabMenuModuleList(SiteScreenVO siteScreenVO){
		return siteScreenDAO.selectTabMenuModuleList(siteScreenVO);
	}
}

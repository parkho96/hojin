package egovframework.wzwg.module.map.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.wzwg.module.map.service.ModuleMapBassInfoService;
import egovframework.wzwg.module.map.service.ModuleMapVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;

@Service("ModuleMapBassInfoService")
public class ModuleMapBassInfoServiceImpl extends EgovAbstractServiceImpl implements ModuleMapBassInfoService {
    
    @Resource(name="CntntsInfoDAO")
    CntntsInfoDAO cntntsInfoDAO;
    
    @Resource(name="ModuleMapBassInfoDAO")
    ModuleMapBassInfoDAO moduleMapBassInfoDAO;
    
    @Resource(name="ModuleMapDAO")
    ModuleMapDAO moduleMapDAO;

	/**
	 * 지도 기본정보 리스트
	 */
	public List<ModuleMapVO> selectModuleMapList(ModuleMapVO moduleMapVO) {
		return moduleMapBassInfoDAO.selectModuleMapList(moduleMapVO);
	}

	/**
	 * 지도 기본정보 등록
	 */
	public int registModuleMapAjax(ModuleMapVO moduleMapVO) {
		String mapinfoSeq = moduleMapBassInfoDAO.selectModuleMapSeq(); 
		moduleMapVO.setMapinfoSeq(mapinfoSeq);
		if (RequestContextHolder.getRequestAttributes() != null) {
			RequestContextHolder.getRequestAttributes().setAttribute("regist_sysModuleSeq", mapinfoSeq, RequestAttributes.SCOPE_SESSION);			
		}
		
		return moduleMapBassInfoDAO.registModuleMapAjax(moduleMapVO);
	}
	
	public String registModuleMapAjaxInit(ModuleMapVO moduleMapVO) {
		String mapinfoSeq = moduleMapBassInfoDAO.selectModuleMapSeq(); 
		moduleMapVO.setMapinfoSeq(mapinfoSeq);
		if (RequestContextHolder.getRequestAttributes() != null) {		
			RequestContextHolder.getRequestAttributes().setAttribute("regist_sysModuleSeq", mapinfoSeq, RequestAttributes.SCOPE_SESSION);
		}
		moduleMapBassInfoDAO.registModuleMapAjax(moduleMapVO);
		return mapinfoSeq;
	}


    /**
     * 지도 기본정보 등록
     */
    public String registMapinfoBassInfoInit(ModuleMapVO moduleMapVO) {
        
        return registModuleMapAjaxInit(moduleMapVO);
    }

    public int registMapBassInfoInit(ModuleMapVO moduleMapVO) {
        
        return registModuleMapAjax(moduleMapVO);
    }
    /**
     * 지도 기본정보 상세조회
     */
    public ModuleMapVO selectMapBassInfoDetail(ModuleMapVO moduleMapVO) {
        return moduleMapBassInfoDAO.selectMapBassInfoDetail(moduleMapVO);
    }

    /**
     * 지도 기본정보 상세조회
     */
    public ModuleMapVO selectMapinfoBassInfoDetail(ModuleMapVO moduleMapVO) {
        return selectMapBassInfoDetail(moduleMapVO);
    }
	
	/**
	 * 지도 기본정보 수정
	 */
	public int modifyModuleMapAjax(ModuleMapVO moduleMapVO) {
	    
        CntntsInfoVO paramVO = new CntntsInfoVO();
        
        paramVO.setCntntsNm(moduleMapVO.getMapNm());
        paramVO.setCntntsDc(moduleMapVO.getMapNm());
        paramVO.setSitecntntsSeq(moduleMapVO.getSitecntntsSeq());
        paramVO.setLastUpdusrId(moduleMapVO.getUserId());
        
        cntntsInfoDAO.modifyCntntsInfoInit(paramVO);

	    
		return moduleMapBassInfoDAO.modifyModuleMapAjax(moduleMapVO);
	}
    
    public void registMapinfoDataCopy(ModuleMapVO moduleMapVO) throws Exception {
        String mapSeq = moduleMapDAO.selectModuleMapSeq();
        moduleMapVO.setMapSeq(mapSeq);
        moduleMapBassInfoDAO.registMdmapDataCopy(moduleMapVO);
        moduleMapBassInfoDAO.registMdmapImgDataCopy(moduleMapVO);
    }
 
}

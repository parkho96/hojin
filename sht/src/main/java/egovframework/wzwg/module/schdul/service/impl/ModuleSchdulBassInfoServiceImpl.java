package egovframework.wzwg.module.schdul.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.wzwg.module.schdul.service.ModuleSchdulBassInfoService;
import egovframework.wzwg.module.schdul.service.ModuleSchdulBassInfoVO;
import egovframework.wzwg.module.schdul.service.ModuleSchdulCssVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;



@Service("ModuleSchdulBassInfoService")
public class ModuleSchdulBassInfoServiceImpl extends EgovAbstractServiceImpl implements ModuleSchdulBassInfoService {

    @Resource(name="CntntsInfoDAO")
    CntntsInfoDAO cntntsInfoDAO;

	@Resource(name="ModuleSchdulBassInfoDAO")
    protected ModuleSchdulBassInfoDAO schdulBassInfoDAO;
	
	/**
	 * ㅁ 일정  목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectSchdulBassInfoList(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return schdulBassInfoDAO.selectSchdulBassInfoList(paramVO);
	}
	
	/**
	 * ㅁ 일정 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleSchdulBassInfoVO selectSchdulBassInfoDetail(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return schdulBassInfoDAO.selectSchdulBassInfoDetail(paramVO);
	}
	
	/**
     * ㅁ 일정 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySchdulBassInfo(ModuleSchdulBassInfoVO paramVO) throws Exception {
		
		if("A".equals(paramVO.getSchdulSkll())) {
    		paramVO.setDietaryUseAt("N");
    		paramVO.setMinutesUseAt("N");
    	} else if("B".equals(paramVO.getSchdulSkll())) {
    		paramVO.setDietaryUseAt("N");
    		paramVO.setMinutesUseAt("Y");
    	} else if("C".equals(paramVO.getSchdulSkll())) {
    		paramVO.setDietaryUseAt("Y");
    		paramVO.setMinutesUseAt("N");
    	}
		
		if("".equals(StringUtils.defaultString(paramVO.getFileUseAt()))) {
			paramVO.setFileUseAt("N");
		}
		

        CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();
        
        cntntsInfoVO.setCntntsNm(paramVO.getSchdulNm());
        cntntsInfoVO.setCntntsDc(paramVO.getSchdulDc());
        cntntsInfoVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
        cntntsInfoVO.setLastUpdusrId(paramVO.getLastUpdusrId());
        
        cntntsInfoDAO.modifyCntntsInfoInit(cntntsInfoVO);

	    
    	int result = schdulBassInfoDAO.modifySchdulBassInfo(paramVO);
    	
    	return result;
	}
    
    /**
     * ㅁ 일정 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSchdulBassInfo(ModuleSchdulBassInfoVO paramVO) throws Exception {
    	
    	if (RequestContextHolder.getRequestAttributes() != null) {
    		RequestContextHolder.getRequestAttributes().setAttribute("regist_sysModuleSeq", paramVO.getSchdulSeq(), RequestAttributes.SCOPE_SESSION);
    	}
    	
    	//schdulSkll의 파라미터로 인해서 일반, 회의록, 식단이 구분된다. 
    	if("A".equals(paramVO.getSchdulSkll())) {
    		paramVO.setDietaryUseAt("N");
    		paramVO.setMinutesUseAt("N");
    	} else if("B".equals(paramVO.getSchdulSkll())) {
    		paramVO.setDietaryUseAt("N");
    		paramVO.setMinutesUseAt("Y");
    	} else if("C".equals(paramVO.getSchdulSkll())) {
    		paramVO.setDietaryUseAt("Y");
    		paramVO.setMinutesUseAt("N");
    	}
    	
    	if("".equals(StringUtils.defaultString(paramVO.getFileUseAt()))) {
			paramVO.setFileUseAt("N");
		}
    	
    	int result = schdulBassInfoDAO.registSchdulBassInfo(paramVO);
    	
    	return result;
    }
    
    /**
     * ㅁ 일정 기본정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int deleteSchdulBassInfo(ModuleSchdulBassInfoVO paramVO) throws Exception {
    	return schdulBassInfoDAO.deleteSchdulBassInfo(paramVO);
    }
    
    /**
     * ㅁ 일정 아이디 생성
     * @return
     * @throws Exception
     */
    public String selectSchdulNextSeq() throws Exception {
    	return schdulBassInfoDAO.selectSchdulNextSeq();
    }
    
    public List<ModuleSchdulBassInfoVO> selectSchdulMainScrinCntnts(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return schdulBassInfoDAO.selectSchdulMainScrinCntnts(paramVO);
	}
    
    public List<ModuleSchdulBassInfoVO> selectSchdulMainScrinCntntsToMonth(ModuleSchdulBassInfoVO paramVO) throws Exception {
    	return schdulBassInfoDAO.selectSchdulMainScrinCntntsToMonth(paramVO);
    }
    
    public   ModuleSchdulBassInfoVO  selectSchdulScrinCntnts(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return  schdulBassInfoDAO.selectSchdulScrinCntnts(paramVO);
	}
    
    /**
     * ㅁ 일정 초기 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String registSchdulBassInfoInit(ModuleSchdulBassInfoVO paramVO) throws Exception {
        String schdulSeq = schdulBassInfoDAO.selectSchdulNextSeq();
        paramVO.setSchdulSeq(schdulSeq);
        schdulBassInfoDAO.registSchdulBassInfo(paramVO);
        return schdulSeq;
    }

    /**
     * ㅁ 일정 CSS 리스트 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleSchdulCssVO> selectSchdulCssList(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return schdulBassInfoDAO.selectSchdulCssList(paramVO);
	}

    /**
     * ㅁ 일정 CSS 상세 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleSchdulCssVO selectSchdulCssDetail(ModuleSchdulCssVO paramVO) throws Exception {
		return schdulBassInfoDAO.selectSchdulCssDetail(paramVO);
	}

    /**
     * ㅁ 일정 CSS 등록/수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySchdulCss(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return schdulBassInfoDAO.modifySchdulCss(paramVO);
	}

    /**
     * ㅁ 일정 CSS 시퀀스 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectSchdulCssSeq(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return schdulBassInfoDAO.selectSchdulCssSeq(paramVO);
	}
	
	/**
     * ㅁ 일정 모듈연결 - 생성된 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleSchdulBassInfoVO> selectModuleList(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return schdulBassInfoDAO.selectModuleList(paramVO);
	}
	
	/**
     * ㅁ 일정 모듈연결 - 모듈 연결
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registConnModuleList(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return schdulBassInfoDAO.registConnModuleList(paramVO);
	}
	
	/**
     * ㅁ 일정 모듈연결 - 연결된 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleSchdulBassInfoVO> selectConnModuleList(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return schdulBassInfoDAO.selectConnModuleList(paramVO);
	}
	
	/**
     * ㅁ 일정 모듈연결 - 연결 모듈 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteConnModule(ModuleSchdulBassInfoVO paramVO) throws Exception {
		return schdulBassInfoDAO.deleteConnModule(paramVO);
	}
	
	public List<EgovMap> selectCalMonList(ModuleSchdulBassInfoVO paramVO) {
		return schdulBassInfoDAO.selectCalMonList(paramVO);
	}
	
	public List<EgovMap> selectCalList(ModuleSchdulBassInfoVO paramVO) {
		return schdulBassInfoDAO.selectCalList(paramVO);
	}
}

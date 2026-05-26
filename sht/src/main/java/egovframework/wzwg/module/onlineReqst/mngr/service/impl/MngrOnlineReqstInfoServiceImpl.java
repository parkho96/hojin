package egovframework.wzwg.module.onlineReqst.mngr.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstInfoService;
import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;

@Service("MngrOnlineReqstInfoService")
public class MngrOnlineReqstInfoServiceImpl extends EgovAbstractServiceImpl implements MngrOnlineReqstInfoService {
    
    @Resource(name="CntntsInfoDAO")
    CntntsInfoDAO cntntsInfoDAO;
    
	@Resource(name="MngrOnlineReqstInfoDAO")
	MngrOnlineReqstInfoDAO mngrOnlineReqstInfoDAO;
	
	/**
	 * 온라인신청 목록
	 */
	public List<CntntsInfoVO> selectOnlineReqstInfoList(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception{
		return mngrOnlineReqstInfoDAO.selectOnlineReqstInfoList(mngrOnlineReqstInfoVO);
	}		

    /**
     * 온라인신청 기본정보 상세
     */
    public MngrOnlineReqstInfoVO selectOnlineReqstInfoDetail(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception {
        return mngrOnlineReqstInfoDAO.selectOnlineReqstInfoDetail(mngrOnlineReqstInfoVO);
    }   

    /**
     * 온라인신청 기본정보 상세
     */
    public MngrOnlineReqstInfoVO selectReqstBassInfoDetail(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception {
        return selectOnlineReqstInfoDetail(mngrOnlineReqstInfoVO);
    }   
    
	/**
	 * 온라인신청 기본정보 등록
	 * @throws Exception 
	 */
	public int registOnlineReqstInfo(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception {
        String reqstSeq = mngrOnlineReqstInfoDAO.selectNextReqstInfoSeq(mngrOnlineReqstInfoVO);
        mngrOnlineReqstInfoVO.setReqstSeq(reqstSeq);

        if (RequestContextHolder.getRequestAttributes() != null) {
        	RequestContextHolder.getRequestAttributes().setAttribute("regist_sysModuleSeq", reqstSeq, RequestAttributes.SCOPE_SESSION);
        }		
		return mngrOnlineReqstInfoDAO.registOnlineReqstInfo(mngrOnlineReqstInfoVO);
	}	

    /**
     * 온라인신청 기본정보 등록
     * @throws Exception 
     */
    public int registReqstBassInfoInit(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception {
        return registOnlineReqstInfo(mngrOnlineReqstInfoVO);
    }
    
	public String registOnlineReqstInfoReturn(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception {
        String reqstSeq = mngrOnlineReqstInfoDAO.selectNextReqstInfoSeq(mngrOnlineReqstInfoVO);
        mngrOnlineReqstInfoVO.setReqstSeq(reqstSeq);

		 mngrOnlineReqstInfoDAO.registOnlineReqstInfo(mngrOnlineReqstInfoVO);
		 return reqstSeq;
	}	
	
	
	/**
	 * 온라인신청 기본정보 수정
	 */
	public int modifyOnlineReqstInfo(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception {
		
        CntntsInfoVO paramVO = new CntntsInfoVO();
        
        paramVO.setCntntsNm(mngrOnlineReqstInfoVO.getReqstNm());
        paramVO.setCntntsDc(mngrOnlineReqstInfoVO.getReqstDc());
        paramVO.setSitecntntsSeq(mngrOnlineReqstInfoVO.getSitecntntsSeq());
        paramVO.setLastUpdusrId(mngrOnlineReqstInfoVO.getLastUpdusrId());
        
        cntntsInfoDAO.modifyCntntsInfoInit(paramVO);		
		
		return mngrOnlineReqstInfoDAO.modifyOnlineReqstInfo(mngrOnlineReqstInfoVO);
	} 
	
}

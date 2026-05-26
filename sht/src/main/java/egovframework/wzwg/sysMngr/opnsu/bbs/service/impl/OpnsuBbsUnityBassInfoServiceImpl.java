package egovframework.wzwg.sysMngr.opnsu.bbs.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsUnityBassInfoService;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsVO;



@Service("OpnsuBbsUnityBassInfoService")
public class OpnsuBbsUnityBassInfoServiceImpl extends EgovAbstractServiceImpl implements OpnsuBbsUnityBassInfoService {
    
    @Resource(name="CntntsInfoDAO")
    CntntsInfoDAO cntntsInfoDAO;

    @Resource(name="OpnsuBbsCmmnDAO")
    protected OpnsuBbsCmmnDAO bbsCmmnDAO;
    
	@Resource(name="OpnsuBbsUnityBassInfoDAO")
    protected OpnsuBbsUnityBassInfoDAO bbsUnityBassInfoDAO;
	
	
	/**
	 * ㅁ 게시판 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuBbsVO selectBbsBassInfoDetail(OpnsuBbsVO bbsVO) throws Exception {
		return bbsUnityBassInfoDAO.selectBbsBassInfoDetail(bbsVO);
	}
    
    /**
     * ㅁ 게시판 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyBbsBassInfo(OpnsuBbsVO bbsVO) throws Exception {
        
        CntntsInfoVO paramVO = new CntntsInfoVO();
        
        paramVO.setCntntsNm(bbsVO.getBbsNm());
        paramVO.setCntntsDc(bbsVO.getBbsDc());
        paramVO.setSitecntntsSeq(bbsVO.getSitecntntsSeq());
        paramVO.setLastUpdusrId(bbsVO.getLastUpdusrId());
        
        cntntsInfoDAO.modifyCntntsInfoInit(paramVO);
        
        return bbsUnityBassInfoDAO.modifyBbsBassInfo(bbsVO);
    }
    
    /**
     * ㅁ 게시판 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registBbsBassInfo(OpnsuBbsVO bbsVO) throws Exception {
        String bbsSeq = bbsCmmnDAO.selectBbsSeq();
        
        if (bbsSeq == null || bbsSeq.trim().isEmpty()) {
            throw new RuntimeException("게시판 시퀀스 번호를 생성 오류.");
        }
        
        bbsVO.setBbsSeq(bbsSeq);
        
        RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
        
        if(attributes != null) {
        	attributes.setAttribute("regist_sysModuleSeq", bbsSeq, RequestAttributes.SCOPE_SESSION);
        }
        
        return bbsUnityBassInfoDAO.registBbsBassInfo(bbsVO);
    }
    
    /**
     * ㅁ 게시판 초기 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String registBbsBassInfoInit(OpnsuBbsVO bbsVO) throws Exception {
        String bbsSeq = bbsCmmnDAO.selectBbsSeq();
        bbsVO.setBbsSeq(bbsSeq);
        bbsUnityBassInfoDAO.registBbsBassInfo(bbsVO);
        return bbsSeq;
    }
	
	
	
}

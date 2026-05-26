package egovframework.wzwg.module.bbs.cl.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.wzwg.module.bbs.cl.service.ModuleBbsClBassInfoService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.cmmn.service.impl.ModuleBbsCmmnDAO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;



@Service("ModuleBbsClBassInfoService")
public class ModuleBbsClBassInfoServiceImpl extends EgovAbstractServiceImpl implements ModuleBbsClBassInfoService {
    
    @Resource(name="CntntsInfoDAO")
    CntntsInfoDAO cntntsInfoDAO;

    @Resource(name="ModuleBbsCmmnDAO")
    protected ModuleBbsCmmnDAO bbsCmmnDAO;
    
	@Resource(name="ModuleBbsClBassInfoDAO")
    protected ModuleBbsClBassInfoDAO bbsClBassInfoDAO;
	
	
	/**
	 * ㅁ 게시판 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleBbsVO selectBbsBassInfoDetail(ModuleBbsVO moduleBbsVO) throws Exception {
		return bbsClBassInfoDAO.selectBbsBassInfoDetail(moduleBbsVO);
	}
    
    /**
     * ㅁ 게시판 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyBbsBassInfo(ModuleBbsVO moduleBbsVO) throws Exception {
        
        CntntsInfoVO paramVO = new CntntsInfoVO();
        
        paramVO.setCntntsNm(moduleBbsVO.getBbsNm());
        paramVO.setCntntsDc(moduleBbsVO.getBbsDc());
        paramVO.setSitecntntsSeq(moduleBbsVO.getSitecntntsSeq());
        paramVO.setLastUpdusrId(moduleBbsVO.getLastUpdusrId());
        
        cntntsInfoDAO.modifyCntntsInfoInit(paramVO);
        
        return bbsClBassInfoDAO.modifyBbsBassInfo(moduleBbsVO);
    }
    
    /**
     * ㅁ 게시판 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registBbsBassInfo(ModuleBbsVO moduleBbsVO) throws Exception {
        String bbsSeq = bbsCmmnDAO.selectBbsSeq();
        moduleBbsVO.setBbsSeq(bbsSeq);

        RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
        
        if(attributes != null) {
        	attributes.setAttribute("regist_sysModuleSeq", bbsSeq, RequestAttributes.SCOPE_SESSION);
        }        
        
        return bbsClBassInfoDAO.registBbsBassInfo(moduleBbsVO);
    }
    
    /**
     * ㅁ 게시판 초기 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String registBbsBassInfoInit(ModuleBbsVO moduleBbsVO) throws Exception {
        String bbsSeq = bbsCmmnDAO.selectBbsSeq();
        moduleBbsVO.setBbsSeq(bbsSeq);
        bbsClBassInfoDAO.registBbsBassInfo(moduleBbsVO);
        return bbsSeq;
    }
	
	
	
}

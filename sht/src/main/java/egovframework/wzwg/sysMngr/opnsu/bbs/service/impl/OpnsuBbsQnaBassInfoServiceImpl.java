package egovframework.wzwg.sysMngr.opnsu.bbs.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsQnaBassInfoService;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsVO;



@Service("OpnsuBbsQnaBassInfoService")
public class OpnsuBbsQnaBassInfoServiceImpl extends EgovAbstractServiceImpl implements OpnsuBbsQnaBassInfoService {
    
    @Resource(name="CntntsInfoDAO")
    CntntsInfoDAO cntntsInfoDAO;

    @Resource(name="OpnsuBbsCmmnDAO")
    protected OpnsuBbsCmmnDAO bbsCmmnDAO;
	
	@Resource(name="OpnsuBbsQnaBassInfoDAO")
    protected OpnsuBbsQnaBassInfoDAO bbsQnaBassInfoDAO;
	
	
	/**
	 * ㅁ 게시판 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuBbsVO selectBbsBassInfoDetail(OpnsuBbsVO bbsVO) throws Exception {
		return bbsQnaBassInfoDAO.selectBbsBassInfoDetail(bbsVO);
	}
	
	/**
	 * ㅁ 글양식 저장
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsBassInfo(OpnsuBbsVO bbsVO) throws Exception {
        
		return bbsQnaBassInfoDAO.modifyBbsBassInfo(bbsVO);
	}
    
    /**
     * ㅁ 게시판 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registBbsBassInfo(OpnsuBbsVO bbsVO) throws Exception {
        String bbsSeq = bbsCmmnDAO.selectBbsSeq();
        bbsVO.setBbsSeq(bbsSeq);

        return bbsQnaBassInfoDAO.registBbsBassInfo(bbsVO);
    }
	
	
	
}

package egovframework.wzwg.module.onlineReqst.mngr.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

@Repository("MngrOnlineReqstInfoDAO")
public class MngrOnlineReqstInfoDAO extends EgovAbstractMapper{
	
	/**
	 * 온라인신청 목록
	 */
	
	public List<CntntsInfoVO> selectOnlineReqstInfoList(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception{
		return selectList("MngrOnlineReqstInfoDAO_selectOnlineReqstInfoList_S", mngrOnlineReqstInfoVO);
	}	
	
	/**
	 * 온라인신청 기본정보 상세
	 */
	public MngrOnlineReqstInfoVO selectOnlineReqstInfoDetail(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception {
		return (MngrOnlineReqstInfoVO) selectOne("MngrOnlineReqstInfoDAO_selectOnlineReqstInfoDetail_S", mngrOnlineReqstInfoVO);
	}		
	
	/**
	 * 온라인신청 기본정보 SEQ 추출
	 */
	public String selectNextReqstInfoSeq(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception {
		return (String) selectOne("MngrOnlineReqstInfoDAO_selectNextReqstInfoSeq_S", mngrOnlineReqstInfoVO);
	}		
	
	/**
	 * 온라인신청 기본정보 등록
	 */
	public int registOnlineReqstInfo(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception {
		return update("MngrOnlineReqstInfoDAO_registOnlineReqstInfo_I", mngrOnlineReqstInfoVO);
	}	
	
	/**
	 * 온라인신청 기본정보 수정
	 */
	public int modifyOnlineReqstInfo(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception {
		return update("MngrOnlineReqstInfoDAO_modifyOnlineReqstInfo_U", mngrOnlineReqstInfoVO);
	} 

}

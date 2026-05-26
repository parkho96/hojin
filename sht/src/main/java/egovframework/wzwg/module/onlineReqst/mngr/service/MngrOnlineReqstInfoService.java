package egovframework.wzwg.module.onlineReqst.mngr.service;

import java.util.List;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

public interface MngrOnlineReqstInfoService {
	
	/**
	 * 온라인신청 목록
	 */
	public List<CntntsInfoVO> selectOnlineReqstInfoList(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception;
	
	/**
	 * 온라인신청 기본정보 상세
	 */
	public MngrOnlineReqstInfoVO selectOnlineReqstInfoDetail(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception;

    /**
     * 온라인신청 기본정보 상세
     */
    public MngrOnlineReqstInfoVO selectReqstBassInfoDetail(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception;
	
	/**
	 * 온라인신청 기본정보 등록
	 */
	public int registOnlineReqstInfo(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception;	

    /**
     * 온라인신청 기본정보 등록
     * @throws Exception 
     */
    public int registReqstBassInfoInit(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception;
	
	/**
	 * 온라인신청 기본정보 수정
	 */
	public int modifyOnlineReqstInfo(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception;
	
	public String registOnlineReqstInfoReturn(MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO) throws Exception;
	
}

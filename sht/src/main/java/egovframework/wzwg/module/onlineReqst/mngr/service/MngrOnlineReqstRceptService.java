package egovframework.wzwg.module.onlineReqst.mngr.service;

import java.util.Map;

public interface MngrOnlineReqstRceptService {
    
	/*
	 * 온라인신청접수 목록
	 */
	public Map<String, Object> selectOnlineReqstRceptList(MngrOnlineReqstRceptVO mngrOnlineReqstRceptVO) throws Exception;
	
	/*
	 * 온라인신청접수 삭제
	 */
	public Integer deleteOnlineReqstRcept(MngrOnlineReqstRceptVO mngrOnlineReqstRceptVO) throws Exception;
	
	/*
	 * 온라인신청접수 삭제 (선택 삭제)
	 */
	public Integer deleteCheckOnlineReqstRcept(MngrOnlineReqstRceptVO mngrOnlineReqstRceptVO) throws Exception;	
	
	/*
	 * 온라인신청접수 수정
	 */
	public Integer modifyOnlineReqstRcept(MngrOnlineReqstRceptVO mngrOnlineReqstRceptVO) throws Exception;	
}

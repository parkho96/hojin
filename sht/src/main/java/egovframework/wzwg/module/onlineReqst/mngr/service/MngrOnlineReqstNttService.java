package egovframework.wzwg.module.onlineReqst.mngr.service;

import java.util.List;
import java.util.Map;

public interface MngrOnlineReqstNttService {
    
	/*
	 * 온라인신청 게시물 목록
	 */
	public Map<String, Object> selectOnlineReqstNttList(MngrOnlineReqstNttVO mngrOnlineReqstInfoVO) throws Exception;
	
	/*
	 * 온라인신청 게시물 SEQ 추출
	 */
	public String selectNextReqstNttSeq(MngrOnlineReqstNttVO mngrOnlineReqstInfoVO) throws Exception;
	
	/*
	 * 온라인신청 게시물 등록
	 */
	public Integer resistOnlineReqstNtt(MngrOnlineReqstNttVO mngrOnlineReqstInfoVO) throws Exception;	
	
	/*
	 * 온라인신청 게시물 삭제
	 */
	public Integer deleteOnlineReqstNtt(MngrOnlineReqstNttVO mngrOnlineReqstInfoVO) throws Exception;
	
	/*
	 * 온라인신청 게시물 삭제 (선택 삭제)
	 */
	public Integer deleteCheckOnlineReqstNtt(MngrOnlineReqstNttVO mngrOnlineReqstInfoVO) throws Exception;
	
	/*
	 * 온라인신청 게시물 상세
	 */
	public MngrOnlineReqstNttVO selectOnlineReqstNttDetail(MngrOnlineReqstNttVO mngrOnlineReqstInfoVO) throws Exception;

	/*
	 * 온라인신청 게시물 수정
	 */
	public Integer modifyOnlineReqstNtt(MngrOnlineReqstNttVO mngrOnlineReqstInfoVO) throws Exception;
	
	/*
	 * 온라인신청 게시물 대상자 목록
	 */
	public List<MngrOnlineReqstNttVO> selectOnlineReqstNttTrgterList(MngrOnlineReqstNttVO mngrOnlineReqstInfoVO) throws Exception;	
	
	/*
	 * 온라인신청 게시물 대상자 정보 등록/수정
	 */
	public Integer registOnlineReqstNttTrgter(MngrOnlineReqstNttVO mngrOnlineReqstInfoVO) throws Exception;	

}

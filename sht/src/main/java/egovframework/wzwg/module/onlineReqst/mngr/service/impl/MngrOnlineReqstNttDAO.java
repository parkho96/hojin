package egovframework.wzwg.module.onlineReqst.mngr.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstNttVO;

@Repository(value="MngrOnlineReqstNttDAO")

public class MngrOnlineReqstNttDAO extends EgovAbstractMapper {

	/*
	 * 온라인신청 게시물 목록
	 */
	public List<MngrOnlineReqstNttVO> selectOnlineReqstNttList(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception{
		return selectList("MngrOnlineReqstNttDAO_selectOnlineReqstNttList_S", mngrOnlineReqstNttVO);
	}
	
	/*
	 * 온라인신청 게시물 목록 건수
	 */
	public int selectOnlineReqstNttListCnt(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception{
		return (Integer) selectOne("MngrOnlineReqstNttDAO_selectOnlineReqstNttListCnt_S", mngrOnlineReqstNttVO);
	}
	
	/*
	 * 온라인신청 게시물 SEQ 추출
	 */
	public String selectNextReqstNttSeq(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		return (String) selectOne("MngrOnlineReqstNttDAO_selectNextReqstNttSeq_S", mngrOnlineReqstNttVO);
	}	
	
	/*
	 * 온라인신청 게시물 등록
	 */
	public Integer resistOnlineReqstNtt(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		int result = 0;
		result = update("MngrOnlineReqstNttDAO_resistOnlineReqstNtt_I", mngrOnlineReqstNttVO);	
		return result;		
	}	
	
	/*
	 * 온라인신청 게시물 삭제
	 */
	public Integer deleteOnlineReqstNtt(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		return delete("MngrOnlineReqstNttDAO_deleteOnlineReqstNtt_D", mngrOnlineReqstNttVO);
	}	
  
	/*
	 * 온라인신청 게시물 상세
	 */
	public MngrOnlineReqstNttVO selectOnlineReqstNttDetail(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		return (MngrOnlineReqstNttVO) selectOne("MngrOnlineReqstNttDAO_selectOnlineReqstNttDetail_S", mngrOnlineReqstNttVO);
	}
	
	/*
	 * 온라인신청 게시물 수정
	 */
	public Integer modifyOnlineReqstNtt(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		int result = 0;
		result = update("MngrOnlineReqstNttDAO_modifyOnlineReqstNtt_U", mngrOnlineReqstNttVO);	
		return result;		
	}	

	/*
	 * 온라인신청 게시물 대상자 목록
	 */
	public List<MngrOnlineReqstNttVO> selectOnlineReqstNttTrgterList(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception{
		return selectList("MngrOnlineReqstNttDAO_selectOnlineReqstNttTrgterList_S", mngrOnlineReqstNttVO);
	}	
	
	/*
	 * 온라인신청 게시물 대상자 건수
	 */
	public int selectOnlineReqstNttTrgterCnt(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception{
		return (Integer) selectOne("MngrOnlineReqstNttDAO_selectOnlineReqstNttTrgterCnt_S", mngrOnlineReqstNttVO);
	}	
	
	/*
	 * 온라인신청 게시물 대상자 등록/수정
	 */
	public Integer registOnlineReqstNttTrgter(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		int result = 0;
		result = update("MngrOnlineReqstNttDAO_registOnlineReqstNttTrgter_I", mngrOnlineReqstNttVO);	
		return result;		
	}		

	/*
	 * 온라인신청 게시물 대상자  삭제
	 */
	public Integer deleteOnlineReqstNttTrgter(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		return delete("MngrOnlineReqstNttDAO_deleteOnlineReqstNttTrgter_D", mngrOnlineReqstNttVO);
	}		

}

package egovframework.wzwg.module.onlineReqst.mngr.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstRceptVO;

@Repository(value="MngrOnlineReqstRceptDAO")

public class MngrOnlineReqstRceptDAO extends EgovAbstractMapper {

	/*
	 * 온라인신청접수 목록
	 */
	public List<MngrOnlineReqstRceptVO> selectOnlineReqstRceptList(MngrOnlineReqstRceptVO mngrOnlineReqstRceptVO) throws Exception{
		return selectList("MngrOnlineReqstRceptDAO_selectOnlineReqstRceptList_S", mngrOnlineReqstRceptVO);
	}
	
	/*
	 * 온라인신청접수 목록 총 건수
	 */
	public int selectOnlineReqstRceptListTotCnt(MngrOnlineReqstRceptVO mngrOnlineReqstRceptVO) throws Exception{
		return (Integer) selectOne("MngrOnlineReqstRceptDAO_selectOnlineReqstRceptListTotCnt_S", mngrOnlineReqstRceptVO);
	}	

	/*
	 * 온라인신청접수 삭제
	 */
	public Integer deleteOnlineReqstRcept(MngrOnlineReqstRceptVO mngrOnlineReqstRceptVO) throws Exception {
		return delete("MngrOnlineReqstRceptDAO_deleteOnlineReqstRcept_D", mngrOnlineReqstRceptVO);
	}	
	
	/*
	 * 온라인신청접수 수정
	 */
	public Integer modifyOnlineReqstRcept(MngrOnlineReqstRceptVO mngrOnlineReqstRceptVO) throws Exception {
		int result = 0;
		result = update("MngrOnlineReqstRceptDAO_modifyOnlineReqstRcept_U", mngrOnlineReqstRceptVO);	
		return result;		
	}	
	
}

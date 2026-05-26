package egovframework.wzwg.module.onlineReqst.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstNttVO;

@Repository(value="ModuleOnlineReqstNttDAO")

public class ModuleOnlineReqstNttDAO extends EgovAbstractMapper {

	/*
	 * 온라인신청 게시물 목록
	 */
	public List<ModuleOnlineReqstNttVO> selectOnlineReqstNttList(ModuleOnlineReqstNttVO moduleOnlineReqstNttVO) throws Exception{
		return selectList("ModuleOnlineReqstNttDAO_selectOnlineReqstNttList_S", moduleOnlineReqstNttVO);
	}

	/*
	 * 온라인신청 게시물 목록 건수
	 */
	public int selectOnlineReqstNttListCnt(ModuleOnlineReqstNttVO moduleOnlineReqstNttVO) throws Exception{
		return (Integer) selectOne("ModuleOnlineReqstNttDAO_selectOnlineReqstNttListCnt_S", moduleOnlineReqstNttVO);
	}
  
	/*
	 * 온라인신청 게시물 상세
	 */
	public ModuleOnlineReqstNttVO selectOnlineReqstNttDetail(ModuleOnlineReqstNttVO moduleOnlineReqstNttVO) throws Exception {
		return (ModuleOnlineReqstNttVO) selectOne("ModuleOnlineReqstNttDAO_selectOnlineReqstNttDetail_S", moduleOnlineReqstNttVO);
	}
	
	/*
	 * 온라인신청 게시물 대상자 건수
	 */
	public int selectOnlineReqstNttTrgterCnt(ModuleOnlineReqstNttVO moduleOnlineReqstNttVO) throws Exception{
		return (Integer) selectOne("ModuleOnlineReqstNttDAO_selectOnlineReqstNttTrgterCnt_S", moduleOnlineReqstNttVO);
	}	
		
}

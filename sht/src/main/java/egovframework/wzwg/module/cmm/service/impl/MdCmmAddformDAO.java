package egovframework.wzwg.module.cmm.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.cmm.service.MdCmmAddformVO;

@Repository("MdCmmAddformDAO")
public class MdCmmAddformDAO extends EgovAbstractMapper{

	public MdCmmAddformVO selectAddformData(MdCmmAddformVO addformVO) throws Exception{
		return (MdCmmAddformVO) selectOne("CmmAddformDAO_selectAddformData", addformVO);
	}
	
	public int registAddformData(MdCmmAddformVO addformVO) throws Exception{
		return update("CmmAddformDAO_registAddformData", addformVO);
	}
	
	public int modifyAddformData(MdCmmAddformVO addformVO) throws Exception{
		return update("CmmAddformDAO_updateAddformData", addformVO);
	}
}

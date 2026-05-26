package egovframework.wzwg.module.cmm.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.cmm.service.MdCmmAddformService;
import egovframework.wzwg.module.cmm.service.MdCmmAddformVO;

@Service("MdCmmAddformService")
public class MdCmmAddformServiceImpl extends EgovAbstractServiceImpl implements MdCmmAddformService{
	@Resource(name="MdCmmAddformDAO")
	MdCmmAddformDAO addformDAO;
	
	@Override
	public MdCmmAddformVO selectAddformData(MdCmmAddformVO addformVO) throws Exception {
		return addformDAO.selectAddformData(addformVO);
	}
	
	@Override
	public int registAddformData(MdCmmAddformVO addformVO) throws Exception {
		MdCmmAddformVO dataVO = addformDAO.selectAddformData(addformVO);
		int result = -1;
		if(dataVO == null || String.valueOf(dataVO.getFormCn()).equals("")){
			result = addformDAO.update("CmmAddformDAO.registAddformData", addformVO);
		}else{
			result = addformDAO.update("CmmAddformDAO.updateAddformData", addformVO);
		}
		return result;
	}
}

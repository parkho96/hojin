package egovframework.wzwg.sysMngr.stat.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.stat.service.SysMngrStatService;
import egovframework.wzwg.sysMngr.stat.service.SysMngrStatVO;

@Service("SysMngrStatService")
public class SysMngrStatServiceImpl extends EgovAbstractServiceImpl implements SysMngrStatService {
    
    @Resource(name="SysMngrStatDAO")
    private SysMngrStatDAO sysMngrStatDAO;
     
	public List<SysMngrStatVO> selectVisitStatList(SysMngrStatVO paramVO) {
		return sysMngrStatDAO.selectVisitStatList(paramVO);
	}  
	
	public List<SysMngrStatVO> selectUsrStatList(SysMngrStatVO paramVO) {
		return sysMngrStatDAO.selectUsrStatList(paramVO);
	}  
	
	public List<SysMngrStatVO> selectBbsStatList(SysMngrStatVO paramVO) {
		return sysMngrStatDAO.selectBbsStatList(paramVO);
	}  
	
	public List<SysMngrStatVO> selectVisitStatListExcel(SysMngrStatVO paramVO) {
		return sysMngrStatDAO.selectVisitStatListExcel(paramVO);
	}  
	
	public List<SysMngrStatVO> selectUsrStatListExcel(SysMngrStatVO paramVO) {
		return sysMngrStatDAO.selectUsrStatListExcel(paramVO);
	}  
	
	public List<SysMngrStatVO> selectBbsStatListExcel(SysMngrStatVO paramVO) {
		return sysMngrStatDAO.selectBbsStatListExcel(paramVO);
	}  
}

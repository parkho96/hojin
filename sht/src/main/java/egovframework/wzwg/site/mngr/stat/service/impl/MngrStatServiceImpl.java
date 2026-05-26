package egovframework.wzwg.site.mngr.stat.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.stat.service.MngrStatService;
import egovframework.wzwg.site.mngr.stat.service.MngrStatVO;

@Service("MngrStatService")
public class MngrStatServiceImpl extends EgovAbstractServiceImpl implements MngrStatService {
	 
    @Resource(name="MngrStatDAO")
    private MngrStatDAO mngrStatDAO;
     
	public List<MngrStatVO> selectVisitStatList(MngrStatVO paramVO) {
		return mngrStatDAO.selectVisitStatList(paramVO);
	}  
	
	public List<MngrStatVO> selectUsrStatList(MngrStatVO paramVO) {
		return mngrStatDAO.selectUsrStatList(paramVO);
	}  
	
	public List<MngrStatVO> selectBbsStatList(MngrStatVO paramVO) {
		return mngrStatDAO.selectBbsStatList(paramVO);
	}  
	
	public List<MngrStatVO> selectCmntStatList(MngrStatVO paramVO) {
		return mngrStatDAO.selectCmntStatList(paramVO);
	} 
	
	public List<MngrStatVO> selectMenuStatList(MngrStatVO paramVO) {
		return mngrStatDAO.selectMenuStatList(paramVO);
	} 
	
	public List<MngrStatVO> selectVisitStatListExcel(MngrStatVO paramVO) {
		return mngrStatDAO.selectVisitStatListExcel(paramVO);
	}  
	
	public List<MngrStatVO> selectUsrStatListExcel(MngrStatVO paramVO) {
		return mngrStatDAO.selectUsrStatListExcel(paramVO);
	}  
	
	public List<MngrStatVO> selectBbsStatListExcel(MngrStatVO paramVO) {
		return mngrStatDAO.selectBbsStatListExcel(paramVO);
	}  
	
	public List<MngrStatVO> selectCmntStatListExcel(MngrStatVO paramVO) {
		return mngrStatDAO.selectCmntStatListExcel(paramVO);
	} 
	
	public List<MngrStatVO> selectMenuStatListExcel(MngrStatVO paramVO) {
		return mngrStatDAO.selectMenuStatListExcel(paramVO);
	} 
	
	
}

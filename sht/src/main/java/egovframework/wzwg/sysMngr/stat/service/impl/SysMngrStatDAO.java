package egovframework.wzwg.sysMngr.stat.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.stat.service.SysMngrStatVO;

@Repository("SysMngrStatDAO")
public class SysMngrStatDAO extends EgovAbstractMapper {
 
	
	public List<SysMngrStatVO> selectVisitStatList(SysMngrStatVO paramVO) {
		return selectList("SysMngrStatDAO_selectVisitStatList", paramVO);
	}  
	
	public List<SysMngrStatVO> selectUsrStatList(SysMngrStatVO paramVO) {
		return selectList("SysMngrStatDAO_selectUsrStatList", paramVO);
	}  
	
	public List<SysMngrStatVO> selectBbsStatList(SysMngrStatVO paramVO) {
		return selectList("SysMngrStatDAO_selectBbsStatList", paramVO);
	}  
	
	public List<SysMngrStatVO> selectVisitStatListExcel(SysMngrStatVO paramVO) {
		return selectList("SysMngrStatDAO_selectVisitStatListExcel", paramVO);
	}  
	
	public List<SysMngrStatVO> selectUsrStatListExcel(SysMngrStatVO paramVO) {
		return selectList("SysMngrStatDAO_selectUsrStatListExcel", paramVO);
	}  
	
	public List<SysMngrStatVO> selectBbsStatListExcel(SysMngrStatVO paramVO) {
		return selectList("SysMngrStatDAO_selectBbsStatListExcel", paramVO);
	}  
	
}

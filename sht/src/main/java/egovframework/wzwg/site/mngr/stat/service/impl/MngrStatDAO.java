package egovframework.wzwg.site.mngr.stat.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.stat.service.MngrStatVO;

@Repository("MngrStatDAO")
public class MngrStatDAO extends EgovAbstractMapper {

	public List<MngrStatVO> selectVisitStatList(MngrStatVO paramVO) {
		return selectList("MngrStatDAO_selectVisitStatList", paramVO);
	}  
	
	public List<MngrStatVO> selectUsrStatList(MngrStatVO paramVO) {
		return selectList("MngrStatDAO_selectUsrStatList", paramVO);
	}  
	
	public List<MngrStatVO> selectBbsStatList(MngrStatVO paramVO) {
		return selectList("MngrStatDAO_selectBbsStatList", paramVO);
	} 
	
	public List<MngrStatVO> selectCmntStatList(MngrStatVO paramVO) {
		return selectList("MngrStatDAO_selectCmntStatList", paramVO);
	} 
	
	public List<MngrStatVO> selectMenuStatList(MngrStatVO paramVO) {
		return selectList("MngrStatDAO_selectMenuStatList", paramVO);
	} 
	
	public List<MngrStatVO> selectVisitStatListExcel(MngrStatVO paramVO) {
		return selectList("MngrStatDAO_selectVisitStatListExcel", paramVO);
	}  
	
	public List<MngrStatVO> selectUsrStatListExcel(MngrStatVO paramVO) {
		return selectList("MngrStatDAO_selectUsrStatListExcel", paramVO);
	}  
	
	public List<MngrStatVO> selectBbsStatListExcel(MngrStatVO paramVO) {
		return selectList("MngrStatDAO_selectBbsStatListExcel", paramVO);
	} 
	
	public List<MngrStatVO> selectCmntStatListExcel(MngrStatVO paramVO) {
		return selectList("MngrStatDAO_selectCmntStatListExcel", paramVO);
	} 
	
	public List<MngrStatVO> selectMenuStatListExcel(MngrStatVO paramVO) {
		return selectList("MngrStatDAO_selectMenuStatListExcel", paramVO);
	} 
}

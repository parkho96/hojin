package egovframework.wzwg.sysMngr.stat.service;

import java.util.List;

public interface SysMngrStatService {
	public List<SysMngrStatVO> selectVisitStatList(SysMngrStatVO paramVO);
	
	public List<SysMngrStatVO> selectUsrStatList(SysMngrStatVO paramVO) ;
	
	public List<SysMngrStatVO> selectBbsStatList(SysMngrStatVO paramVO);
	
	public List<SysMngrStatVO> selectVisitStatListExcel(SysMngrStatVO paramVO);
	
	public List<SysMngrStatVO> selectUsrStatListExcel(SysMngrStatVO paramVO) ;
	
	public List<SysMngrStatVO> selectBbsStatListExcel(SysMngrStatVO paramVO);
		

}

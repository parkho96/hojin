package egovframework.wzwg.site.mngr.stat.service;

import java.util.List;

public interface MngrStatService {
	public List<MngrStatVO> selectVisitStatList(MngrStatVO paramVO);
	
	public List<MngrStatVO> selectUsrStatList(MngrStatVO paramVO) ;
	
	public List<MngrStatVO> selectBbsStatList(MngrStatVO paramVO);
	
	public List<MngrStatVO> selectCmntStatList(MngrStatVO paramVO);
	
	public List<MngrStatVO> selectMenuStatList(MngrStatVO paramVO);

	public List<MngrStatVO> selectVisitStatListExcel(MngrStatVO paramVO);
	
	public List<MngrStatVO> selectUsrStatListExcel(MngrStatVO paramVO) ;
	
	public List<MngrStatVO> selectBbsStatListExcel(MngrStatVO paramVO);
	
	public List<MngrStatVO> selectCmntStatListExcel(MngrStatVO paramVO);
	
	public List<MngrStatVO> selectMenuStatListExcel(MngrStatVO paramVO);
}

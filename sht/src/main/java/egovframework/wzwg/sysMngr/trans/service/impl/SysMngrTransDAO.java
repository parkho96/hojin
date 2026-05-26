package egovframework.wzwg.sysMngr.trans.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.trans.service.SysMngrTransVO;


@Repository("SysMngrTransDAO")
public class SysMngrTransDAO extends EgovAbstractMapper {
	 
 
	public String selectUnityBoardSeq(SysMngrTransVO sysMngrTransVO) throws Exception {
		return (String) selectOne("SysMngrTransDAO_selectUnityBoardSeq", sysMngrTransVO);
	}
	
	public String selectSitecntntsSeq(SysMngrTransVO sysMngrTransVO) throws Exception {
		return (String) selectOne("SysMngrTransDAO_selectSitecntntsSeq", sysMngrTransVO);
	}
	
	public String selectTransBoardId(SysMngrTransVO sysMngrTransVO) throws Exception {
		return (String) selectOne("SysMngrTransDAO_selectTransBoardId", sysMngrTransVO);
	}
	
	public String selectTransMdnttAtchFileId(SysMngrTransVO sysMngrTransVO) throws Exception {
		return (String) selectOne("SysMngrTransDAO_selectTransMdnttAtchFileId", sysMngrTransVO);
	}
	
	public String selectTranstAtchFileSn(SysMngrTransVO sysMngrTransVO) throws Exception {
		return (String) selectOne("SysMngrTransDAO_selectTranstAtchFileSn", sysMngrTransVO);
	}
	
	public String getNextAtchFileId(SysMngrTransVO sysMngrTransVO) throws Exception {
		return (String) selectOne("SysMngrTransDAO_getNextAtchFileId", sysMngrTransVO);
	}
	
	public int registUnityMdntt(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_registUnityMdntt", sysMngrTransVO);
	} 
 
	public int registUnityMdnttAdiinfo(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_registUnityMdnttAdiinfo", sysMngrTransVO);
	} 
	
	public int updateUnityMdntt(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_updateUnityMdntt", sysMngrTransVO);
	} 
 
	public int updateUnityMdnttAdiinfo(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_updateUnityMdnttAdiinfo", sysMngrTransVO);
	} 
	
	public int updateUnitySiteCntnts(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_updateUnitySiteCntnts", sysMngrTransVO);
	} 
	
	public int registUnitySiteCntnts(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_registUnitySiteCntnts", sysMngrTransVO);
	} 
	public int registUnityBoard(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_registUnityBoard", sysMngrTransVO);
	} 
	
	public int updateUnityBoard(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_updateUnityBoard", sysMngrTransVO);
	} 
 
	public int updateAtchFileIdMdntt(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_updateAtchFileIdMdntt", sysMngrTransVO);
	} 
	public int insertFileDetail(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_insertFileDetail", sysMngrTransVO);
	} 
	public int insertFileMaster(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_insertFileMaster", sysMngrTransVO);
	} 
	
	public String selectTransMappingBbsSeq(SysMngrTransVO sysMngrTransVO) throws Exception {
		return (String) selectOne("SysMngrTransDAO_selectTransMappingBbsSeq", sysMngrTransVO);
	}
	
	public String selectTransMappingSitecntntsSeq(SysMngrTransVO sysMngrTransVO) throws Exception {
		return (String) selectOne("SysMngrTransDAO_selectTransMappingSitecntntsSeq", sysMngrTransVO);
	}
	
	public int insertTransMapping(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_insertTransMapping", sysMngrTransVO);
	} 
	 
	public String selectTransMappingNttSeq(SysMngrTransVO sysMngrTransVO) throws Exception {
		return (String) selectOne("SysMngrTransDAO_selectTransMappingNttSeq", sysMngrTransVO);
	}
	
	public int insertNttTransMapping(SysMngrTransVO sysMngrTransVO) throws Exception {
		return update("SysMngrTransDAO_insertNttTransMapping", sysMngrTransVO);
	} 
	 
}

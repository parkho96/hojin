package egovframework.com.cmm.interceptor.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.interceptor.service.VisitrMenuStatsVO;


@Repository("VisitrMenuStatsDAO")
public class VisitrMenuStatsDAO extends EgovAbstractMapper{

	public void registSiteMenuConect(VisitrMenuStatsVO visitrMenuStatsVO) throws Exception{
		
		int mergeAt = 0;
		
		mergeAt = ((Integer)selectOne("visitrMenuStatsDAO_selectSiteMenuConectMergeAt_S", visitrMenuStatsVO)).intValue();
		
		if(mergeAt == 0){
			insert("visitrMenuStatsDAO_registSiteMenuConect",visitrMenuStatsVO);
		}else{
			update("visitrMenuStatsDAO_updateSiteMenuConect",visitrMenuStatsVO);
		}
		
	}

	/*
	public void summarySiteMenuConect() throws Exception{
		insert("visitrMenuStatsDAO_summarySiteMenuConect","");
	}

	public void summarySiteDeviceConect() throws Exception{
		insert("visitrMenuStatsDAO_summarySiteDeviceConect","");
	}
	
	public List<VisitrMenuStatsVO> selectVisitrMenuStats(VisitrMenuStatsVO visitrMenuStatsVO) throws Exception{
		return selectList("visitrMenuStatsDAO_selectVisitrMenuStats",visitrMenuStatsVO);
	}
	
	public List<VisitrMenuStatsVO> selectVisitrMenuStatsExcel(VisitrMenuStatsVO visitrMenuStatsVO) throws Exception{
		return selectList("visitrMenuStatsDAO_selectVisitrMenuStatsExcel",visitrMenuStatsVO);
	}
 
	 */
}

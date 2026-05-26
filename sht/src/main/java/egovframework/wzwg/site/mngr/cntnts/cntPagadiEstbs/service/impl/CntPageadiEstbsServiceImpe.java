package egovframework.wzwg.site.mngr.cntnts.cntPagadiEstbs.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.cntnts.cntPagadiEstbs.service.CntPageadiEstbsService;
import egovframework.wzwg.site.mngr.cntnts.cntPagadiEstbs.service.CntPageadiEstbsVO;

@Service("CntPageadiEstbsService")
public class CntPageadiEstbsServiceImpe implements CntPageadiEstbsService {

	@Resource(name="CntPageadiEstbsDAO")
    private CntPageadiEstbsDAO cntPageadiEstbsDAO;
	
	@Override
	public String selectCntPageadiEstbsSeq() throws Exception{
		return cntPageadiEstbsDAO.selectCntPageadiEstbsSeq();
	}

	@Override
	public int registCntPageadiEstbs(CntPageadiEstbsVO paramVO) throws Exception{
		return cntPageadiEstbsDAO.registCntPageadiEstbs(paramVO);
	}

	@Override
	public CntPageadiEstbsVO selectCntPageadiEstbs(CntPageadiEstbsVO paramVO) throws Exception{
		return cntPageadiEstbsDAO.selectCntPageadiEstbs(paramVO);
	}
	
	@Override
	public int registOclhg(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.registOclhg(paramVO);
	}
	
	@Override
	public String selectOclhgSeq() throws Exception {
		return cntPageadiEstbsDAO.selectOclhgSeq();
	}

	@Override
	public int modifyOclhg(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.modifyOclhg(paramVO);
	}
	
	@Override
	public List<CntPageadiEstbsVO> selectOclhgList(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.selectOclhgList(paramVO);
	}
	
	@Override
	public int deleteOclhg(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.deleteOclhg(paramVO);
	}
	
	@Override
	public int oclhgOrdrChange(CntPageadiEstbsVO paramVO, String ordrSe) throws Exception {
		
		CntPageadiEstbsVO thisVO = new CntPageadiEstbsVO();
		CntPageadiEstbsVO targetVO = new CntPageadiEstbsVO();
		
		if(ordrSe.equals("up")) {
			targetVO = cntPageadiEstbsDAO.selectoclhgOrdrUp(paramVO);
		}else if(ordrSe.equals("down")){
			targetVO = cntPageadiEstbsDAO.selectoclhgOrdrDown(paramVO);
		}else {
			return -1;
		}
		
		if(targetVO == null) {
			return -1;
		}
		
		thisVO.setPagoclhgSeq(paramVO.getPagoclhgSeq());
		thisVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		thisVO.setSortOrdr(targetVO.getSortOrdr());
		thisVO.setPagadiestbsSeq(paramVO.getPagadiestbsSeq());
		
		targetVO.setLastUpdusrId(paramVO.getLastUpdusrId());
		targetVO.setSortOrdr(paramVO.getSortOrdr());
		targetVO.setPagadiestbsSeq(paramVO.getPagadiestbsSeq());
		
		int result = 0;
		
		result += cntPageadiEstbsDAO.oclhgOrdrChange(thisVO);
		result += cntPageadiEstbsDAO.oclhgOrdrChange(targetVO);
		
		return result;
	}

	
	@Override
	public int registPagecpyrht(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.registPagecpyrht(paramVO);
	}
	
	@Override
	public CntPageadiEstbsVO selectPagecpyrht(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.selectPagecpyrht(paramVO);
	}

	

	@Override
	public int registEvlEstbs(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.registEvlEstbs(paramVO);
	}

	@Override
	public CntPageadiEstbsVO selectEvlEstbs(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.selectEvlEstbs(paramVO);
	}

	@Override
	public int registEvlScore(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.registEvlScore(paramVO);
	}
	
	@Override
	public CntPageadiEstbsVO selectEvlScoreSummary(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.selectEvlScoreSummary(paramVO);
	}
	
	@Override
	public List<CntPageadiEstbsVO> selectEvlScoreList(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.selectEvlScoreList(paramVO);
	}
	
	@Override
	public CntPageadiEstbsVO selectCntntsNm(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.selectCntntsNm(paramVO);
	}
	
	@Override
	public int registSkinEstbs(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.registSkinEstbs(paramVO);
	}

	@Override
	public CntPageadiEstbsVO selectSkinEstbs(CntPageadiEstbsVO paramVO) throws Exception {
		return cntPageadiEstbsDAO.selectSkinEstbs(paramVO);
	}


}

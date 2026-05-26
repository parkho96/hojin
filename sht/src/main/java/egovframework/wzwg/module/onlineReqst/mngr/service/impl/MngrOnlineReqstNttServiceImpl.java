package egovframework.wzwg.module.onlineReqst.mngr.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstNttService;
import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstNttVO;

@Service(value="MngrOnlineReqstNttService")
public class MngrOnlineReqstNttServiceImpl extends EgovAbstractServiceImpl implements MngrOnlineReqstNttService {
	
	@Resource(name="MngrOnlineReqstNttDAO")
	public MngrOnlineReqstNttDAO mngrOnlineReqstNttDAO;
	
	/*
	 * 온라인신청 게시물 목록
	 */
	public Map<String, Object> selectOnlineReqstNttList(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception{
		
		List<MngrOnlineReqstNttVO> resultList = mngrOnlineReqstNttDAO.selectOnlineReqstNttList(mngrOnlineReqstNttVO);
		
		int totCnt = 0;
		
		totCnt = mngrOnlineReqstNttDAO.selectOnlineReqstNttListCnt(mngrOnlineReqstNttVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", resultList);
		map.put("totCnt", Integer.toString(totCnt));
		
		return map;
	}
	
	/*
	 * 온라인신청 게시물 SEQ 추출
	 */
	public String selectNextReqstNttSeq(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		return mngrOnlineReqstNttDAO.selectNextReqstNttSeq(mngrOnlineReqstNttVO);
	}	
	
	/*
	 * 온라인신청 게시물 등록
	 */
	public Integer resistOnlineReqstNtt(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		int result = 0;
		result = mngrOnlineReqstNttDAO.resistOnlineReqstNtt(mngrOnlineReqstNttVO);	
		
		if(result > 0) {
			result = registOnlineReqstNttTrgter(mngrOnlineReqstNttVO);
		}
		return result;		
	}	
	
	/*
	 * 온라인신청 게시물 삭제
	 */
	public Integer deleteOnlineReqstNtt(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		int result = 0;
		result = mngrOnlineReqstNttDAO.deleteOnlineReqstNtt(mngrOnlineReqstNttVO);	
		return result;	
	}
	
	/*
	 * 온라인신청 게시물 삭제 (선택 삭제)
	 */
	public Integer deleteCheckOnlineReqstNtt(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		
		String reqstnttSeqChkStr = StringUtils.defaultString(mngrOnlineReqstNttVO.getReqstnttSeqChkStr());
		
		if(!"".equals(reqstnttSeqChkStr)){
			reqstnttSeqChkStr = mngrOnlineReqstNttVO.getReqstnttSeqChkStr().substring(0, mngrOnlineReqstNttVO.getReqstnttSeqChkStr().length()-1);
			mngrOnlineReqstNttVO.setDynamicArr(reqstnttSeqChkStr.split(","));
		}
		
		return mngrOnlineReqstNttDAO.deleteOnlineReqstNtt(mngrOnlineReqstNttVO);
	}	
	
	/*
	 * 온라인신청 게시물 상세
	 */
	public MngrOnlineReqstNttVO selectOnlineReqstNttDetail(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		return mngrOnlineReqstNttDAO.selectOnlineReqstNttDetail(mngrOnlineReqstNttVO);
	}
	
	/*
	 * 온라인신청 게시물 수정
	 */
	public Integer modifyOnlineReqstNtt(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		int result = 0;
		result = mngrOnlineReqstNttDAO.modifyOnlineReqstNtt(mngrOnlineReqstNttVO);
		
		if(result > 0) {
			result = registOnlineReqstNttTrgter(mngrOnlineReqstNttVO);
		}		
		return result;		
	}	
	
	/*
	 * 온라인신청 게시물 대상자 목록
	 */
	public List<MngrOnlineReqstNttVO> selectOnlineReqstNttTrgterList(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception{
		return mngrOnlineReqstNttDAO.selectOnlineReqstNttTrgterList(mngrOnlineReqstNttVO);
	}		

	/*
	 * 온라인신청 게시물 대상자 정보 등록/수정
	 */
	public Integer registOnlineReqstNttTrgter(MngrOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
		int result = 0;
		int cnt = 0;
		String trgterUsrty = mngrOnlineReqstNttVO.getTrgterUsrty();
		String trgterUsrtyArr[] = null;
		
		if(trgterUsrty.indexOf(",") > -1) {
			trgterUsrtyArr = trgterUsrty.split(",");
		}
		
		
		cnt = mngrOnlineReqstNttDAO.selectOnlineReqstNttTrgterCnt(mngrOnlineReqstNttVO);
		if(cnt > 0) {
			result = mngrOnlineReqstNttDAO.deleteOnlineReqstNttTrgter(mngrOnlineReqstNttVO);
		} else {
			result = 1;
		}		
		
		if(result > 0) {
			if(trgterUsrtyArr != null) {
				if(trgterUsrtyArr.length > 0) {
					for(int i = 0; i < trgterUsrtyArr.length; i++) {
	
						//mngrOnlineReqstNttVO.setUsrgroupSeq("10000000012");
						mngrOnlineReqstNttVO.setUsrtySeq(trgterUsrtyArr[i]);
						if(mngrOnlineReqstNttVO.getUsrtySeq() != null && !mngrOnlineReqstNttVO.getUsrtySeq().equals("")) {
							result = mngrOnlineReqstNttDAO.registOnlineReqstNttTrgter(mngrOnlineReqstNttVO);	
						}
					}			
				}
			}
		}
		return result;		
	}		

}

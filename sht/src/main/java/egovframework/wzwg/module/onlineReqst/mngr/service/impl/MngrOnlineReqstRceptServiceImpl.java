package egovframework.wzwg.module.onlineReqst.mngr.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstRceptService;
import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstRceptVO;

@Service(value="MngrOnlineReqstRceptService")
public class MngrOnlineReqstRceptServiceImpl extends EgovAbstractServiceImpl implements MngrOnlineReqstRceptService {
	
	@Resource(name="MngrOnlineReqstRceptDAO")
	public MngrOnlineReqstRceptDAO mngrOnlineReqstRceptDAO;

	/*
	 * 온라인신청접수 목록
	 */
	public Map<String, Object> selectOnlineReqstRceptList(MngrOnlineReqstRceptVO mngrOnlineReqstRceptVO) throws Exception{
		List<MngrOnlineReqstRceptVO> resultList = mngrOnlineReqstRceptDAO.selectOnlineReqstRceptList(mngrOnlineReqstRceptVO);
		
		int totCnt = 0;
		
		totCnt = mngrOnlineReqstRceptDAO.selectOnlineReqstRceptListTotCnt(mngrOnlineReqstRceptVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", resultList);
		map.put("totCnt", Integer.toString(totCnt));
		
		return map;
	}	
	
	/*
	 * 온라인신청접수 삭제
	 */
	public Integer deleteOnlineReqstRcept(MngrOnlineReqstRceptVO mngrOnlineReqstRceptVO) throws Exception {
		int result = 0;
		result = mngrOnlineReqstRceptDAO.deleteOnlineReqstRcept(mngrOnlineReqstRceptVO);	
		return result;	
	}
	
	/*
	 * 온라인신청접수 삭제 (선택 삭제)
	 */
	public Integer deleteCheckOnlineReqstRcept(MngrOnlineReqstRceptVO mngrOnlineReqstRceptVO) throws Exception {
		
		String reqstnttSeqChkStr = StringUtils.defaultString(mngrOnlineReqstRceptVO.getRceptSeqChkStr());
		
		if(!"".equals(reqstnttSeqChkStr)){
			reqstnttSeqChkStr = mngrOnlineReqstRceptVO.getRceptSeqChkStr().substring(0, mngrOnlineReqstRceptVO.getRceptSeqChkStr().length()-1);
			mngrOnlineReqstRceptVO.setDynamicArr(reqstnttSeqChkStr.split(","));
		}
		
		return mngrOnlineReqstRceptDAO.deleteOnlineReqstRcept(mngrOnlineReqstRceptVO);
	}	
	
	/*
	 * 온라인신청접수 수정
	 */
	public Integer modifyOnlineReqstRcept(MngrOnlineReqstRceptVO mngrOnlineReqstRceptVO) throws Exception {
		int result = 0;
		String rceptSeqChkStr = mngrOnlineReqstRceptVO.getRceptSeqChkStr();
		String rceptSeqChkArr[] = null;
		String setConfmCodArr[] = null;

		if(rceptSeqChkStr.indexOf(",") > -1) {

			rceptSeqChkArr = rceptSeqChkStr.split(",");
			for(int i=0; i < (rceptSeqChkArr.length); i++) {

				if(rceptSeqChkArr[i].indexOf("|") > -1) {
					
					setConfmCodArr = rceptSeqChkArr[i].split("\\|");
					
					mngrOnlineReqstRceptVO.setRceptSeq(setConfmCodArr[0]);
					mngrOnlineReqstRceptVO.setConfmSttusCode(setConfmCodArr[1]);

					result = mngrOnlineReqstRceptDAO.modifyOnlineReqstRcept(mngrOnlineReqstRceptVO);
					
					if(result == 0) {break;}
				}
			}
		}
	
		return result;		
	}	
}

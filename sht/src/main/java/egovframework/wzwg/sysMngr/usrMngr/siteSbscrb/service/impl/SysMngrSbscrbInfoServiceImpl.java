package egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbInfoService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbQesitmService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbVO;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;


/**
 * ㅁ 시스템 - 사용자관리 - 가입정보관리
 * ㅁ DC   
 * - 시스템관리자가 사용자를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author 김c
 *
 */
@Service("SysMngrSbscrbInfoService")
@SuppressWarnings("unchecked")
public class SysMngrSbscrbInfoServiceImpl extends EgovAbstractServiceImpl implements SysMngrSbscrbInfoService {

    @Resource(name="SysMngrSbscrbInfoDAO")
    private SysMngrSbscrbInfoDAO sbscrbInfoDAO;
	
    @Resource(name="SysMngrSbscrbQesitmService")
    private SysMngrSbscrbQesitmService sbscrbQesitmService;
    
    
    
    /**
	 * ㅁ  시스템 - 사용자관리 - 가입정보관리 - 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SysMngrSbscrbVO> selectSbscrbInfoList(SysMngrSbscrbVO paramVO) throws Exception {
    	return sbscrbInfoDAO.selectSbscrbInfoList(paramVO);
    }

    /**
	 * ㅁ  시스템 - 사용자관리 - 가입정보관리 - 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectSbscrbInfoListTotCnt(SysMngrSbscrbVO paramVO) throws Exception {
    	return sbscrbInfoDAO.selectSbscrbInfoListTotCnt(paramVO);
    }
	
    /**
   	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSbscrbInfo(SysMngrSbscrbVO paramVO) throws Exception {
   		
    	int result =  0;
    	
    	// 등록
    	result = sbscrbInfoDAO.registSbscrbInfo(paramVO);
    	
    	if(result > 0 && "Y".equals(paramVO.getSbscrbQestnEstbsAt())){
    		result = registSiteUsrTySbscrb(paramVO);
    	}
    	
    	return result; 
    }

    /**
     * 사이트SEQ:회원유형 에따른 회원가입정보가 등록되어있나 체크 안되어있으면 등록시킴
     */
    public int registSbscrbInfoChk(SysMngrSbscrbVO paramVO) throws Exception {
        int result=0;
        
        int chk = sbscrbInfoDAO.selectSbscrbInfoListChk(paramVO);
        
        if (chk < 1) {
            result = sbscrbInfoDAO.registSbscrbInfo(paramVO);
        } else {
            result = 1;
        }
        
        return result;
    }
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSiteUsrTySbscrb(SysMngrSbscrbVO paramVO) throws Exception {
        
        int result = sbscrbQesitmService.registSbscrbQesitm(paramVO);
        
        return result; 
    }
    
    /**
   	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySbscrbInfo(SysMngrSbscrbVO paramVO) throws Exception {
    	
		int result = 0;
		
		/** 수정 */
		result = sbscrbInfoDAO.modifySbscrbInfo(paramVO);
		
		if(result > 0 && "Y".equals(paramVO.getSbscrbQestnEstbsAt())){
			result = modifySiteUsrTySbscrb(paramVO);
		}
		
   		return result;
    }
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySiteUsrTySbscrb(SysMngrSbscrbVO paramVO) throws Exception {
        
        int result = sbscrbQesitmService.modifySbscrbQesitm(paramVO);
        
        return result;
    }
    
    /**
   	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입정보설정여부 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int selectSbscrbinfoSeq(SysMngrSbscrbVO paramVO) throws Exception {
   		return sbscrbInfoDAO.selectSbscrbinfoSeq(paramVO);
    }

    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 상세정보
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public SysMngrSbscrbVO selectSbscrbInfoDetail(SysMngrSbscrbVO paramVO) throws Exception {
       	return sbscrbInfoDAO.selectSbscrbInfoDetail(paramVO);
	}
    
    /**
     * ㅁ 사이트 회원가입
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSbscrbInforspns(SysMngrSbscrbVO paramVO) throws Exception {
        
        int result =  0;
        
        List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();
        resultMap = JSONArray.fromObject(JSONSerializer.toJSON(paramVO.getRspnsArr().replaceAll("&quot;", "'")));
            
        if (resultMap != null && resultMap.size() > 0) {
            for(Map<String, Object> map : resultMap){
                
                paramVO.setQesitmSe(StringUtils.defaultString((String)map.get("qesitmSe")));
                paramVO.setSbscrbinfoSeq(StringUtils.defaultString((String)map.get("sbscrbinfoSeq")));
                paramVO.setSbscrbqesitmSeq(StringUtils.defaultString((String)map.get("sbscrbqesitmSeq")));
                
                if("S".equals(paramVO.getQesitmSe())){  // 주관식일 경우 주관식 응답
                    paramVO.setSbjctRspns(StringUtils.defaultString((String)map.get("sbjctRspns")));
                    paramVO.setSbscrbiemSeq(null);
                }
                
                if("O".equals(paramVO.getQesitmSe())){  // 객관식일 경우 객관식 항목 SEQ
                    paramVO.setSbjctRspns(null);
                    paramVO.setSbscrbiemSeq(StringUtils.defaultString((String)map.get("sbscrbiemSeq")));
                }
                
                // 등록
                result = sbscrbInfoDAO.registSbscrbInforspns(paramVO);
                result++;
            }
        } else {
            // 가입항목 설정 안됐을때 패쓰
            result = 1;
        }
    
        return result;
    }
    
    /**
     * ㅁ 사이트 회원가입
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySbscrbInforspns(SysMngrSbscrbVO paramVO) throws Exception {
        
        int result =  0;
        
        List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();
        resultMap = JSONArray.fromObject(JSONSerializer.toJSON(paramVO.getRspnsArr().replaceAll("&quot;", "'")));
            
        if (resultMap != null && resultMap.size() > 0) {
            for(Map<String, Object> map : resultMap){
                
                paramVO.setQesitmSe(StringUtils.defaultString((String)map.get("qesitmSe")));
                paramVO.setSbscrbinfoSeq(StringUtils.defaultString((String)map.get("sbscrbinfoSeq")));
                paramVO.setSbscrbqesitmSeq(StringUtils.defaultString((String)map.get("sbscrbqesitmSeq")));
                paramVO.setSbscrbrspns(StringUtils.defaultString((String)map.get("sbscrbrspns")));
                
                if("S".equals(paramVO.getQesitmSe())){  // 주관식일 경우 주관식 응답
                    paramVO.setSbjctRspns(StringUtils.defaultString((String)map.get("sbjctRspns")));
                    paramVO.setSbscrbiemSeq(null);
                }
                
                if("O".equals(paramVO.getQesitmSe())){  // 객관식일 경우 객관식 항목 SEQ
                    paramVO.setSbjctRspns(null);
                    paramVO.setSbscrbiemSeq(StringUtils.defaultString((String)map.get("sbscrbiemSeq")));
                }
                
                // 등록
                int chkCnt = sbscrbInfoDAO.selectSbscrbInforspnsCnt(paramVO);
                
                if (chkCnt > 0) {
                    result = sbscrbInfoDAO.modifySbscrbInforspns(paramVO);
                } else {
                    result = sbscrbInfoDAO.registSbscrbInforspns(paramVO);
                }
                
                result++;
            }
        } else {
            // 가입항목 설정 안됐을때 패쓰
            result = 1;
        }
    
        return result;
    }
    
    /**
     * ㅁ 가입절차에 필요한 정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySbscrbProcssInfo(SysMngrSbscrbVO paramVO) throws Exception {
        
        return sbscrbInfoDAO.modifySbscrbProcssInfo(paramVO);
    }
   	
    
}

package egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.IllegalFormatException;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbQesitmService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbVO;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
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
@Slf4j
@Service("SysMngrSbscrbQesitmService")
@SuppressWarnings("unchecked")
public class SysMngrSbscrbQesitmServiceImpl extends EgovAbstractServiceImpl implements SysMngrSbscrbQesitmService {

    @Resource(name="SysMngrSbscrbQesitmDAO")
    private SysMngrSbscrbQesitmDAO sbscrbQesitmDAO;
	
    /**
   	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSbscrbQesitm(SysMngrSbscrbVO paramVO) throws Exception {
    	
    	int result = 0;
    	
    	try {
        	List<Map<String, Object>> qesitm_resultMap 	= new ArrayList<Map<String, Object>>();
    		List<Map<String, Object>> iem_resultMap 	= new ArrayList<Map<String, Object>>();
    		qesitm_resultMap 	= JSONArray.fromObject(JSONSerializer.toJSON(paramVO.getQesitmArr().replaceAll("&quot;", "'")));
    		iem_resultMap 		= JSONArray.fromObject(JSONSerializer.toJSON(paramVO.getIemArr().replaceAll("&quot;", "'")));
    		
    		for (Map<String, Object> qesitm_map : qesitm_resultMap) {
    			
    			/** 가입문항 SEQ 추출 */
    			String sbscrbqesitmSeq = sbscrbQesitmDAO.selectNextSbscrbQesitmSeq();
    			paramVO.setSbscrbqesitmSeq(sbscrbqesitmSeq);
    			
    			paramVO.setQesitmSe(qesitm_map.get("qesitmSe").toString());
    			paramVO.setQesitmSj(qesitm_map.get("qesitmSj").toString());
    			
    			/* 가입문항 등록 */
    			sbscrbQesitmDAO.registSbscrbQesitm(paramVO);
    			
    			if("O".equals(paramVO.getQesitmSe())){
    				
    				for(Map<String, Object> iem_map : iem_resultMap){
    						
    					if((iem_map.get("qesitmSeq").toString()).equals(qesitm_map.get("qesitmSeq").toString())){
    						
    						int iem_len = Integer.parseInt(iem_map.get("iem_len").toString());
    						
    						for(int i = 1; i <= iem_len; i++){
    							paramVO.setIemSj(iem_map.get("iem"+i).toString());
    							
    							// 가입항목 등록 
    							sbscrbQesitmDAO.registSbscrbQesitmIem(paramVO);
    						}
    					}
    					
    				}
    				
    			}
    			
    			result = 1;
    		}
    	} catch(NullPointerException e){
      		 result = 0;
   	   	}catch(NumberFormatException e){
   	   	 result = 0;
   	   	}catch(IllegalFormatException e){
   	   	 result = 0;
   	   	}catch(ArrayIndexOutOfBoundsException e){
   	   	 result = 0;
   	   	}catch(IOException e){
   	   	 result = 0;
   	   	}catch(SQLException e){
   	   	 result = 0;
   	   	}  
    	
    	return result; 
    }
    
    /**
   	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySbscrbQesitm(SysMngrSbscrbVO paramVO) throws Exception {
    	
		int result = 0;
		
		try {	
        	List<Map<String, Object>> qesitm_resultMap 	= new ArrayList<Map<String, Object>>();
        	List<Map<String, Object>> iem_resultMap 	= new ArrayList<Map<String, Object>>();
        	qesitm_resultMap 	= JSONArray.fromObject(JSONSerializer.toJSON(paramVO.getQesitmArr().replaceAll("&quot;", "'")));
    		iem_resultMap 		= JSONArray.fromObject(JSONSerializer.toJSON(paramVO.getIemArr().replaceAll("&quot;", "'")));
    		
    		String sbscrbinfoSeq = sbscrbQesitmDAO.selectSbscrbinfoSeq(paramVO);
    		
    		paramVO.setSbscrbinfoSeq(sbscrbinfoSeq);
    		
    		for(Map<String, Object> qesitm_map : qesitm_resultMap){
    			
    			paramVO.setQesitmSe(qesitm_map.get("qesitmSe").toString());
    			paramVO.setQesitmSj(qesitm_map.get("qesitmSj").toString());
    			
    			if(qesitm_map.get("sbscrbqesitmSeq") == null){
    				
    				paramVO.setFrstRegisterId(paramVO.getLastUpdusrId());
    				/** 가입문항 SEQ 추출 */
    				paramVO.setSbscrbqesitmSeq(sbscrbQesitmDAO.selectNextSbscrbQesitmSeq());
    				/* 등록 */
    				sbscrbQesitmDAO.registSbscrbQesitm(paramVO);
    			}else{
    				paramVO.setSbscrbqesitmSeq(qesitm_map.get("sbscrbqesitmSeq").toString());
    				/* 수정 */
    				sbscrbQesitmDAO.modifySbscrbQesitm(paramVO);
    				
    				if("S".equals(paramVO.getQesitmSe())){	// 주관식일 경우 해당 문항SEQ에 해당하는 객관식 항목 삭제처리
    					// 객관식 가입항목 삭제
    					sbscrbQesitmDAO.deleteSbscrbQesitmObjctIemList(paramVO);
    				}
    			}
    			
    			if("O".equals(paramVO.getQesitmSe())){
    				
    				for(Map<String, Object> iem_map : iem_resultMap){
    						
    					if((iem_map.get("qesitmSeq").toString()).equals(qesitm_map.get("qesitmSeq").toString())){
    						
    						int iem_len = Integer.parseInt(iem_map.get("iem_len").toString());
    						
    						for(int i = 1; i <= iem_len; i++){
    						    
    						    String iemSj = StringUtils.defaultString((String)iem_map.get("iem"+i));
    						    
    						    if (!"".equals(iemSj)) {
    						        
    						        paramVO.setIemSj(iemSj);
    						        
    						        if(iem_map.get("sbscrbiemSeq"+i) == null){
    						            paramVO.setFrstRegisterId(paramVO.getLastUpdusrId());
    						            // 등록 
    						            sbscrbQesitmDAO.registSbscrbQesitmIem(paramVO);
    						        }else{
    						            paramVO.setSbscrbiemSeq(iem_map.get("sbscrbiemSeq"+i).toString());
    						            // 수정 
    						            sbscrbQesitmDAO.modifySbscrbQesitmIem(paramVO);
    						        }
    						    }
    						}
    					}
    					
    				}
    				
    			}
    		}
    		
    		result = 1;
		} catch(NullPointerException e){
	   		 result = 0;
		   	}catch(NumberFormatException e){
		   	 result = 0;
		   	}catch(IllegalFormatException e){
		   	 result = 0;
		   	}catch(ArrayIndexOutOfBoundsException e){
		   	 result = 0;
		   	}catch(IOException e){
		   	 result = 0;
		   	}catch(SQLException e){
		   	 result = 0;
		   	}  
		
   		return result;
    }
    
   	/**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public List<SysMngrSbscrbVO> selectSbscrbQesitmList(SysMngrSbscrbVO paramVO) throws Exception {
   		return sbscrbQesitmDAO.selectSbscrbQesitmList(paramVO);
   	}
   	
   	/**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 객관식 항목 목록 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public List<SysMngrSbscrbVO> selectSbscrbIemList(SysMngrSbscrbVO paramVO) throws Exception {
   		return sbscrbQesitmDAO.selectSbscrbIemList(paramVO);
   	}
   	
   	/**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 질문삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public int deleteSbscrbQesitm(SysMngrSbscrbVO paramVO) throws Exception {
   		return sbscrbQesitmDAO.deleteSbscrbQesitm(paramVO);
   	}
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 -사용자 답변 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SysMngrSbscrbVO> selectSbscrbIemUsrRspns(SysMngrSbscrbVO paramVO) throws Exception {
        return sbscrbQesitmDAO.selectSbscrbIemUsrRspns(paramVO);
    }
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 -사용자 답변 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SysMngrSbscrbVO> selectSbscrbQesitmUsrRspns(SysMngrSbscrbVO paramVO) throws Exception {
        return sbscrbQesitmDAO.selectSbscrbQesitmUsrRspns(paramVO);
    }
    
}

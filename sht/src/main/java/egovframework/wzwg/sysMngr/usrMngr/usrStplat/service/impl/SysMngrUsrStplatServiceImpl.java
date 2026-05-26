package egovframework.wzwg.sysMngr.usrMngr.usrStplat.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.usrMngr.usrStplat.service.SysMngrUsrStplatService;
import egovframework.wzwg.sysMngr.usrMngr.usrStplat.service.SysMngrUsrStplatVO;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;


/**
 * ㅁ 시스템 - 사용자관리 - 가입약관관리
 * ㅁ DC   
 * - 시스템관리자가 사용자를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author 김c
 *
 */
@Service("SysMngrUsrStplatService")
@SuppressWarnings("unchecked")
public class SysMngrUsrStplatServiceImpl extends EgovAbstractServiceImpl implements SysMngrUsrStplatService {

    @Resource(name="SysMngrUsrStplatDAO")
    private SysMngrUsrStplatDAO usrStplatDAO;
	

    public List<SysMngrUsrStplatVO> selectSysUsrStplatList(SysMngrUsrStplatVO paramVO) throws Exception {

        return usrStplatDAO.selectSysUsrStplatList(paramVO);
    }
    public int selectSysUsrStplatListCnt(SysMngrUsrStplatVO paramVO) throws Exception {

        return usrStplatDAO.selectSysUsrStplatListCnt(paramVO);
    }
    public SysMngrUsrStplatVO selectSysUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception {

        return usrStplatDAO.selectSysUsrStplat(paramVO);
    }
    public int registSysUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception {

        return usrStplatDAO.registSysUsrStplat(paramVO);
    }
    public int modifySysUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception {

        // 약관설정 수정이력 등록
        usrStplatDAO.registSysUsrStplatHist(paramVO);
        
        // 약관설정 수정
        return usrStplatDAO.modifySysUsrStplat(paramVO);
    }
    public int deleteSysUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception {

        return usrStplatDAO.deleteSysUsrStplat(paramVO);
    }
    public List<SysMngrUsrStplatVO> selectSysUsrStplatHistList(SysMngrUsrStplatVO paramVO) throws Exception {

        return usrStplatDAO.selectSysUsrStplatHistList(paramVO);
    }
    public int registSysUsrStplatHist(SysMngrUsrStplatVO paramVO) throws Exception {

        return usrStplatDAO.registSysUsrStplatHist(paramVO);
    }
    public int deleteSysUsrStplatHist(SysMngrUsrStplatVO paramVO) throws Exception {

        String[] usrstphistSeqArr = paramVO.getUsrstphistSeqArr();
        
        int result = 0;
        
        if (usrstphistSeqArr != null) {
            
            for (int i=0; i<usrstphistSeqArr.length; i++) {
                
                String usrstphistSeq = StringUtils.defaultString(usrstphistSeqArr[i]);
                
                if (!"".equals(usrstphistSeq)) {
                    
                    paramVO.setUsrstphistSeq(usrstphistSeq);
                    
                    result = usrStplatDAO.deleteSysUsrStplatHist(paramVO);      
                }
            }
        }
        
        return result;
    }
    /**
	 * ㅁ  시스템 - 사용자관리 - 가입약관관리 - 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SysMngrUsrStplatVO> selectUsrStplatList(SysMngrUsrStplatVO paramVO) throws Exception {
    	return usrStplatDAO.selectUsrStplatList(paramVO);
    }

    /**
	 * ㅁ  시스템 - 사용자관리 - 가입약관관리 - 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectUsrStplatListTotCnt(SysMngrUsrStplatVO paramVO) throws Exception {
    	return usrStplatDAO.selectUsrStplatListTotCnt(paramVO);
    }
	
    /**
   	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception {
   		
    	int result =  0;
    	
    	// 등록
    	result = usrStplatDAO.registUsrStplat(paramVO);
    	
    	if(result > 0 && "Y".equals(paramVO.getSbscrbQestnEstbsAt())){
    		
	    	List<Map<String, Object>> qesitm_resultMap 	= new ArrayList<Map<String, Object>>();
			List<Map<String, Object>> iem_resultMap 	= new ArrayList<Map<String, Object>>();
			qesitm_resultMap 	= JSONArray.fromObject(JSONSerializer.toJSON(paramVO.getQesitmArr().replaceAll("&quot;", "'")));
			iem_resultMap 		= JSONArray.fromObject(JSONSerializer.toJSON(paramVO.getIemArr().replaceAll("&quot;", "'")));
			
			for(Map<String, Object> qesitm_map : qesitm_resultMap){
				
				/** 가입문항 SEQ 추출 */
				String sbscrbqesitmSeq = usrStplatDAO.selectNextSbscrbQesitmSeq();
				paramVO.setSbscrbqesitmSeq(sbscrbqesitmSeq);
				
				paramVO.setQesitmSe(qesitm_map.get("qesitmSe").toString());
				paramVO.setQesitmSj(qesitm_map.get("qesitmSj").toString());
				
				/* 가입문항 등록 */
				usrStplatDAO.registUsrStplatQesitm(paramVO);
				
				if("O".equals(paramVO.getQesitmSe())){
					
					for(Map<String, Object> iem_map : iem_resultMap){
							
						if((iem_map.get("qesitmSeq").toString()).equals(qesitm_map.get("qesitmSeq").toString())){
							
							int iem_len = Integer.parseInt(iem_map.get("iem_len").toString());
							
							for(int i = 1; i <= iem_len; i++){
								paramVO.setIemSj(iem_map.get("iem"+i).toString());
								
								// 가입항목 등록 
								usrStplatDAO.registUsrStplatIem(paramVO);
							}
						}
						
					}
					
				}
			}
		
    	}
    	
    	return result; 
    }
    
    /**
   	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception {
    	
		int result = 0;
		
		/** 수정 */
		result = usrStplatDAO.modifyUsrStplat(paramVO);
		
		if(result > 0 && "Y".equals(paramVO.getSbscrbQestnEstbsAt())){
			
	    	List<Map<String, Object>> qesitm_resultMap 	= new ArrayList<Map<String, Object>>();
	    	List<Map<String, Object>> iem_resultMap 	= new ArrayList<Map<String, Object>>();
	    	qesitm_resultMap 	= JSONArray.fromObject(JSONSerializer.toJSON(paramVO.getQesitmArr().replaceAll("&quot;", "'")));
			iem_resultMap 		= JSONArray.fromObject(JSONSerializer.toJSON(paramVO.getIemArr().replaceAll("&quot;", "'")));
			
			for(Map<String, Object> qesitm_map : qesitm_resultMap){
				
				paramVO.setQesitmSe(qesitm_map.get("qesitmSe").toString());
				paramVO.setQesitmSj(qesitm_map.get("qesitmSj").toString());
				
				if(qesitm_map.get("sbscrbqesitmSeq") == null){
					
					paramVO.setFrstRegisterId(paramVO.getLastUpdusrId());
					/** 가입문항 SEQ 추출 */
					paramVO.setSbscrbqesitmSeq(usrStplatDAO.selectNextSbscrbQesitmSeq());
					/* 등록 */
					usrStplatDAO.registUsrStplatQesitm(paramVO);
				}else{
					paramVO.setSbscrbqesitmSeq(qesitm_map.get("sbscrbqesitmSeq").toString());
					/* 수정 */
					usrStplatDAO.modifyUsrStplatQesitm(paramVO);
					
					if("S".equals(paramVO.getQesitmSe())){	// 주관식일 경우 해당 문항SEQ에 해당하는 객관식 항목 삭제처리
						// 객관식 가입항목 삭제
						usrStplatDAO.deleteUsrStplatObjctIemList(paramVO);
					}
				}
				
				if("O".equals(paramVO.getQesitmSe())){
					
					for(Map<String, Object> iem_map : iem_resultMap){
							
						if((iem_map.get("qesitmSeq").toString()).equals(qesitm_map.get("qesitmSeq").toString())){
							
							int iem_len = Integer.parseInt(iem_map.get("iem_len").toString());
							
							for(int i = 1; i <= iem_len; i++){
								paramVO.setIemSj(iem_map.get("iem"+i).toString());
								
								if(iem_map.get("sbscrbiemSeq"+i) == null){
									paramVO.setFrstRegisterId(paramVO.getLastUpdusrId());
									// 등록 
									usrStplatDAO.registUsrStplatIem(paramVO);
								}else{
									paramVO.setSbscrbiemSeq(iem_map.get("sbscrbiemSeq"+i).toString());
									// 수정 
									usrStplatDAO.modifyUsrStplatIem(paramVO);
								}
							}
						}
						
					}
					
				}
			}
		}
		
   		return result;
    }
    
    /**
   	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 가입정보설정여부 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int selectSbscrbinfoSeq(SysMngrUsrStplatVO paramVO) throws Exception {
   		return usrStplatDAO.selectSbscrbinfoSeq(paramVO);
    }

    /**
     * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 상세정보
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public SysMngrUsrStplatVO selectUsrStplatDetail(SysMngrUsrStplatVO paramVO) throws Exception {
       	return usrStplatDAO.selectUsrStplatDetail(paramVO);
	}
   	
   	/**
     * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 가입문항 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public List<SysMngrUsrStplatVO> selectSbscrbQesitmList(SysMngrUsrStplatVO paramVO) throws Exception {
   		return usrStplatDAO.selectSbscrbQesitmList(paramVO);
   	}
   	
   	/**
     * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 객관식 항목 목록 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public List<SysMngrUsrStplatVO> selectSbscrbIemList(SysMngrUsrStplatVO paramVO) throws Exception {
   		return usrStplatDAO.selectSbscrbIemList(paramVO);
   	}

    
}

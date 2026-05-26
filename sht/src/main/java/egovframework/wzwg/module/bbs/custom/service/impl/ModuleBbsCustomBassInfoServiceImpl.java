package egovframework.wzwg.module.bbs.custom.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.cmmn.service.impl.ModuleBbsCmmnDAO;
import egovframework.wzwg.module.bbs.custom.service.ModuleBbsCustomBassInfoService;
import egovframework.wzwg.module.bbs.custom.service.ModuleBbsCustomVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;



@Service("ModuleBbsCustomBassInfoService")
public class ModuleBbsCustomBassInfoServiceImpl extends EgovAbstractServiceImpl implements ModuleBbsCustomBassInfoService {
    
    @Resource(name="CntntsInfoDAO")
    CntntsInfoDAO cntntsInfoDAO;

    @Resource(name="ModuleBbsCmmnDAO")
    protected ModuleBbsCmmnDAO bbsCmmnDAO;
    
	@Resource(name="ModuleBbsCustomBassInfoDAO")
    protected ModuleBbsCustomBassInfoDAO bbsCustomBassInfoDAO;
	
	final ObjectMapper mapper = new ObjectMapper();
	

	/**
	 * ㅁ 게시판 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleBbsVO selectBbsBassInfoDetail(ModuleBbsVO moduleBbsVO) throws Exception {
		return bbsCustomBassInfoDAO.selectBbsBassInfoDetail(moduleBbsVO);
	}
    
    /**
     * ㅁ 게시판 기본정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyBbsBassInfo(ModuleBbsVO moduleBbsVO) throws Exception {
        
        CntntsInfoVO paramVO = new CntntsInfoVO();
        
        paramVO.setCntntsNm(moduleBbsVO.getBbsNm());
        paramVO.setCntntsDc(moduleBbsVO.getBbsDc());
        paramVO.setSitecntntsSeq(moduleBbsVO.getSitecntntsSeq());
        paramVO.setLastUpdusrId(moduleBbsVO.getLastUpdusrId());
        
        cntntsInfoDAO.modifyCntntsInfoInit(paramVO);
        
        return bbsCustomBassInfoDAO.modifyBbsBassInfo(moduleBbsVO);
    }
    
    /**
     * ㅁ 게시판 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registBbsBassInfo(ModuleBbsVO moduleBbsVO) throws Exception {
        String bbsSeq = bbsCmmnDAO.selectBbsSeq();
        moduleBbsVO.setBbsSeq(bbsSeq);
        
        RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
        
        if( attributes != null ) {
        	attributes.setAttribute("regist_sysModuleSeq", bbsSeq, RequestAttributes.SCOPE_SESSION);
        }
        
        return bbsCustomBassInfoDAO.registBbsBassInfo(moduleBbsVO);
    }
    
    /**
     * ㅁ 게시판 초기 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String registBbsBassInfoInit(ModuleBbsVO moduleBbsVO) throws Exception {
        String bbsSeq = bbsCmmnDAO.selectBbsSeq();
        moduleBbsVO.setBbsSeq(bbsSeq);
        bbsCustomBassInfoDAO.registBbsBassInfo(moduleBbsVO);
        return bbsSeq;
    }
	
    /**
	 * ㅁ 게시판 커스텀 필드정보 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleBbsCustomVO> selectBbsBassInfoCustomFieldList(Map<String, String> fieldVO) throws Exception {
		return bbsCustomBassInfoDAO.selectBbsBassInfoCustomFieldList(fieldVO);
	} 

	/**
	 * ㅁ 게시판 커스텀 필드정보 입력
     * @param paramVO
     * @return
     * @throws Exception
     */
	@Override
	public int registBbsBassInfoCustomField(Map<String, String> fieldVO) throws Exception {
		return bbsCustomBassInfoDAO.registBbsBassInfoCustomField(fieldVO);
	}

	/**
	 * ㅁ 게시판 커스텀 필드정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	@Override
	public int deleteBbsBassInfoCustomField(Map<String, String> fieldVO) throws Exception {
		return bbsCustomBassInfoDAO.deleteBbsBassInfoCustomField(fieldVO);
	}
	
	/**
	 * ㅁ 게시판 커스텀 비밀번호 필드정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	@Override
	public int deleteBbsBassInfoCustomPasswordField(Map<String, String> fieldVO) throws Exception {
		return bbsCustomBassInfoDAO.deleteBbsBassInfoCustomPasswordField(fieldVO);
	}
	
	public String getCustomJsonContents(String siteSeq, String bbsSeq, String nttSeq, Map<String, String> files, HttpServletRequest request) throws Exception{
		Map<String, String> param = new HashMap<String, String>();
		param.put("siteSeq", siteSeq);
		param.put("bbsSeq", bbsSeq);
		List<ModuleBbsCustomVO> fieldList = selectBbsBassInfoCustomFieldList(param);
		
		param.remove("siteSeq");		param.remove("bbsSeq");		param = null;
		
		Map<String, String> jsonMap = new HashMap<String, String>();
		
		for (ModuleBbsCustomVO field : fieldList) {
			String type = String.valueOf(field.getFieldTy());
			String key = String.valueOf(field.getFieldId()); 
			String value = "";//request.getParameter(key);
			
			if(type.equals("image") || type.equals("file") ){
				value = files.get(key);
				if(value == null || value.equals("")){
					value = request.getParameter("save_" + key);
				}
			}else{
				value = request.getParameter(key);
			}
			
			
			jsonMap.put(key, value);
		}
		jsonMap.put("nttSeq", nttSeq);
		String result = mapper.writeValueAsString(jsonMap);
		return result;
	}
	
	 /**
     * ㅁ 게시판 커스텀 입력데이터 JSON 변환
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Map<String, String> getCustomContentsToMap(String nttCn) throws Exception{
    	Map<String, String> result = mapper.readValue(nttCn, new TypeReference<Map<String, String>>(){});
    	
    	return result;
    }
	
    /**
   	 * ㅁ 게시판 기본정보 추가기능
        * @param paramVO
        * @return
        * @throws Exception
        */
   	public ModuleBbsVO selectBbsCustomFunctionDetail(ModuleBbsVO moduleBbsVO) throws Exception{
   	
   		return bbsCustomBassInfoDAO.selectBbsCustomFunctionDetail(moduleBbsVO);
   	}
   	
   	/**
        * ㅁ 게시판 기본정보 추가기능 수정
        * @param paramVO
        * @return
        * @throws Exception
        */
   	public int modifyBbsCustomFunctionInfo(ModuleBbsVO moduleBbsVO) throws Exception{
   		if(String.valueOf(moduleBbsVO.getNolognAt()).equalsIgnoreCase("Y") == false){
   			moduleBbsVO.setNolognAt("N");
   		}
   		return bbsCustomBassInfoDAO.modifyBbsCustomFunctionInfo(moduleBbsVO);
   	}
       
   /**
	    * ㅁ 게시판 기본정보 추가기능 등록
	    * @param paramVO
	    * @return
	    * @throws Exception
    */
   	public int registBbsCustomFunctionInfo(ModuleBbsVO moduleBbsVO) throws Exception{
   		if(String.valueOf(moduleBbsVO.getNolognAt()).equalsIgnoreCase("Y") == false){
   			moduleBbsVO.setNolognAt("N");
   		}
   		return bbsCustomBassInfoDAO.registBbsCustomFunctionInfo(moduleBbsVO);
   	}
}

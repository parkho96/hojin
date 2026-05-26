package egovframework.wzwg.module.onlineQustnr.service.impl;

import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrInfoService;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrInfoVO;

@Service("ModuleOnlineQustnrInfoService")
public class ModuleOnlineQustnrInfoServiceImpl extends EgovAbstractServiceImpl implements ModuleOnlineQustnrInfoService {
	
	@Resource(name="ModuleOnlineQustnrInfoDAO")
	ModuleOnlineQustnrInfoDAO onlineQustnrInfoDAO;
	
	protected static final Log LOG = LogFactory.getLog(ModuleOnlineQustnrInfoServiceImpl.class);

	/**
	 * @Method Name : selectOnlineQustnrInfoTotCnt
	 * @Method 설명 : 설문 총 카운트 조회
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public Integer selectOnlineQustnrInfoTotCnt(ModuleOnlineQustnrInfoVO paramVO) {
		return onlineQustnrInfoDAO.selectOnlineQustnrInfoTotCnt(paramVO);
	}

	/**
	 * @Method Name : selectOnlineQustnrInfoList
	 * @Method 설명 : 설문 리스트 조회
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public List<ModuleOnlineQustnrInfoVO> selectOnlineQustnrInfoList(ModuleOnlineQustnrInfoVO paramVO) {
		return onlineQustnrInfoDAO.selectOnlineQustnrInfoList(paramVO);
	}

	/**
	 * @Method Name : selectOnlineQustnrInfoDetail
	 * @Method 설명 : 설문 상세 조회
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public ModuleOnlineQustnrInfoVO selectOnlineQustnrInfoDetail(ModuleOnlineQustnrInfoVO paramVO) {
		return onlineQustnrInfoDAO.selectOnlineQustnrInfoDetail(paramVO);
	}

	/**
	 * @Method Name : registOnlineQustnrInfo
	 * @Method 설명 : 설문 등록
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int registOnlineQustnrInfo(ModuleOnlineQustnrInfoVO paramVO) {
		String qustnrSeq = onlineQustnrInfoDAO.selectOnlineQustnrInfoSeq();
		paramVO.setQustnrSeq(qustnrSeq);
		
		int result = onlineQustnrInfoDAO.registOnlineQustnrInfo(paramVO);
		
		if(result > 0 && paramVO.getUsrtySeqArr() != null && paramVO.getUsrtySeqArr().length > 0){
			for(int i=0; i<paramVO.getUsrtySeqArr().length; i++){
				paramVO.setUsrtySeq(paramVO.getUsrtySeqArr()[i]);
				registOnlineQustnrUsrty(paramVO);
			}
		}
		
		/** 설문 대상자 입력 */
		paramVO.getUsrtySeqArr();
		
		return result; 
	}

	/**
	 * @Method Name : modifyOnlineQustnrInfo
	 * @Method 설명 : 설문 수정
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int modifyOnlineQustnrInfo(ModuleOnlineQustnrInfoVO paramVO) {
		
		int result = onlineQustnrInfoDAO.modifyOnlineQustnrInfo(paramVO);

		if(result > 0 && paramVO.getUsrtySeqArr() != null && paramVO.getUsrtySeqArr().length > 0){
			/** 설문 대상자 전체삭제 후 재등록 */
			deleteOnlineQustnrUsrty(paramVO);
			
			for(int i=0; i<paramVO.getUsrtySeqArr().length; i++){
				paramVO.setUsrtySeq(paramVO.getUsrtySeqArr()[i]);
				registOnlineQustnrUsrty(paramVO);
			}
		}
		
		return result;
	}

	/**
	 * @Method Name : deleteOnlineQustnrInfo
	 * @Method 설명 : 설문 삭제
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int deleteOnlineQustnrInfo(ModuleOnlineQustnrInfoVO paramVO) {
		return onlineQustnrInfoDAO.deleteOnlineQustnrInfo(paramVO);
	}

	/**
	 * @Method Name : deleteOnlineQustnrInfoArr
	 * @Method 설명 : 설문 삭제 (다중)
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int deleteOnlineQustnrInfoArr(ModuleOnlineQustnrInfoVO paramVO) {
		
		int result = 0;

		try {
			if(paramVO.getQustnrSeqArr() != null && paramVO.getQustnrSeqArr().length > 0){
				for(int i=0; i<paramVO.getQustnrSeqArr().length; i++){
					paramVO.setQustnrSeq(paramVO.getQustnrSeqArr()[i]);
					result += deleteOnlineQustnrInfo(paramVO);
				}
			}
		}catch(NullPointerException e){
			LOG.error("NullPointerException",e);			
	   	}catch(NumberFormatException e){	   		
	   		LOG.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){	   			   		
	   		LOG.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		LOG.error("ArrayIndexOutOfBoundsException",e);
	   	}
		
		return result;
	}

	/**
	 * @Method Name : registOnlineQustnrUsrty
	 * @Method 설명 : 설문 대상자 등록
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	private void registOnlineQustnrUsrty(ModuleOnlineQustnrInfoVO paramVO) {
		onlineQustnrInfoDAO.registOnlineQustnrUsrty(paramVO);
	}

	/**
	 * @Method Name : deleteOnlineQustnrUsrty
	 * @Method 설명 : 설문 대상자 삭제
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	private void deleteOnlineQustnrUsrty(ModuleOnlineQustnrInfoVO paramVO){
		onlineQustnrInfoDAO.deleteOnlineQustnrUsrty(paramVO);
	}

	/**
	 * @Method Name : selectOnlineQustnrUsrtyList
	 * @Method 설명 : 적용중인 설문 대상자 리스트 조회
	 * @작성일 : 2019. 6. 4.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public List<ModuleOnlineQustnrInfoVO> selectOnlineQustnrUsrtyList(ModuleOnlineQustnrInfoVO paramVO) {
		return onlineQustnrInfoDAO.selectOnlineQustnrUsrtyList(paramVO);
	}
}

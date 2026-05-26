package egovframework.wzwg.module.onlineQustnr.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrRespondService;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrRespondVO;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("ModuleOnlineQustnrRespondService")
public class ModuleOnlineQustnrRespondServiceImpl extends EgovAbstractServiceImpl implements ModuleOnlineQustnrRespondService {
	
	@Resource(name="ModuleOnlineQustnrRespondDAO")
	ModuleOnlineQustnrRespondDAO moduleOnlineQustnrRespondDAO;

	/**
	 * @Method Name : selectQustnrInfoTotCnt
	 * @Method 설명 : 온라인 설문 총 카운트 조회
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public Integer selectQustnrInfoTotCnt(ModuleOnlineQustnrRespondVO paramVO) {
		return moduleOnlineQustnrRespondDAO.selectQustnrInfoTotCnt(paramVO);
	}

	/**
	 * @Method Name : selectOnlineQustnrList
	 * @Method 설명 : 온라인설문 리스트 조회
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public List<ModuleOnlineQustnrRespondVO> selectOnlineQustnrList(ModuleOnlineQustnrRespondVO paramVO) {
		return moduleOnlineQustnrRespondDAO.selectOnlineQustnrList(paramVO);
	}

	/**
	 * @Method Name : registOnlineQustnrRespond
	 * @Method 설명 : 온라인설문 답변 등록
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int registOnlineQustnrRespond(ModuleOnlineQustnrRespondVO paramVO) {
		int result = 0;
		
		String[] responseValueArr = paramVO.getResponseValue();
		try {
			if(responseValueArr != null) {
				for(int i=0; i<responseValueArr.length; i++){
					String respondSeq = moduleOnlineQustnrRespondDAO.selectOnlineQustnrRespondSeq();
					paramVO.setRespondSeq(respondSeq);
					
					String[] arrResult = responseValueArr[i].split("\\$\\$\\!\\$");
					
					paramVO.setQesitmSeq(arrResult[0]);
					paramVO.setIemSeq(arrResult[1]);
					
					if(arrResult.length < 3){
						paramVO.setDscrpAnswer("");
					}else{
						paramVO.setDscrpAnswer(arrResult[2]);
					}
					
					result += moduleOnlineQustnrRespondDAO.registOnlineQustnrRespond(paramVO);
				}
			}else{
				throw new NullPointerException("responseValueArr NullPointerException");
			}
			
		} catch (NullPointerException e) {
			log.error("NullPointerException", e);
		} catch (RuntimeException e) {
			log.error("RuntimeException", e);
		}
		
		
		return result;
	}

}

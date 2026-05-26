package egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl;

import java.util.IllegalFormatException;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.module.upload.fileMngr.service.ModuleUploadFileMngrService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.impl.CntntsAuthDAO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("CntntsInfoService")
public class CntntsInfoServiceImpl extends EgovAbstractServiceImpl implements CntntsInfoService {
	
	@Resource(name="CntntsInfoDAO")
    private CntntsInfoDAO cntntsInfoDAO;

	// 컨텐츠권한
    @Resource(name="CntntsAuthDAO")
    private CntntsAuthDAO cntntsAuthDAO;
    
    @Resource(name="ModuleUploadFileMngrService")
   	private ModuleUploadFileMngrService moduleUploadFileMngrService;

	/**
	 * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 목록
	 * @param CntntsInfoVO
	 * @return
	 */
	public List<CntntsInfoVO> selectCntntsInfoList(CntntsInfoVO paramVO) {

		return cntntsInfoDAO.selectCntntsInfoList(paramVO);
	}

    /**
	 * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectCntntsInfoListCnt(CntntsInfoVO paramVO) {

		return cntntsInfoDAO.selectCntntsInfoListCnt(paramVO);
	}

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보
     * @param CntntsInfoVO
     * @return
     */
    public CntntsInfoVO selectCntntsInfo(CntntsInfoVO paramVO) {

        return cntntsInfoDAO.selectCntntsInfo(paramVO);
    }

	/**
	 * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 전체 목록
	 * @param String
	 * @return
	 */
	public List<CntntsInfoVO> selectCntntsInfoAllList(String siteSeq) {

		return cntntsInfoDAO.selectCntntsInfoAllList(siteSeq);
	}
	
	/**
	 * ㅁ 컨텐츠정보 - 모듈 메뉴 컨텐츠 정보 전체 목록
	 * @param String
	 * @return
	 */
	public List<CntntsInfoVO> selectMenuCntntsInfoAllList(String siteSeq) {
		return cntntsInfoDAO.selectMenuCntntsInfoAllList(siteSeq);
	}

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 등록
     * @param String
     * @return
     */
    public int registCntntsInfo(CntntsInfoVO paramVO) {
        
        String sitecntntsSeq = cntntsInfoDAO.selectCntntsInfoSeq();
        
        paramVO.setSitecntntsSeq(sitecntntsSeq);

        return cntntsInfoDAO.registCntntsInfo(paramVO);
    }

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 등록
     * @param String
     * @return
     */
    public String registCntntsInfoRetSeq(CntntsInfoVO paramVO) {
        
        String sitecntntsSeq = cntntsInfoDAO.selectCntntsInfoSeq();
        
        paramVO.setSitecntntsSeq(sitecntntsSeq);

        cntntsInfoDAO.registCntntsInfo(paramVO);
        
        return sitecntntsSeq;
    }

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 등록 후 기본권한 셋팅
     * @param String
     * @return
     * @throws Exception 
     */
    public int registCntntsInfoDefaultAuth(CntntsInfoVO paramVO) throws Exception {
        
        int result = 0;
        
        String sitecntntsSeq = registCntntsInfoRetSeq(paramVO);
        paramVO.setSitecntntsSeq(sitecntntsSeq);

        CntntsAuthVO setVO = new CntntsAuthVO();
        
        setVO.setSitecntntsSeq(sitecntntsSeq);
        setVO.setFrstRegisterId(paramVO.getFrstRegisterId());
        
        ModuleUploadFileVO vo = new ModuleUploadFileVO();
        vo.setSitecntntsSeq(sitecntntsSeq);
        vo.setLastUpdusrId(paramVO.getFrstRegisterId());
        if(paramVO.getSysmoduleSeq().equals("10000000003") || paramVO.getSysmoduleSeq().equals("10000000101")  || paramVO.getSysmoduleSeq().equals("10000000204")  || paramVO.getSysmoduleSeq().equals("10000000215")  )
        {
        List<ModuleUploadFileVO> fileList;
			try {
				fileList = moduleUploadFileMngrService.selectEstbsFileTyCodeList(vo);
			
	        for(int i = 0 ; i<fileList.size();i++){
	        	vo.setFileTyCode(fileList.get(i).getFileTyCode());
	        	vo.setMdPermAt("Y");
	        	moduleUploadFileMngrService.modifyFileBassEstbsInfo(vo);
	        }
			}catch(NullPointerException e){
				log.error("NullPointerException",e);
		   	}catch(NumberFormatException e){
		   		log.error("NumberFormatException",e);
		   	}catch(IllegalFormatException e){
		   		log.error("IllegalFormatException",e);
		   	}catch(ArrayIndexOutOfBoundsException e){
		   		log.error("ArrayIndexOutOfBoundsException",e);
		   	} 
        }
        
        if(paramVO.getSysmoduleSeq().equals("10000000237") )
        {
        	try {
        		//이미지 게시판은 이미지 첨부파일만 기본적용 2021.06.14 조원권
        		vo.setFileTyCode("SC00000063");
        		vo.setMdPermAt("Y");
        		moduleUploadFileMngrService.modifyFileBassEstbsInfo(vo);
        		
        	}catch(NullPointerException e){
        		log.error("NullPointerException",e);
        	}catch(NumberFormatException e){
        		log.error("NumberFormatException",e);
        	}catch(IllegalFormatException e){
        		log.error("IllegalFormatException",e);
        	}catch(ArrayIndexOutOfBoundsException e){
        		log.error("ArrayIndexOutOfBoundsException",e);
        	} 
        }

        // 기본 권한그룹
        String usrgroupSeq = Globals.BASE_SITE_USRGROUPSEQ;
        // 기본 권한그룹 - 설정권한
        String usrgroupAuthSe = Globals.BASE_SITE_USRGROUPSEQ_AUTHORSE;

        String[] usrgroupSeqArr = usrgroupSeq.split(":");
        String[] usrgroupAuthSeArr = usrgroupAuthSe.split(":");
        
        for (int i=0; i<usrgroupSeqArr.length; i++) {
            setVO.setUsrgroupSeq(usrgroupSeqArr[i]);
            setVO.setAuthorSe(usrgroupAuthSeArr[i]);
            
            
            int dupChk = cntntsAuthDAO.selectCntntsAuthChk(setVO);
            if(dupChk >0) {
            	result = 	cntntsAuthDAO.updateCntntsAuth(setVO);	
            }else {
            	result =   cntntsAuthDAO.registCntntsAuthInfo(setVO);
            }
            
         //   result = cntntsAuthDAO.registCntntsAuth(setVO);
        }
        
        return result;
    }
    
    public String registCntntsInfoDefaultAuthInit(CntntsInfoVO paramVO) throws Exception {
        
        int result = 0;
        
        String sitecntntsSeq = registCntntsInfoRetSeq(paramVO);
        paramVO.setSitecntntsSeq(sitecntntsSeq);

        CntntsAuthVO setVO = new CntntsAuthVO();
        
        setVO.setSitecntntsSeq(sitecntntsSeq);
        setVO.setFrstRegisterId(paramVO.getFrstRegisterId());
        
        ModuleUploadFileVO vo = new ModuleUploadFileVO();
        vo.setSitecntntsSeq(sitecntntsSeq);
        vo.setLastUpdusrId(paramVO.getFrstRegisterId());
        if(paramVO.getSysmoduleSeq().equals("10000000003") || paramVO.getSysmoduleSeq().equals("10000000101")  || paramVO.getSysmoduleSeq().equals("10000000204")  || paramVO.getSysmoduleSeq().equals("10000000215")  )
        {
        List<ModuleUploadFileVO> fileList;
			try {
				fileList = moduleUploadFileMngrService.selectEstbsFileTyCodeList(vo);
			
	        for(int i = 0 ; i<fileList.size();i++){
	        	vo.setFileTyCode(fileList.get(i).getFileTyCode());
	        	vo.setMdPermAt("Y");
	        	moduleUploadFileMngrService.modifyFileBassEstbsInfo(vo);
	        }
			}catch(NullPointerException e){
				log.error("NullPointerException",e);
		   	}catch(NumberFormatException e){
		   		log.error("NumberFormatException",e);
		   	}catch(IllegalFormatException e){
		   		log.error("IllegalFormatException",e);
		   	}catch(ArrayIndexOutOfBoundsException e){
		   		log.error("ArrayIndexOutOfBoundsException",e);
		   	} 
        }
        
        if(paramVO.getSysmoduleSeq().equals("10000000237") )
        {
        	try {
        		//이미지 게시판은 이미지 첨부파일만 기본적용 2021.06.14 조원권
        		vo.setFileTyCode("SC00000063");
        		vo.setMdPermAt("Y");
        		moduleUploadFileMngrService.modifyFileBassEstbsInfo(vo);
        		
        	}catch(NullPointerException e){
        		log.error("NullPointerException",e);
        	}catch(NumberFormatException e){
        		log.error("NumberFormatException",e);
        	}catch(IllegalFormatException e){
        		log.error("IllegalFormatException",e);
        	}catch(ArrayIndexOutOfBoundsException e){
        		log.error("ArrayIndexOutOfBoundsException",e);
        	} 
        }

        // 기본 권한그룹
        String usrgroupSeq = Globals.BASE_SITE_USRGROUPSEQ;
        // 기본 권한그룹 - 설정권한
        String usrgroupAuthSe = Globals.BASE_SITE_USRGROUPSEQ_AUTHORSE;

        String[] usrgroupSeqArr = usrgroupSeq.split(":");
        String[] usrgroupAuthSeArr = usrgroupAuthSe.split(":");
        
        for (int i=0; i<usrgroupSeqArr.length; i++) {
            setVO.setUsrgroupSeq(usrgroupSeqArr[i]);
            setVO.setAuthorSe(usrgroupAuthSeArr[i]);
            
            
            int dupChk = cntntsAuthDAO.selectCntntsAuthChk(setVO);
            if(dupChk >0) {
            	result = 	cntntsAuthDAO.updateCntntsAuth(setVO);	
            }else {
            	result =   cntntsAuthDAO.registCntntsAuthInfo(setVO);
            }
            
         //   result = cntntsAuthDAO.registCntntsAuth(setVO);
        }
        
        return sitecntntsSeq;
    }
 

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 삭제
     * @param String
     * @return
     */
    public int deleteCntntsInfo(CntntsInfoVO paramVO) {
        
        return cntntsInfoDAO.deleteCntntsInfo(paramVO);   
    }

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 삭제
     * @param String
     * @return
     */
    public int deleteCntntsInfoArr(CntntsInfoVO paramVO) {
    	
    	int resultInt = 1;
        
        try {
            String[] chkDelArr = paramVO.getChkDelArr();
            
            if (chkDelArr != null && chkDelArr.length > 0) {
                
                for (int i=0; i<chkDelArr.length; i++) {
                    
                    String sitecntntsSeq = StringUtils.defaultString(chkDelArr[i]);
                    
                    if (!"".equals(sitecntntsSeq)) {
                        paramVO.setSitecntntsSeq(chkDelArr[i]);
                        deleteCntntsInfo(paramVO);   
                    }
                }
            }
        }catch(NullPointerException e){			
			resultInt = 0;
	   	}catch(NumberFormatException e){
	   		resultInt = 0;
	   	}catch(IllegalFormatException e){
	   		resultInt = 0;
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		resultInt = 0;
	   	}

        return resultInt;
    }

    /**
     * ㅁ 컨텐츠정보 - 컨텐츠 API 제공 목록
     * @param String
     * @return
     */
    public List<CntntsInfoVO> selectCntntsApiProvdList(CntntsInfoVO paramVO) {
        
        return cntntsInfoDAO.selectCntntsApiProvdList(paramVO);   
    }
    
    /**
	 * ㅁ 컨텐츠정보 - 컨텐츠 시퀀스 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectSitecntntsSeq() {
    	return cntntsInfoDAO.selectSitecntntsSeq();
    }
    
    /**
     * ㅁ 컨텐츠정보 - 모듈 초기 컨텐츠 정보 등록
     * @param String
     * @return
     */
    public void registCntntsInfoInit(CntntsInfoVO paramVO) {
        cntntsInfoDAO.registCntntsInfoInit(paramVO);
    }
    
    /**
     * ㅁ 컨텐츠정보 - 모듈 초기 컨텐츠 정보 등록
     * @param String
     * @return
     */
    public void modifyCntntsInfoInit(CntntsInfoVO paramVO) {
        cntntsInfoDAO.modifyCntntsInfoInit(paramVO);
    }

    public CntntsInfoVO selectCntntsBassInfo(CntntsInfoVO paramVO) {
        return cntntsInfoDAO.selectCntntsBassInfo(paramVO);
    }
    
    
    /* 이하 컨텐츠 대시보드용 */
    public List<CntntsInfoVO> selectCntntsDashboardCnt(CntntsInfoVO paramVO){
    	return cntntsInfoDAO.selectCntntsDashboardCnt(paramVO);
    }
    
	public List<CntntsInfoVO> selectBbsInfoList(CntntsInfoVO paramVO) { 
		return cntntsInfoDAO.selectBbsInfoList(paramVO);
	}
	
	
	/**
	 * atchFileId 로 게시판에서 사용중인지 체크
	 * @param atchFileId
	 * @return
	 */
	public CntntsInfoVO selectBbsAtchFileIdCheck(String atchFileId) {
		return cntntsInfoDAO.selectBbsAtchFileIdCheck(atchFileId);
	}
    
}

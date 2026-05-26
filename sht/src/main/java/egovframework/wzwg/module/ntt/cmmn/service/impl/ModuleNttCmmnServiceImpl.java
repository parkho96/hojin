package egovframework.wzwg.module.ntt.cmmn.service.impl;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.cmm.authCtrl.service.AuthCtrlService;
import egovframework.wzwg.cmm.authCtrl.service.AuthCtrlVO;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.impl.ModuleBbsCmmnDAO;
import egovframework.wzwg.module.cmnt.service.CmntMenuAuthService;
import egovframework.wzwg.module.cmnt.service.CmntMenuAuthVO;
import egovframework.wzwg.module.cmnt.service.CmntUserService;
import egovframework.wzwg.module.cmnt.service.CmntUserVO;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.module.tag.service.ModuleNttTagService;
import egovframework.wzwg.module.ntt.mvp.service.ModuleNttMvpVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoService;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;



@Service("ModuleNttCmmnService")
public class ModuleNttCmmnServiceImpl extends EgovAbstractServiceImpl implements ModuleNttCmmnService {

	
	@Resource(name="ModuleNttCmmnDAO")
    protected ModuleNttCmmnDAO nttCmmnDAO;
	
	@Resource(name="ModuleBbsCmmnDAO")
    protected ModuleBbsCmmnDAO bbsCmmnDAO;
	
	@Resource(name="ModuleNttTagService")
    protected ModuleNttTagService nttTagService;

    @Resource(name="ModuleUploadFileService")
	public ModuleUploadFileService fileService;
	
    @Resource(name="AuthCtrlService")
    protected AuthCtrlService authCtrlService;
    
    @Resource(name="CntntsAuthService")
    protected CntntsAuthService cntntsAuthService;
    
    @Resource(name="CmntUserService")
    protected CmntUserService cmntUserService;
    
    @Resource(name="SiteCmntInfoService")
    protected SiteCmntInfoService siteCmntInfoService;
    
    @Resource(name="CmntMenuAuthService")
    protected CmntMenuAuthService cmntMenuAuthService;
    
	
	public void modifyNttInqireCnt(ModuleNttVO nttVO) throws Exception {
		nttCmmnDAO.modifyNttInqireCnt(nttVO);
	}
	
	public ModuleNttVO selectNttDetail(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectNttDetail(nttVO);
	}
	
	public String selectNttNtcrId(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectNttNtcrId(nttVO);
	}
	
	public String selectNttMvpNtcrId(ModuleNttMvpVO nttVO) throws Exception {
		return nttCmmnDAO.selectNttMvpNtcrId(nttVO);
	}	
	
	public String selectNttFormCn(String bbsSeq) throws Exception {
		return nttCmmnDAO.selectNttFormCn(bbsSeq);
	}
	
	public String selectNextNttSeq(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectNextNttSeq(nttVO);
	}
	
	public Integer registNttInfo(ModuleNttVO nttVO) throws Exception {
		
		int result = 0;
		
		result = nttCmmnDAO.registNttInfo(nttVO);
		
		/*String tagArr = StringUtils.defaultString(nttVO.getTagArr());
		
		if(!"".equals(tagArr)){
			ModuleNttTagVO tagVO = new ModuleNttTagVO();
			tagVO.setTagArr(tagArr.split(","));
			tagVO.setSiteSeq(nttVO.getSiteSeq());
			tagVO.setUsrSeq(nttVO.getUsrSeq());
			tagVO.setNttSeq(nttVO.getNttSeq());
			tagVO.setFrstRegisterId(nttVO.getNtcrId());
			
			nttTagService.registNttTag(tagVO);
		}*/
		
		return result;
	}
	
	public String selectNextTmprnttSeq() throws Exception {
		return nttCmmnDAO.selectNextTmprnttSeq();
	}
	
	public Integer registTmprnttInfo(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.registTmprnttInfo(nttVO);
	}
	
	public Integer modifyTmprnttInfo(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.modifyTmprnttInfo(nttVO);
	}
	
	public int deleteTmprnttInfo(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.deleteTmprnttInfo(nttVO);
	}
	
	public List<ModuleNttVO> selectTmprnttList(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectTmprnttList(nttVO);
	}
	
	public Integer selectTmprnttListTotCnt(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectTmprnttListTotCnt(nttVO);
	}
	
	public ModuleNttVO selectTmprnttDetail(String searchTmprnttSeq) throws Exception {
		return nttCmmnDAO.selectTmprnttDetail(searchTmprnttSeq);
	}
	
	public Integer modifyNttInfo(ModuleNttVO nttVO) throws Exception {
		
		/*String tagArr = StringUtils.defaultString(nttVO.getTagArr());
		String tmpTagArr = StringUtils.defaultString(nttVO.getTmpTagArr());
		
		if(!"".equals(tagArr)){
			ModuleNttTagVO tagVO = new ModuleNttTagVO();
			tagVO.setTagArr(tagArr.split(","));
			tagVO.setTmpTagArr(tmpTagArr.split(","));
			tagVO.setSiteSeq(nttVO.getSiteSeq());
			tagVO.setUsrSeq(nttVO.getUsrSeq());
			tagVO.setNttSeq(nttVO.getNttSeq());
			
			nttTagService.modifyNttTag(tagVO);
		}*/
		
		return nttCmmnDAO.modifyNttInfo(nttVO);
	}
	
	public Integer deleteNttInfo(ModuleNttVO nttVO) throws Exception {
		
		if(nttVO.getAtchFileId() != null){
			
			ModuleUploadFileVO fvo = new ModuleUploadFileVO();
			
			fvo.setAtchFileId(nttVO.getAtchFileId());
			fileService.deleteFileInf(fvo);
		}
		
		return nttCmmnDAO.deleteNttInfo(nttVO);
	}
	
	public Integer deleteCheckNttInfo(ModuleNttVO nttVO) throws Exception {
		
		String checkNttSeq = StringUtils.defaultString(nttVO.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = nttVO.getCheckNttSeq().substring(0, nttVO.getCheckNttSeq().length()-1);
			nttVO.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttCmmnDAO.deleteNttInfo(nttVO);
	}
	
	public int modifyCheckNttSubospec(ModuleNttVO nttVO) throws Exception {
		
		String checkNttSeq = StringUtils.defaultString(nttVO.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = nttVO.getCheckNttSeq().substring(0, nttVO.getCheckNttSeq().length()-1);
			nttVO.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttCmmnDAO.modifyCheckNttSubospec(nttVO);
	}
	
	public List<ModuleNttVO> selectNttMvmnBbsList(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectNttMvmnBbsList(nttVO);
	}
	
	public Integer mvmnNtt(ModuleNttVO nttVO) throws Exception {
		String checkNttSeq = StringUtils.defaultString(nttVO.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = nttVO.getCheckNttSeq().substring(0, nttVO.getCheckNttSeq().length()-1);
			nttVO.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttCmmnDAO.mvmnNtt(nttVO);
	}
	
	public List<ModuleNttVO> selectNttLike(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectNttLike(nttVO);
	}
	
	public Integer registNttLike(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.registNttLike(nttVO);
	}
	
	public Integer deleteNttLikeCancl(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.deleteNttLikeCancl(nttVO);
	}
	
	public Integer registNttSttemnt(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.registNttSttemnt(nttVO);
	}
	
	public Integer modifyNttRecycle(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.modifyNttRecycle(nttVO);
	}
	
	public Integer modifyCheckNttRecycle(ModuleNttVO nttVO) throws Exception {
		
		String checkNttSeq = StringUtils.defaultString(nttVO.getCheckNttSeq());
		
		if(!"".equals(checkNttSeq)){
			checkNttSeq = nttVO.getCheckNttSeq().substring(0, nttVO.getCheckNttSeq().length()-1);
			nttVO.setDynamicArr(checkNttSeq.split(","));
		}
		
		return nttCmmnDAO.modifyNttRecycle(nttVO);
	}	
	
	public int deleteSiteNtt(ModuleNttVO nttVO) throws Exception {

		int resultValue = 0;
		
		if(!nttVO.getDelSe().equals("ALL")) {
			
			String checkNttSeq = StringUtils.defaultString(nttVO.getCheckNttSeq());
			
			if(!"".equals(checkNttSeq)){
				checkNttSeq = nttVO.getCheckNttSeq().substring(0, nttVO.getCheckNttSeq().length()-1);
				nttVO.setDynamicArr(checkNttSeq.split(","));
			}
			
		}		

		resultValue = nttCmmnDAO.deleteSiteFileDetail(nttVO);

		resultValue = nttCmmnDAO.deleteSiteFile(nttVO);
		
		resultValue = nttCmmnDAO.deleteSiteNttLike(nttVO);
		
		resultValue = nttCmmnDAO.deleteSiteNttAnswer(nttVO);
		
		resultValue = nttCmmnDAO.deleteSiteNttAdiInfo(nttVO);

		resultValue = nttCmmnDAO.deleteSiteNtt(nttVO);

		resultValue = 1;

		return resultValue;
	}	
	
	public CntntsAuthVO selectCntntsAuthForNtt(HttpServletRequest request, String menuSeq) throws Exception {
		
		AuthCtrlVO authCtrlVO = new AuthCtrlVO();
		authCtrlVO.setMenuSeq(menuSeq);
		authCtrlVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		String sitecntntsSeq = authCtrlService.selectMenuSeqBySiteCntntsSeq(authCtrlVO);
		
		// 게시판 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setSitecntntsSeq(sitecntntsSeq);
		cntntsAuthVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
	
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}
	
		return cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);	
	}
	
	public boolean sessionMngrAuthForNtt(HttpServletRequest request) throws Exception {
		
		boolean retAuth = true;
		
		boolean sysadminAt 	= CmmSessionUtil.getSessionSysMngrAt(request);
		boolean sadminAt 	= CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT");
		boolean nadminAt 	= CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT");
		boolean cadminAt 	= CmmSessionUtil.getSessionBooleanValue(request, "CNTNTS_ADMIN_AT");
		
		if(!sysadminAt && !sadminAt && !nadminAt && !cadminAt){
			retAuth = false;
		}
		
		return retAuth;
	}
	
	/**
	 * ㅁ 공지 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttNoticeList(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectNttNoticeList(nttVO);
	}
	
	/**
	 * ㅁ 공지 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttNotice(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.modifyNttNotice(nttVO);
	}
	
	/**
	 * 일반 게시글 본인소유 확인
	 * @param request
	 * @param nttVO
	 * @return
	 * @throws Exception
	 */
	public boolean checkOwnerPost(HttpServletRequest request, ModuleNttVO nttVO) throws Exception{
		
		CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
		
		boolean sysadminAt 	= CmmSessionUtil.getSessionSysMngrAt(request);
		boolean sadminAt 	= CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT");
		boolean nadminAt 	= CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT");

		boolean mngrAt = sysadminAt || sadminAt || nadminAt;
		
		boolean cmntMngrChk = false;
		
		String ntcrId = selectNttNtcrId(nttVO);
		boolean ntcrIdChk = ntcrId.equals(loginVO.getUserId());
		
		
		String referUrl = StringUtils.defaultString(request.getHeader("REFERER"));
		
		if (referUrl.indexOf("/module/cmnt/") > -1) {
            
            CmntUserVO cmntUserVO = new CmntUserVO();
            
            cmntUserVO.setSiteSeq(nttVO.getSiteSeq());
            cmntUserVO.setCmntSeq(CmmSessionUtil.getSessionValue(request, "cmntSeq"));
            if(loginVO == null || loginVO.getUsrSeq() == null){
                cmntUserVO.setUsrSeq("0");
            }else{
                cmntUserVO.setUsrSeq(loginVO.getUsrSeq());
            }
            
            
            
            //커뮤니티 관리자 확인 
        	SiteCmntInfoVO cmntInfoVO = new SiteCmntInfoVO();
        	cmntInfoVO.setSiteSeq(nttVO.getSiteSeq());
        	cmntInfoVO.setCmntSeq(cmntUserVO.getCmntSeq());
        	
        	SiteCmntInfoVO	cmntResult = siteCmntInfoService.selectSiteCmntInfo(cmntInfoVO);
            String cmntMngrSeq = "";
            
            if(cmntResult != null) {
            	cmntMngrSeq = cmntResult.getCmntMngrSeq();
            }
            
            if(loginVO != null && cmntMngrSeq != null && cmntMngrSeq.equals(loginVO.getUsrSeq())) {
            	 cmntMngrChk = true;
            }
        	
            boolean authorChk = false;
            
            if(!cmntMngrChk && !mngrAt) {
            	// 커뮤니티에서 접속자 정보 
            	cmntUserVO = cmntUserService.selectCmntUser(cmntUserVO);
            
            	CmntMenuAuthVO setVO = new CmntMenuAuthVO();
            	setVO.setSiteSeq(nttVO.getSiteSeq());
            	setVO.setBbsSeq(nttVO.getBbsSeq());
            	setVO.setCmntSeq(cmntUserVO.getCmntSeq());
            	setVO.setApprvlCode(cmntUserVO.getApprvlCode());
            
            	List<CmntMenuAuthVO> cmntMenuAuthList=  cmntMenuAuthService.selectCmntMenuAuthForBbsSeqDetail(setVO);
            	if (cmntMenuAuthList != null) {
            		for (int i=0; i<cmntMenuAuthList.size(); i++) {
                    CmntMenuAuthVO getVO = (CmntMenuAuthVO)cmntMenuAuthList.get(i);
                    	if ("W".equals(StringUtils.defaultString(getVO.getAuthSe()))) {
                    		authorChk = true;
                    	}
            		}
            	}
            
            }
            
            //관리자거나 커뮤니티관리자 이면 패스
            if(mngrAt || cmntMngrChk) {
            	return true;
            }
            
            //쓰기 권한이 있으나 본인글이 아니면 fail
            if(authorChk && !ntcrIdChk) {
            	return false;
            }
            
        } else {
        	CntntsAuthVO nttAuthVO = selectCntntsAuthForNtt(request, nttVO.getMenuSeq());
            
        	AuthCtrlVO authCtrlVO = new AuthCtrlVO();
        	authCtrlVO.setSitecntntsSeq(nttVO.getSitecntntsSeq());
        	authCtrlVO.setUsrSeq(loginVO.getUsrSeq());
        	boolean chargerAt = authCtrlService.selectCntntsChrgCnt(authCtrlVO) > 0;
        	
        	
            //관리자 거나 게시판 담당자라면 패스
        	if(mngrAt || chargerAt) {
        		return true;
        	}
        	
        	//쓰기 권한이 있으나 본인글이 아니라면 fail
        	if("W".equals(nttAuthVO.getAuthorSe()) && !ntcrIdChk) {
        		return false;
        	}
        	
        }
		
		return true;
	}
	
	
	/**
	 * 동영상게시판 게시글 본인소유 확인
	 * @param request
	 * @param nttVO
	 * @return
	 * @throws Exception
	 */
	public boolean checkOwnerMvpPost(HttpServletRequest request, ModuleNttMvpVO nttMvpVO) throws Exception{
		
		CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
		
		boolean sysadminAt 	= CmmSessionUtil.getSessionSysMngrAt(request);
		boolean sadminAt 	= CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT");
		boolean nadminAt 	= CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT");

		boolean mngrAt = sysadminAt || sadminAt || nadminAt;
		
		boolean cmntMngrChk = false;
		
		String ntcrId = selectNttMvpNtcrId(nttMvpVO);
		boolean ntcrIdChk = ntcrId.equals(loginVO.getUserId());
		
		
		String referUrl = StringUtils.defaultString(request.getHeader("REFERER"));
		
		if (referUrl.indexOf("/module/cmnt/") > -1) {
            
            CmntUserVO cmntUserVO = new CmntUserVO();
            
            cmntUserVO.setSiteSeq(nttMvpVO.getSiteSeq());
            cmntUserVO.setCmntSeq(CmmSessionUtil.getSessionValue(request, "cmntSeq"));
            if(loginVO == null || loginVO.getUsrSeq() == null){
                cmntUserVO.setUsrSeq("0");
            }else{
                cmntUserVO.setUsrSeq(loginVO.getUsrSeq());
            }
            
            
            
            //커뮤니티 관리자 확인 
        	SiteCmntInfoVO cmntInfoVO = new SiteCmntInfoVO();
        	cmntInfoVO.setSiteSeq(nttMvpVO.getSiteSeq());
        	cmntInfoVO.setCmntSeq(cmntUserVO.getCmntSeq());
        	
        	SiteCmntInfoVO	cmntResult = siteCmntInfoService.selectSiteCmntInfo(cmntInfoVO);
            String cmntMngrSeq = "";
            
            if(cmntResult != null) {
            	cmntMngrSeq = cmntResult.getCmntMngrSeq();
            }
            
            if(loginVO != null && cmntMngrSeq != null && cmntMngrSeq.equals(loginVO.getUsrSeq())) {
            	 cmntMngrChk = true;
            }
        	
            boolean authorChk = false;
            
            if(!cmntMngrChk && !mngrAt) {
            	// 커뮤니티에서 접속자 정보 
            	cmntUserVO = cmntUserService.selectCmntUser(cmntUserVO);
            
            	CmntMenuAuthVO setVO = new CmntMenuAuthVO();
            	setVO.setSiteSeq(nttMvpVO.getSiteSeq());
            	setVO.setBbsSeq(nttMvpVO.getBbsSeq());
            	setVO.setCmntSeq(cmntUserVO.getCmntSeq());
            	setVO.setApprvlCode(cmntUserVO.getApprvlCode());
            
            	List<CmntMenuAuthVO> cmntMenuAuthList=  cmntMenuAuthService.selectCmntMenuAuthForBbsSeqDetail(setVO);
            	if (cmntMenuAuthList != null) {
            		for (int i=0; i<cmntMenuAuthList.size(); i++) {
                    CmntMenuAuthVO getVO = (CmntMenuAuthVO)cmntMenuAuthList.get(i);
                    	if ("W".equals(StringUtils.defaultString(getVO.getAuthSe()))) {
                    		authorChk = true;
                    	}
            		}
            	}
            
            }
            
            //관리자거나 커뮤니티관리자 이면 패스
            if(mngrAt || cmntMngrChk) {
            	return true;
            }
            
            //쓰기 권한이 있으나 본인글이 아니면 fail
            if(authorChk && !ntcrIdChk) {
            	return false;
            }
            
        } else {
        	CntntsAuthVO nttAuthVO = selectCntntsAuthForNtt(request, nttMvpVO.getMenuSeq());
            
        	AuthCtrlVO authCtrlVO = new AuthCtrlVO();
        	authCtrlVO.setSitecntntsSeq(nttMvpVO.getSitecntntsSeq());
        	authCtrlVO.setUsrSeq(loginVO.getUsrSeq());
        	boolean chargerAt = authCtrlService.selectCntntsChrgCnt(authCtrlVO) > 0;
        	
        	
            //관리자 거나 게시판 담당자라면 패스
        	if(mngrAt || chargerAt) {
        		return true;
        	}
        	
        	//쓰기 권한이 있으나 본인글이 아니라면 fail
        	if("W".equals(nttAuthVO.getAuthorSe()) && !ntcrIdChk) {
        		return false;
        	}
        	
        }
		
		return true;
	}
	
	
	/**
	 * 첨부파일 아이디로 게시물상세 조회
	 * @param nttVO
	 * @return
	 * @throws Exception
	 */
	public ModuleNttVO selectNttDetailByAtchFileId(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectNttDetailByAtchFileId(nttVO);
	}
	
	/**
	 * 첨부파일 아이디로 게시물 비밀글 상태 조회
	 * @param nttVO
	 * @return
	 * @throws Exception
	 */
	public ModuleNttVO selectNttSecretAtByAtchFileId(ModuleNttVO nttVO) throws Exception {
		return nttCmmnDAO.selectNttSecretAtByAtchFileId(nttVO);
	}
}

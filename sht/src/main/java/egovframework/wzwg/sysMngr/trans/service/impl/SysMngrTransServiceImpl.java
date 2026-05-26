package egovframework.wzwg.sysMngr.trans.service.impl;

import java.io.File;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.sysMngr.trans.service.SysMngrTransService;
import egovframework.wzwg.sysMngr.trans.service.SysMngrTransVO;

@Service("SysMngrTransService")
public class SysMngrTransServiceImpl extends EgovAbstractServiceImpl implements SysMngrTransService {
	
	@Resource(name="SysMngrTransDAO")
	SysMngrTransDAO sysMngrTransDAO;
	

    @Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;

	public int registUnityMdntt(SysMngrTransVO sysMngrTransVO) throws Exception {
		String bbsSeq =	sysMngrTransDAO.selectTransMappingBbsSeq(sysMngrTransVO);
		sysMngrTransVO.setBbsSeq(bbsSeq);
		int result=0;
		String nttSeq = sysMngrTransDAO.selectTransMappingNttSeq(sysMngrTransVO);
		if(nttSeq == null || nttSeq.equals("")) {
		result=sysMngrTransDAO.registUnityMdntt(sysMngrTransVO);	 
		result=sysMngrTransDAO.registUnityMdnttAdiinfo(sysMngrTransVO);
		sysMngrTransVO.setNttId(sysMngrTransVO.getNttSeq());
		sysMngrTransVO.setNttSeq(String.valueOf(Integer.parseInt(sysMngrTransVO.getStartSeq())+Integer.parseInt(sysMngrTransVO.getNttSeq())));
		sysMngrTransDAO.insertNttTransMapping(sysMngrTransVO);
		}else {
			sysMngrTransVO.setNttSeq(nttSeq);
			result=sysMngrTransDAO.updateUnityMdntt(sysMngrTransVO);	 
			result=sysMngrTransDAO.updateUnityMdnttAdiinfo(sysMngrTransVO);
		}
		
		return result;
	} 
 
 
	public int registUnityBoard(SysMngrTransVO sysMngrTransVO) throws Exception {
		String listScrinCode ="";
		String sysmoduleSeq ="";
		if(sysMngrTransVO.getBoardType().equals("ntt")) {
			sysmoduleSeq ="10000000003";
			listScrinCode = "L";
		}else if(sysMngrTransVO.getBoardType().equals("album")) {
			sysmoduleSeq ="10000000237";
			listScrinCode = "I";
		}else if(sysMngrTransVO.getBoardType().equals("event")) {
			sysmoduleSeq ="10000000237";
			listScrinCode = "E";
		}else if(sysMngrTransVO.getBoardType().equals("faq")) {
			sysmoduleSeq ="10000000101";
			listScrinCode = "";
		}
		
		int result=0;
		sysMngrTransVO.setSysmoduleSeq(sysmoduleSeq);
		sysMngrTransVO.setListScrinCode(listScrinCode);
	String bbsSeq = sysMngrTransDAO.selectTransMappingBbsSeq(sysMngrTransVO);
	if(bbsSeq == null || bbsSeq.equals("")) {
		System.out.println("sysMngrTransVO : "+sysMngrTransVO.getSiteSeq());
		bbsSeq = sysMngrTransDAO.selectUnityBoardSeq(sysMngrTransVO);
		sysMngrTransVO.setBbsSeq(bbsSeq); 
		result = sysMngrTransDAO.registUnityBoard(sysMngrTransVO);
		sysMngrTransVO.setSitecntntsSeq(sysMngrTransDAO.selectSitecntntsSeq(sysMngrTransVO));
		result = sysMngrTransDAO.registUnitySiteCntnts(sysMngrTransVO);
		sysMngrTransDAO.insertTransMapping(sysMngrTransVO);
	}else {
		sysMngrTransVO.setBbsSeq(bbsSeq);  
		result =  sysMngrTransDAO.updateUnityBoard(sysMngrTransVO);
		String sitecntntsSeq =  sysMngrTransDAO.selectTransMappingSitecntntsSeq(sysMngrTransVO);
		sysMngrTransVO.setSitecntntsSeq(sitecntntsSeq);
		result = sysMngrTransDAO.updateUnitySiteCntnts(sysMngrTransVO);
	}
	
		return result;
	} 
	
	
	public int registUnityAtchMdntt(SysMngrTransVO sysMngrTransVO) throws Exception {
		int result=0;
		if(sysMngrTransVO.getUseAt().equals("Y")) {
		int startSeq = 10000000;
		int nttSeq = startSeq + Integer.parseInt(sysMngrTransVO.getNttSeq());
		sysMngrTransVO.setNttSeq(String.valueOf(nttSeq));  
		//String atchFileId =sysMngrTransDAO.selectTransMdnttAtchFileId(sysMngrTransVO); 
		File saveDir = new File(sysMngrTransVO.getFileStreCours());
		if(!saveDir.exists()) {
			saveDir.mkdirs();
		}
		//if(atchFileId==null||atchFileId.equals("") || atchFileId.equals("0") ) {
		String atchFileId = sysMngrTransDAO.getNextAtchFileId(sysMngrTransVO);
			sysMngrTransVO.setAtchFileId(atchFileId);
			sysMngrTransVO.setFileSn("0");
			result=sysMngrTransDAO.insertFileMaster(sysMngrTransVO);
			result=sysMngrTransDAO.insertFileDetail(sysMngrTransVO);
			result=sysMngrTransDAO.updateAtchFileIdMdntt(sysMngrTransVO);
		//}else {
		//	sysMngrTransVO.setAtchFileId(atchFileId);
		//	String fileSn =sysMngrTransDAO.selectTranstAtchFileSn(sysMngrTransVO);
		//	sysMngrTransVO.setFileSn(fileSn);
		//result=sysMngrTransDAO.insertFileDetail(sysMngrTransVO);
		//}
		}
	  
		return result;
	} 
 
	
	
}

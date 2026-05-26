package egovframework.wzwg.sysMngr.trans.service;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SysMngrTransVO extends ComDefaultVO{
	private String siteSeq;
	private String boardId ;
	private String startSeq;
	private String boardPostId;
	private String bbsSeq;
	private String nttSj;
	private String nttCn;
	private String inqireCnt;
	private String useAt;
	private String frstRegistPnttm;
	private String lastUpdtPnttm; 
	private String noticeAt;
	private String secretAt;
	private String password;
	private String sysmoduleSeq;
	private String bbsNm;
	private String listScrinCode;
	private String boardType;
	private String ntcrNm;
	private String parntsNttSeq;
	private String nttSeq;
	private String atchFileId;
	
	private String fileSn;
	private String fileStreCours;
	private String streFileNm;
	private String orignlFileNm;
	private String fileExtsn;
	private String fileMg;
	private String fileDc;
	private String thumbStreCours;
	private String thumbFileNm;
	
	private String fileName;
	private String filePath;
	
	private String transFileTy;
	
	private String sitecntntsSeq;
	
	private String ntcrSeq;
	private String ntcrId;
	
	private String nttId;
	
}

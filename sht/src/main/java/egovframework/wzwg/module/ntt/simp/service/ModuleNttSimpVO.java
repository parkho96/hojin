package egovframework.wzwg.module.ntt.simp.service;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleNttSimpVO extends ModuleNttCmmnVO {

	
	private String siteSeq;

	private String sitecntntsSeq;
	
	private String simpnttSeq;
	
	private String bbsSeq;
	
	private String nttCn;
	
	private String atchFileId;
	
	private String ntcrId;
	
	private String ntcrNm;
	
	private String ntcrSeq;
	
	private String useAt;
	
	private String frstRegisterId;
	
	private String frstRegistPnttm;
	
	private String lastUpdusrId;
	
	private String lastUpdtPnttm;
	
	private String menuSeq;
	
	private String mngrAt;
	
	/* 선택된 게시물 seq */
	private String checkSimpnttSeq;
	
}

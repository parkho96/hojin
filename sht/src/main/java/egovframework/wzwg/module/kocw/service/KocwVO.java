package egovframework.wzwg.module.kocw.service;

import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class KocwVO extends SysModuleInfoVO {
    private String kocwSeq;
    
	private String siteSeq;
	private String sitecntntsSeq;
	private String sitecntntsNm;

    private String categoryId;
    private String from;
    private String to;

}

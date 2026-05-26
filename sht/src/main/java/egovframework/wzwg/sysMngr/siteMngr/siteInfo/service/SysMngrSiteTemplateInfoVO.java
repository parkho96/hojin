package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service;

import java.io.Serializable;

import egovframework.wzwg.sysMngr.screenMngr.template.service.SysMngrTemplateVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SysMngrSiteTemplateInfoVO extends SysMngrTemplateVO implements Serializable {
    
	private String[] templateSeqArr;
	private String[] templateChkArr;
	private String templateCnt;
	private String frstRegisterIp;
	private String ctgryCd;
	private String ctgryNm;
	private String chkTemplateSeqArr;
	private String chkTemplateChkArr;
	private String sysmngrAt;
	
	/* 
	public String[] getTemplateSeqArr() {
		if(templateSeqArr != null) {
				return Arrays.copyOf(templateSeqArr, templateSeqArr.length);
			}else {
				return null;
			} 
	}
	
	public void setTemplateSeqArr(String[] templateSeqArr) {
		if (templateSeqArr != null) {
			this.templateSeqArr = Arrays.copyOf(templateSeqArr, templateSeqArr.length);
		} else {
			this.templateSeqArr = null;
		}
	}
	
	public String[] getTemplateChkArr() {
		if(templateChkArr != null) {
				return Arrays.copyOf(templateChkArr, templateChkArr.length);
			}else {
				return null;
			} 
	}
	
	public void setTemplateChkArr(String[] templateChkArr) {
		if (templateChkArr != null) {
			this.templateChkArr = Arrays.copyOf(templateChkArr, templateChkArr.length);
		} else {
			this.templateChkArr = null;
		}
	}
	 */
}

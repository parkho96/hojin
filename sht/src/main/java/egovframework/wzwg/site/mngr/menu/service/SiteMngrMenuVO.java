package egovframework.wzwg.site.mngr.menu.service;

import java.util.Arrays;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SiteMngrMenuVO extends CntntsInfoVO {

	private String sysmoduleSeq;
	private String cntntsNm;
	private String frstRegisterId;
	private String frstRegistPnttm;
	private String lastUpdtPnttm;
	
	private String moduleId="";
	
	private String topMenuSe="";
	
	private String estbsinfoSeq;

	/** 메뉴 시퀀스 */
	private String menuestbsSeq          = "";
	
	private String backup;
	
	private String srhUsrGroupSeq;
	
	private String sysmngrAt;
	
	/** 메뉴 시퀀스 */
	private String mngrMenuSeq			= "";
	
	/** 메뉴명 */
	private String mngrMenuNm			= "";
	
	/** 영문메뉴명 */
	private String mngrMenuNmEng		= "";

	/** 상위메뉴번호 */
	private String upperMenuSeq  	= "";
	
	/** 상위메뉴명 */
	private String upperMenuNm  	= "";

	/** 메뉴레벨 */
	private String menuLv			= ""; 

	/** 메뉴타입코드 */
	private String menuTyCode		= "";

	/** 메뉴링크 URL */
	private String menuLinkUrl		= "";

	/** 메뉴설명 */
	private String menuDc			= ""; 
	
	/** 메뉴설명(영문) */
	private String menuDcEng		= "";

	/** 메뉴순서 */
	private String menuOrdr			= "";

	/** 사용여부 */
	private String useAt			= "";
	
	/** 사용자 ID */
	private String userId			= "";
		
	/** 사이트 SEQ */
	private String siteSeq			= "";

	/** 메뉴명경로 **/
	private String menuNmPath       = "";
	
	/** 메뉴SEQ경로 **/
	private String menuSeqPath      = "";
	
	private String menuDivision = "";
	
	private String mngrMenuDivision = "";

	private String[] resultArr;
	
	private String menuLinkSeq ="";
	
	private String cntntsSeq = "";
	
	private String[] mngrMenuSeqArry;

	private String mngrBkmkSeq = "";
	
	private String templateSeq;
	
	private String mngrSiteMenuSe;
	
	private String authgrpId;
	
	private String menuPrefix;
	
	private String usrSeq;
	
	private String mngrAuthAt;
	
	/** linkUrl */
	private String linkUrl		=	"";

	public String[] getResultArr() {
		if(resultArr != null) {
			return Arrays.copyOf(resultArr,resultArr.length);
		}else {
			return null;
		}
	}

	public void setResultArr(String[] resultArr) {
		if (resultArr != null) {
			this.resultArr = Arrays.copyOf(resultArr, resultArr.length);
		} else {
			this.resultArr = null;
		}
	}

	public String[] getMngrMenuSeqArry() {
		if(mngrMenuSeqArry != null) {
			return Arrays.copyOf(mngrMenuSeqArry, mngrMenuSeqArry.length);
		}else {
			return null;
		} 
	}

	public void setMngrMenuSeqArry(String[] mngrMenuSeqArry) {
		if (mngrMenuSeqArry != null) {
			this.mngrMenuSeqArry = Arrays.copyOf(mngrMenuSeqArry, mngrMenuSeqArry.length);
		} else {
			this.mngrMenuSeqArry = null;
		}
	}

}

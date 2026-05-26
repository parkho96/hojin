package egovframework.wzwg.site.mngr.menu.service;

import java.util.Arrays;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SiteMenuVO extends CntntsInfoVO {
	
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

	/** 메뉴 시퀀스 */
	private String menuSeq			= "";

	/** 메뉴명 */
	private String menuNm			= ""; 

	/** 상위메뉴번호 */
	private String upperMenuSeq  	= "";

	/** 메뉴레벨 */
	private String menuLv			= ""; 

	/** 메뉴타입코드 */
	private String menuTyCode		= "";

	/** 메뉴링크 URL */
	private String menuLinkUrl		= "";

	/** 메뉴설명 */
	private String menuDc			= ""; 

	/** 메뉴순서 */
	private String menuOrdr			= "";

	/** 메뉴이미지 사용여부 */
	private String menuImageUseAt 	= "";

	/** 메뉴 인 이미지경로 */
	private String menuInImagePath 	= "";

	/** 메뉴 오프 이미지경로 */
	private String menuOutImagePath	= "";

	/** 이미지 대체 텍스트 */
	private String imageReplcText	= "";

	/** 메뉴상태코드 */
	private String menuSttusCode	= "";

	/** 사용여부 */
	private String useAt			= "";

	/** 사용자 ID */
	private String userId			= "";

	/** 사이트 컨텐츠 SEQ */
	private String sitecntntsSeq	= "";

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

	private String writeAuthAt="";

	private String templateSeq;
	
	private String mngrSiteMenuSe;
	
	/** 관리자 서브페이지 페이지 URL */
	private String mngrPageUrl	= 	"";
	
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

}

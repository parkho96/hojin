package egovframework.wzwg.module.api.service;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleApiVO extends ComDefaultVO{

	/** API SEQ */
	private String apiSeq				=	"";
	
	/** 사이트 SEQ */
	private String siteSeq				=	"";

	/** API 구분 코드 */
	private String apiSeCode			=	"";
	
	/** API 구분 코드명 */
	private String apiSeCodeNm			=	"";
	
	/** API 명 */
	private String apiNm				=	"";
	
	/** API 키 */
	private String apiCrtfcKey			=	"";
	
	/** X좌표 */
	private String xCnts				=	"";
	
	/** Y좌표 */
	private String yCnts				=	"";
	
	/** 사이트 URL */
	private String siteUrl				=	"";
	
	/** 사용분류코드 */
	private String useClCode			=	"";
	
	/** 사용환경코드 */
	private String useEnvrnCode			=	"";
	
	/** 사용여부 */
	private String useAt				=	"";
	
	/** 사용자 SEQ */
	private String userId				=	"";
	
}

package egovframework.wzwg.module.schdul.service;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleSchdulCssVO extends ComDefaultVO{

	/** CSS시퀀스 */
	private String cssSeq = "";

	/** 모듈코드 */
	private String sysmoduleSeq = "";

	/** CSS명 */
	private String cssNm = "";

	/** CSS파일명 */
	private String cssFileNm = "";

	/** CSS경로 */
	private String cssPath = "";

	/** 미리보기경로 */
	private String prevewPath = "";

	/** 사용여부 */
	private String useAt = "";

	/** 최초등록자ID  */
	private String frstRegisterId = "";

	/** 최초등록시점 */
	private String frstRegistPnttm = "";

	/** 최종수정자ID */
	private String lastUpdusrId = "";

	/** 최송수정시점 */
	private String lastUpdtPnttm = "";
	
	/** 사용자 ID */
	private String userId = "";	
	
	/** 모듈명 */
	private String moduleNm = "";
	
	/** 모듈 CSS 사용가능여부 */
	private String cssProvdAt = "";

}

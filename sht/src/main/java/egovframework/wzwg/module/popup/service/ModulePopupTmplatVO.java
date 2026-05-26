package egovframework.wzwg.module.popup.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModulePopupTmplatVO {

	/** 템플릿ID */
	private String tmplatSeq = "";
	
	/** 템플릿 이름 */
	private String tmplatNm = "";
	
	/** 템플릿 파일명 */
	private String tmplatFile = "";

	/** 템플릿 경로 */
	private String tmplatCours = "";
	
	/** 템플릿 이미지 */
	private String tmplatImg = "";

}

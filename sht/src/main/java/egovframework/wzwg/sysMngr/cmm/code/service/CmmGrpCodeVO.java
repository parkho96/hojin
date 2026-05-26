package egovframework.wzwg.sysMngr.cmm.code.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class CmmGrpCodeVO implements Serializable {
	
	/** 코드 */
	private String grpcode			= 	"";
	
	/** 상위코드 */
	private String upperGrpcode		= 	"";
	
	/** 코드명 */
	private String grpcodeNm		= 	"";
	
	/** 코드약명 */
	private String grpcodeAbrvNm	=	"";
	
	/** 코드 */
	private String grpcodeLevel		= 	"";
	
	/** 코드설명 */
	private String grpcodeDc		=	"";
	
	/** 정렬순서 */
	private String sortOrdr			=	"";
	
	/** 사용여부 */
	private String useAt			=	"";

}

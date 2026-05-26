package egovframework.wzwg.module.drctns.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleDirectionsVO {
	
	/** 사이트시퀀스 */
	private String siteSeq			=	"";
	
	/** 도로명주소 */
	private String adresBass		=	"";
	
	/** 상세주소 */
	private String adresDetail		=	"";
	
	/** X좌표 */
	private String xCnts			=	"";
	
	/** Y좌표 */
	private String yCnts			=	"";

}

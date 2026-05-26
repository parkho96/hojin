package egovframework.wzwg.cmm.util.aop;

import org.apache.commons.lang.SystemUtils;
import org.apache.commons.lang.builder.ToStringStyle;

@SuppressWarnings("serial")
public class CustomToStringStyle extends ToStringStyle {

	public static final ToStringStyle MULTI_LINE_JSON_STYLE = new CustomToStringStyle();

	private CustomToStringStyle() {
		super();
		this.setUseClassName(false);
		this.setUseIdentityHashCode(false);
		this.setContentStart("{" + SystemUtils.LINE_SEPARATOR + "\t");
		this.setFieldNameValueSeparator(": ");
		this.setNullText("");
		if(SystemUtils.LINE_SEPARATOR.length() > 0) {
			this.setFieldSeparator("," + SystemUtils.LINE_SEPARATOR + "\t");
		}
		this.setContentEnd(SystemUtils.LINE_SEPARATOR + "}");
	}

	@Override
	public void append(StringBuffer buffer, String fieldName, Object value, Boolean fullDetail) {
		if (value != null ) {
			appendFieldStart(buffer, fieldName);
			appendInternal(buffer, fieldName, value, isFullDetail(fullDetail));
			appendFieldEnd(buffer, fieldName);
		}
	}

}

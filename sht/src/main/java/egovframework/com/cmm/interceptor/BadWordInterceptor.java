package egovframework.com.cmm.interceptor;

import java.util.Set;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import dggb.util.StringUtils;
import egovframework.com.cmm.EgovMessageSource;

/**
 * 인증여부 체크 인터셉터
 * 
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 * 
 *      <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성 
 *  2011.09.07  서준식          인증이 필요없는 URL을 패스하는 로직 추가
 *      </pre>
 */

@Component("badWordInterceptor")
public class BadWordInterceptor implements HandlerInterceptor {

	private static final Log LOG = LogFactory.getLog(BadWordInterceptor.class.getName());

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	private Set<String> permittedURL;

	public void setPermittedURL(Set<String> permittedURL) {
		this.permittedURL = permittedURL;
	}

	// 로그인 URL
	private Set<String> defaultLoginUrl;

	public void setDefaultLoginUrl(Set<String> defaultLoginUrl) {
		this.defaultLoginUrl = defaultLoginUrl;
	}

	// 메인 페이지 URL
	private Set<String> defaultIndexUrl;

	public void setDefaultIndexUrl(Set<String> defaultIndexUrl) {
		this.defaultIndexUrl = defaultIndexUrl;
	}

	/**
	 * 세션에 계정정보(LoginVO)가 있는지 여부로 인증 여부를 체크한다.
	 * 계정정보(LoginVO)가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		java.util.Enumeration params = request.getParameterNames();
		String badWord = egovMessageSource.getMessage("BAD_WORD");
		boolean bBadWord = false;
		while (params.hasMoreElements()) {
			String name = (String) params.nextElement();
			String value = StringUtils.nvl(request.getParameter(name), "");

			if (!value.equals("")) {
				for (int i = 0; i < badWord.split(",").length; i++) {
					if (value.indexOf(badWord.split(",")[i]) > -1) {
						bBadWord = true;
					}
					if (bBadWord) {
						break;
					}
				}
			}
			if (bBadWord) {
				break;
			}
		}
		if (bBadWord) {
			response.sendRedirect("/message/badWordError.do");
			return false;
		}
		return true;
	}

}

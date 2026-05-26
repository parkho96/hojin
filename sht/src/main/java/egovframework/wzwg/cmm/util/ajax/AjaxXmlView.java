package egovframework.wzwg.cmm.util.ajax;

import java.io.PrintWriter;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

public class AjaxXmlView extends AbstractView {

    @Override
	protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response)
	        throws Exception {
		PrintWriter writer = null;
		try {
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");

			writer = response.getWriter(); 
			writer.write((String) model.get("ajaxXml"));
			
		} finally {

			writer.close();
		}
	}
}
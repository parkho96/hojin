<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="com.fasterxml.jackson.core.JsonProcessingException"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page language="java" contentType="application/json; charset=utf-8" pageEncoding="utf-8"%>
<%
		ObjectMapper m = new ObjectMapper();
		
		try {
			out.println(m.writeValueAsString(request.getAttribute("ajaxResponse")));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;

	String v_jumin = request.getParameter("v_jumin");
	String v_name = request.getParameter("v_name");
	String m_no = request.getParameter("m_no");
	String v_time = request.getParameter("v_time");
	String v_area = request.getParameter("v_area");
	String v_confirm = request.getParameter("v_confirm");
	
	try{
		String sql = "insert into vote0726 values(?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, v_jumin);
		pstmt.setString(2, v_name);
		pstmt.setString(3, m_no);
		pstmt.setString(4, v_time);
		pstmt.setString(5, v_area);
		pstmt.setString(6, v_confirm);
		pstmt.executeUpdate();
		%>
		<script>
		alert("투표가 완료되었습니다.");
		location.href="index.jsp";
		</script>
		<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
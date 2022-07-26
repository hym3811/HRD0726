<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link rel = "stylesheet" href = "style.css">
<body>
<%@ include file = "header.jsp" %>
<%@ include file = "nav.jsp" %>
<section>
	<form name = "form" method = "post">
		<h3 id="title">후보자 조회</h3>
		<%@ include file = "DBConn.jsp" %>
		<%
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int cnt = 0;
			try{
				String sql = "select count(m_no) from member0726";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					cnt = rs.getInt(1);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			String[] m_no = new String[cnt];
			String[] m_name = new String[cnt];
			String[] p_code = new String[cnt];
			String[] p_school = new String[cnt];
			String[] m_jumin = new String[cnt];
			String[] m_city = new String[cnt];
			String[] p_tel = new String[cnt];
			try{
				String sql = "select m_no,m_name,a.p_code,p_school,m_jumin,m_city,p_tel1,p_tel2,p_tel3 from member0726 a join party0726 b on a.p_code=b.p_code";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				int count = 0;
				while(rs.next()){
					m_no[count] = rs.getString(1);
					m_name[count] = rs.getString(2);
					p_code[count] = rs.getString(3);
					if(rs.getString(4).equals("1")){
						p_school[count] = "고졸";
					}else if(rs.getString(4).equals("2")){
						p_school[count] = "학사";
					}else if(rs.getString(4).equals("3")){
						p_school[count] = "석사";
					}
					m_jumin[count] = rs.getString(5);
					m_city[count] = rs.getString(6);
					p_tel[count] = rs.getString(7)+"-"+rs.getString(8)+"-"+rs.getString(9);
					count++;
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		%>
		<p>총 <%=cnt %>명의 후보자가 있습니다.</p>
		<hr>
		<table border=2>
			<tr>
				<th>후보번호</th>
				<th>성명</th>
				<th>소속정당</th>
				<th>학력</th>
				<th>주민번호</th>
				<th>지역구</th>
				<th>대표전화</th>
				<th>구분</th>
			</tr>
			<%
				for(int i=0;i<cnt;i++){
					%>
					<tr>
						<td><%=m_no[i] %></td>
						<td><%=m_name[i] %></td>
						<td><%=p_code[i] %></td>
						<td><%=p_school[i] %></td>
						<td><%=m_jumin[i] %></td>
						<td><%=m_city[i]%></td>
						<td><%=p_tel[i] %></td>
						<td><a href="#">수정</a> / <a href="#">삭제</a></td>
					</tr>
					<%
				}
			%>
		</table>
	</form>
</section>
<%@ include file = "footer.jsp" %>
</body>
</html>
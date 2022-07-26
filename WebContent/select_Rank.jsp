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
<%@ include file = "DBConn.jsp" %>
<section>
	<form name = "form" method = "post">
		<h3 id = "title">후보자 등수(정당명 표기)</h3>
		<hr>
		<table border=2 style="margin:0 auto;">
			<tr>
				<th>순위</th>
				<th>후보번호</th>
				<th>정당명</th>
				<th>성명</th>
				<th>총 투표건수</th>
			</tr>
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
					
					String[] m_no = new String[cnt];
					String[] p_name = new String[cnt];
					String[] m_name = new String[cnt];
					String[] vote = new String[cnt];
					
					sql = "select a.m_no,b.p_name,a.m_name,count(c.m_no) from member0726 a join party0726 b on a.p_code=b.p_code join vote0726 c on a.m_no=c.m_no group by a.m_no,b.p_name,a.m_name order by count(c.m_no) desc";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					int count = 0;
					while(rs.next()){
						m_no[count] = rs.getString(1);
						p_name[count] = rs.getString(2);
						m_name[count] = rs.getString(3);
						vote[count] = rs.getString(4);
						count++;
					}
					for(int i=0;i<cnt;i++){
						%>
						<tr>
							<td><%=i+1 %>등</td>
							<td><%=m_no[i] %></td>
							<td><%=p_name[i] %></td>
							<td><%=m_name[i] %></td>
							<td><%=vote[i] %></td>
						</tr>
						<%
					}
				}catch(Exception e){
					e.printStackTrace();
				}
			%>
		</table>
	</form>
</section>
<%@ include file = "footer.jsp" %>
</body>
</html>
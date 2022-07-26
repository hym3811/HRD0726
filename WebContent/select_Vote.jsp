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
<section style="position:relative;">
	<form name = "form" method = "post">
	<%
		String area = request.getParameter("v_area");
	%>
	<div style="height:100px;">
		<fieldset style="position:absolute;left:2%;top:2%;width:15%;height:60px;">
			<legend>선택</legend><br>
			투표소: 
			<input type = "radio" name = "v_area" value = "제1투표장" <%="제1투표장".equals(area) ? "checked" : "" %> onchange="search()">제1투표장
			<input type = "radio" name = "v_area" value = "제2투표장" <%="제2투표장".equals(area) ? "checked" : "" %> onchange="search()">제2투표장
		</fieldset>
		<h3 id = "title">●투표검수조회●</h3>
		<%
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			int cnt = 0;
			String today = null;
			DateFormat df = new SimpleDateFormat("yyyy-mm-dd");
			
			String[] v_jumin = null;
			String[] v_name = null;
			String[] m_no = null;
			String[] v_time = null;
			String[] v_area = null;
			String[] v_confirm = null;
			
			try{
				String sql = null;
				if(area==null){
					sql = "select count(v_jumin) from vote0726";
					pstmt = conn.prepareStatement(sql);
				}else{
					sql = "select count(v_jumin) from vote0726 where v_area='"+area+"'";
					pstmt = conn.prepareStatement(sql);
				}
				rs = pstmt.executeQuery();
				if(rs.next()){
					cnt = rs.getInt(1);
				}
				
				v_jumin = new String[cnt];
				v_name = new String[cnt];
				m_no = new String[cnt];
				v_time = new String[cnt];
				v_area = new String[cnt];
				v_confirm = new String[cnt];
				
				sql = "select sysdate from dual";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					today = rs.getString(1);
				}
				
				int count = 0;
				if(area==null){
					sql = "select * from vote0726";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while(rs.next()){
						v_jumin[count] = rs.getString(1);
						v_name[count] = rs.getString(2);
						m_no[count] = rs.getString(3);
						v_time[count] = rs.getString(4);
						v_area[count] = rs.getString(5);
						v_confirm[count] = rs.getString(6);
						count++;
					}
				}else{
					sql = "select * from vote0726 where v_area='"+area+"'";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while(rs.next()){
						v_jumin[count] = rs.getString(1);
						v_name[count] = rs.getString(2);
						m_no[count] = rs.getString(3);
						v_time[count] = rs.getString(4);
						v_area[count] = rs.getString(5);
						v_confirm[count] = rs.getString(6);
						count++;
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			System.out.println(today);
		%>
		<p style="margin-left:20%;margin-top:40px;">총 <%=cnt %>명의 투표검수 조회가 있습니다.</p>
		</div>
		<hr>
		<div style="overflow-y:auto;height:580px;">
		<table border=1 style="margin:0 auto;">
			<tr>
				<th>성명</th>
				<th>생년월일</th>
				<th>나이</th>
				<th>성별</th>
				<th>후보번호</th>
				<th>투표시간</th>
				<th>유권자확인</th>
				<th>구분</th>
			</tr>
			<%
				for(int i=0;i<cnt;i++){
					String birth = "19"+v_jumin[i].substring(0,2)+"."+v_jumin[i].substring(3,5)+"."+v_jumin[i].substring(5,7);
					int age = 0;
					int[] mmdd = new int[2];
					mmdd[0] = Integer.parseInt(v_jumin[i].substring(2,6));
					mmdd[1] = Integer.parseInt(today.substring(5,10).replace("-", ""));
					if(mmdd[1]>=mmdd[0]){
						age = Integer.parseInt(today.substring(2,4))-Integer.parseInt(v_jumin[i].substring(0,2))+100;
					}else{
						age = Integer.parseInt(today.substring(2,4))-Integer.parseInt(v_jumin[i].substring(0,2))-1+100;
					}
					String gender = null;
					int gd = Integer.parseInt(v_jumin[i].substring(6,7));
					switch(gd){
					case 1:
						gender="남성";
						break;
					case 2:
						gender="여성";
						break;
					}
					%>
					<tr>
						<td><%=v_name[i] %></td>
						<td><%=birth %></td>
						<td>만 <%=age %>세</td>
						<td><%=gender %></td>
						<td><%=m_no[i] %></td>
						<td><%=v_time[i].substring(0,2) %> : <%=v_time[i].substring(2) %></td>
						<td><%=v_confirm[i].equals("Y") ? "확인" : "미확인" %></td>
						<td><a href="#">수정</a> / <a href="#">삭제</a></td>
					</tr>
					<%
				}
			%>
		</table>
		</div>
	</form>
</section>
<%@ include file = "footer.jsp" %>
</body>
<script>
function search(){
	document.form.action="select_Vote.jsp";
	document.form.submit();
}
</script>
</html>
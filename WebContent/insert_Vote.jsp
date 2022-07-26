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
		<h3 id = "title">●투표하기●</h3>
		<table border=2>
			<tr>
				<th>주민번호</th>
				<td><input type = "text" name = "v_jumin"></td>
			</tr>
			<tr>
				<th>성명</th>
				<td><input type = "text" name = "v_name"></td>
			</tr>
			<tr>
				<th>투표번호</th>
				<td>
					<select name = "m_no">
						<option value="">후보 선택</option>
						<%@ include file = "DBConn.jsp" %>
						<%
							PreparedStatement pstmt = null;
							ResultSet rs = null;
							int cnt = 0;
							try{
								String sql = "select count(m_no) from member0726";
								pstmt = conn.prepareCall(sql);
								rs = pstmt.executeQuery();
								if(rs.next()){
									cnt = rs.getInt(1);
								}
							}catch(Exception e){
								e.printStackTrace();
							}
							String[] m_no = new String[cnt];
							String[] m_name = new String[cnt];
							try{
								String sql = "select m_no,m_name from member0726";
								pstmt = conn.prepareStatement(sql);
								rs = pstmt.executeQuery();
								int count = 0;
								while(rs.next()){
									m_no[count] = rs.getString(1);
									m_name[count] = rs.getString(2);
									count++;
								}
							}catch(Exception e){
								e.printStackTrace();
							}
							for(int i=0;i<cnt;i++){
								%>
								<option value="<%=m_no[i] %>">[<%=m_no[i] %>] <%=m_name[i] %></option>
								<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>투표시간</th>
				<td><input type = "text" name = "v_time"></td>
			</tr>
			<tr>
				<th>투표장소</th>
				<td><input type = "text" name = "v_area"></td>
			</tr>
			<tr>
				<th>유권자 확인</th>
				<td>
					<input type = "radio" name = "v_confirm" value = "Y">확인
					<input type = "radio" name = "v_confirm" value = "N">미확인
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<input type = "button" value = "투표하기" onclick = "vote()">
					<input type = "button" value = "다시하기" onclick = "reset()">
				</td>
			</tr>
		</table>
	</form>
</section>
<%@ include file = "footer.jsp" %>
</body>
<script>
function vote(){
	var doc = document.form;
	/* document.querySelector('input[type=radio][name=v_confirm]:checked').value; */
	/* document.querySelector('input[type=radio][name=v_confirm]:checked'); */
	if(doc.v_jumin.value==""){
		alert("주민번호 입력 필요");
		doc.v_jumin.focus();
	}else if(doc.v_jumin.value.length!=13){
		alert("주민번호는 숫자13자리로 입력");
		doc.v_jumin.focus();
	}else if(isNaN(doc.v_jumin.value)){
		alert("주민번호는 숫자만 입력");
		doc.v_jumin.focus();
	}else if(doc.v_name.value==""){
		alert("성명 입력 필요");
		doc.v_name.focus();
	}else if(doc.m_no.value==""){
		alert("투표번호 선택 필요");
		doc.m_no.focus();
	}else if(doc.v_time.value==""){
		alert("투표시간 입력 필요");
		doc.v_time.focus();
	}else if(doc.v_time.value.length!=4){
		alert("투표시간은 숫자4자리로 입력");
		doc.v_time.focus();
	}else if(isNaN(doc.v_time.value)){
		alert("투표시간은 숫자만 입력");
		doc.v_time.focus();
	}else if(doc.v_area.value==""){
		alert("투표장소 입력 필요");
		doc.v_area.focus();
	}else if(document.querySelector('input[type=radio][name=v_confirm]:checked')==null){
		alert("유권자 확인 체크 필요");
	}else if(document.querySelector('input[type=radio][name=v_confirm]:checked').value=="N"){
		alert("유권자 확인 체크 필요");
	}else{
		doc.action = "insert_Vote_Process.jsp";
		doc.submit();
	}
}
</script>
</html>
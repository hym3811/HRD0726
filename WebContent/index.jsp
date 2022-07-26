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
		<h3 id = "title">지역구 의원 투표관리 시스템</h3>
		<h3 style="text-indent:4%;">투표 관리 시스템을 작성한다.</h3>
		<ol>
			<li style="margin-left:4%;">웹 쇼핑몰 관리 데이터베이스를 구축한다.</li>
			<li style="margin-left:4%;">투표 이력 테이블에 샘플데이터를 SQL문을 사용하여 데이터를 추가 생성한다.</li>
			<li style="margin-left:4%;">후보자 테이블에 샘플데이터를 SQL문을 사용하여 데이터를 추가생성한다.</li>
			<li style="margin-left:4%;">정당 코드 테이블에 샘플데이터를 SQL문을 사용하여 데이터를 추가생성한다.</li>
		</ol>
	</form>
</section>
<%@ include file = "footer.jsp" %>
</body>
</html>
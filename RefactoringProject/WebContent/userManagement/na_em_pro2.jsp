<%@page import="dao.UserManagementDAO"%>
<%@page import="dto.UserManagementDTO"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link type="text/css" rel="stylesheet" href="../css/common.css" />
<script type="text/javascript" src="../js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../js/bookmark.js"></script>
<title>비밀번호 찾기</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	String user_nickname = request.getParameter("mem_name");
	String user_email = request.getParameter("mem_email");

	UserManagementDTO dto = new UserManagementDTO();
	UserManagementDAO dao = new UserManagementDAO();
	String findPw = dao.findPw(user_nickname, user_email);
	
	if(findPw==null){
%>
	<script type="text/javascript">
		alert("입력한 정보를 찾을 수 없습니다.");
		history.back();
	</script>
<% 
	}else{
%>		
	<script type="text/javascript">
		alert("pass는 <%=findPw%>입니다.");
		history.back();
	</script>
<% 
	}
%>		
<body>
</body>
</html>
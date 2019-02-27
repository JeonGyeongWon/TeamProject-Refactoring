<%@page import="dao.UserManagementDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>아이디 중복 체크</title>
	
	<script type="text/javascript">
	
		
		
		// 회원가입창의 아이디 입력란의 값을 가져온다.
		function pValue(){
			document.getElementById("user_email").value = opener.document.userInfo.user_email.value;
		}
				
		
		
		// 사용하기 클릭 시 부모창으로 값 전달 
		function sendCheckValue(){
			// 중복체크 결과인 user_emailCheck 값을 전달한다.
			opener.document.userInfo.idDuplication.value ="emailCheck";
			// 회원가입 화면의 user_email입력란에 값을 전달
			opener.document.userInfo.id.value = document.getElementById("user_email").value;
			
			if (opener != null) {
            	opener.chkForm = null;
            	self.close();
			}	
		}	
	</script>
	
</head>
<body onload="pValue()">
<%
		// 한글 처리
		request.setCharacterEncoding("utf-8");
		// String userid = 파라미터값 불러오기
		String user_email = request.getParameter("user_email");

		// MemberDAO 객체 생성
		// check가 1일 경우 사용가능한 아이디
		UserManagementDAO mdao = new UserManagementDAO();
		int check = mdao.JoinCheck(user_email);
	%>
<div id="wrap">
	<br>
	<b><font size="4" color="gray">아이디 중복체크</font></b>
	<hr size="1" width="460">
	<br>
	<div class="total">
		<form id="checkForm" action="emailCheckForm.jsp" method="post" name="wfr">
			<input type="text" name="user_email" id="user_email" readonly >
			<input type="submit" value="중복확인" id="007" onclick="emailCheck()">
		</form>
		
		<br>
		<!-- 유저아이디가 입력되어있다면 -->
		<%if (request.getParameter("user_email") != null){
			
			if (check == 1){
				out.println("<br>사용가능한아이디입니다.");
		    %>
		    
		    
		<input id="useBtn" type="button" value="사용하기" onclick="sendCheckValue()">
	   		<%
			} else if (check == 0){
				out.println("<br>중복된 아이디입니다.");
				%>
				
		<input id="cancelBtn" type="button" value="취소" onclick="window.close()">
				<%
				} }
				%>	
		  
		 
		    
			
	
	</div>
</div>	
</body>
</html>
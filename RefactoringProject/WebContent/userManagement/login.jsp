<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="./css/login.css">
<script type="text/javascript">
	//로그인 유효성 검사를 위한 자바스크립트(추후 ajax로 변경 예정)
	function check() { //<form>태그(name=login_form)의 submit 발생 시
		var login_form = document.login_form;
		var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
		var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;//email 정규식
	
		if (!login_form.user_email.value) { //user_email의 입력값이 없을 때
			alert("이메일을 입력하세요.");
			login_form.user_email.focus();

			return false;
		}
		if (!re2.test(document.userInfo.user_email.value)) {
			alert("적합하지 않은 이메일 형식입니다.");
			document.userInfo.user_email.focus();
			return false;
		}
		if (!login_form.user_pass.value) { //user_pass의 입력값이 없을 때
			alert("비밀번호를 입력하세요.");
			login_form.user_pass.focus();

			return false;
		}
		if (!re.test(document.userInfo.user_pass.value)) {
			alert("패스워드는 4~12자의 영문 대소문자와 숫자로만 입력");
			document.userInfo.user_pass.focus();
			return false;
		}
		location.href = "./loginPro.um"; //user_email과 user_pass 모두 입력값이 있을 때
	}
</script>
<script>
	var width = 700; //폭
	var height = 550;//높이
	var winL = (screen.width - width) / 2;
	var winT = (screen.height - height) / 2;
	var property = "width=" + width + "," + "height=" + height + "," + "left="
			+ winL + "," + "top=" + winT + " menubar=no";

	function siteInfo2() {
		window.open('./findPassPage.um', "", property);
	}
</script>
</head>
<body>
		<c:if test="${session.user_email != null}">
			<c:set var="user_email" property="${session.user_email}" />
		</c:if>
		<c:if test="${user_email != null}">
			<script type="text/javascript">
				alert("이미 로그인되어 있습니다.");
				location.href = "../main.um";
			</script>
		</c:if>
	<form class="signUp" id="signupForm" action="./loginPro.um" method="post" name="login_form" onsubmit="return check()">
		<h2  class="signUpTitle" id="login_label" >로그인</h2>
	
			<table id="login_table">
				<tr>
					<th><label for="user_email"></label></th>
					<td><input class="signUpInput" type="email" name="user_email" placeholder="이메일 입력.." size="20" /></td>
				</tr>
				<tr>
					<th><label for="user_pass"></label></th>
					<td><input class="signUpInput" type="password" name="user_pass" placeholder="패스워드 입력.." size="20"></td>
				</tr>
				<tr align="center">
					<td colspan="2" align="center"><br /> 
                      <input class="signUpButton" type="submit" value="확    인"> 
					</td>
				</tr>
			</table>
		<br/>
		<p id="login_joinInfo" align="center">
			아직 회원이 아니신가요? <a href="./joinPage.um">회원가입</a>하러 가기
		</p>
		<p id="login_findPass" align="center">비밀번호를 모르시나요? <a href="javascript:siteInfo2()">비밀번호</a>찾기</p>
	</form>

	
	</body>
	</html>
	
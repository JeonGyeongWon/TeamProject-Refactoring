<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>비밀번호 찾기</title>
<link rel="stylesheet" href="./css/login.css"/>
</head>

<body>
	<form class="signUp" id="signupForm" name="signupForm" method="post" action="userManagement/na_em_pro2.jsp">
		<h2 class="signUpTitle" id="login_label">비밀번호 찿기</h2>
			<table id="na_metable">
				<tr>
					<th><label for="name"></label></th>
					<td><input class="signUpInput" name="mem_name" id="mem_name" placeholder="닉네임 입력" size="20" autofocus required></td>
				</tr>
				<tr>
					<th><label for="email"></label></th>
					<td><input class="signUpInput" type="text" name="mem_email" id="mem_email" placeholder="이메일 입력" size="20" required></td>
				</tr>
				<tr align="center">
					<td colspan="2"><br /> 
                      <input a href="javascript:pw_search();" class="signUpButton" type="submit" value="확    인">                                        
					</td>
				</tr>
              <tr align="center">
					<td colspan="2" align="center"><br /> 
                      <input class="signUpButton2" type="button" value="닫기" onclick="window.close();">                
					</td>
				</tr>
			</table>
		</form>

	</body>
</html>
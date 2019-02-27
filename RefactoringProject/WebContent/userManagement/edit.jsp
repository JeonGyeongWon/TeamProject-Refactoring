<%@page import="dto.UserManagementDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="./css/bootstrap.css">
<title></title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!--Ajax를 위해서 공식사이트 에서 제공하는 jquery를 가져온다.  -->
<script src="./js/bootstrap.js"></script>
<script type="text/javascript">
	//<form>태그로 전송할 값의 유효성 검사 //
	function checkValue2() {
		
		var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식 1	    	
		
		
		if (!re.test(document.editUserInfo.user_pass.value)) {
			alert("패스워드는 4~12자의 영문 대소문자와 숫자로만 입력");
			document.editUserInfo.user_pass.focus();
			return false;
		}
		
		
	}
</script>
</head>
<body>
	<c:if test="${session.user_email != null}">
		<c:set var="user_email" property="${session.user_email}" />
		<jsp:useBean id="umdto" class="dto.UserManagementDTO" />
	</c:if>
	<c:if test="${user_email == null}">
		<script type="text/javascript">
			alert("로그인 후 이용할 수 있습니다.");
			location.href = "../loginPage.um";
		</script>
	</c:if>
	<c:if test="${user_email != null}">
		<div class="container">
			<form method="post" action="./editPro.um" name="editUserInfo"
				onsubmit="return checkValue2()">
				<table class="table table-bordered table-hover"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3"><h4 align="center">회원정보수정</h4></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 110px;">
								<h5>이메일</h5>
							</td>

							<td colspan="2" style="text-align: left; vertical-align: middle;">
								<span>${user_email}</span> <input type="hidden"
								name="user_email" value="${user_email}">
							</td>
						</tr>
						<tr>
							<td style="width: 110px;">
								<h5>비밀번호</h5>
							</td>
							<td colspan="2"><input class="form-control" type="password"
								id="user_pass" name="user_pass" maxlength="20"
								placeholder="새 비밀번호를 입력해주세요."></td>
						</tr>
						<tr>
							<td style="width: 110px;">
								<h5>닉네임</h5>
							</td>
							<td colspan="2"><input class="form-control" type="text"
								id="user_nickname" name="user_nickname" maxlength="20"
								value="${umdto.user_nickname}"></td>
						</tr>
						<tr>
							<td style="width: 110px;">
								<h5>생년월일</h5>
							</td>
							<td colspan="2"><input class="form-control" type="text"
								id="user_birth" name="user_birth" maxlength="20"
								value="${umdto.user_birth}"></td>
						</tr>
						<tr>
							<td style="width: 110px;">
								<h5>성별</h5>
							</td>
							<td colspan="2">
								<div class="form-group"
									style="text-align: center; margin: 0 auto;">
									<div class="btn-group" data-toggle="buttons">
										<c:if test="${umdto.user_gender == '남' }">
											<label class="btn btn-primary active"> <input
												type="radio" name="user_gender" autocomplete="on" value="남"
												checked="checked"> 남자
											</label>
											<label class="btn btn-primary"> <input type="radio"
												name="user_gender" autocomplete="off" value="여"> 여자
											</label>
										</c:if>
										<c:if test="${umdto.user_gender == '여' }">
											<label class="btn btn-primary active"> <input
												type="radio" name="user_gender" autocomplete="off" value="남"
												checked="checked"> 남자
											</label>
											<label class="btn btn-primary"> <input type="radio"
												name="user_gender" autocomplete="on" value="여"> 여자
											</label>
										</c:if>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td style="text-align: left;" colspan="3">
								<h5 style="color: red;" id="validationCheck"></h5> <input
								class="btn btn-primary pull-right" type="submit" value="수정">
							</td>
						</tr>
						
						
						
					</tbody>
				</table >
				<br><br><br><br><br>
			</form>
					<table class="table table-bordered table-hover"
					style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="6"><h4 align="center">예약정보</h4></th>
							</tr>
						</thead>
						<tbody>
							<tr align="center">
								<th style="width: 110px;" align="center">Email</th>
								<th align="center">예약호텔번호</th>
								<th align="center">결제유무</th>
								<th align="center">총가격</th>
								<th align="center">체크인시간</th>
								<th align="center">체크아웃시간</th>
							</tr>
							
							
							
						
							
						<c:forEach var="reser" items="${list }">
							<tr align="center">
								<td>${user_email }</td>
								<td>${reser.h_no }</td>
								<td>
							<c:choose>
								<c:when test="${reser.ckprice ==0 }">
									<span style="color=red;">미결제</span>
								</c:when>
								
								<c:otherwise>
									결제
								</c:otherwise>
							</c:choose></td>
								<td>${reser.total_price }</td>
								<td>${reser.ckin }</td>
								<td>${reser.ckout }</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
						
						
		</div>
	</c:if>
</body>
</html>
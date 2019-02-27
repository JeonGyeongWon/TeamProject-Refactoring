<%@page import="hotel.dto.Room_imgDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<link rel="stylesheet" href="/ExTeamProject/css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="/ExTeamProject/css/icomoon.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="/ExTeamProject/css/bootstrap.css">
	<!-- Owl Carousel -->
	<link rel="stylesheet" href="/ExTeamProject/css/owl.carousel.min.css">
	<link rel="stylesheet" href="/ExTeamProject/css/owl.theme.default.min.css">
	<!-- Theme style  -->
	<link rel="stylesheet" href="/ExTeamProject/css/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	.facilitiesDiv{
		width : 50%;
		display : inline-block;
		float : left;
	}
	.HotelMainDiv{	
		width:100%;
		height: 40%;
	}
	.MainImgDiv{
		width:50%;
		height:100%;
		display: inline-block;
		float : left;
	}
	.subImgDiv{
		width:25%;
		height:100%;
		display: inline-block;
		float : left;
	}
	
	.subImg{
		width: 100%;
		height : 50%;
		display : inline-block;
		float : left;
	}
	
	.subimgDiv img{
		width:100%;
		height: 100%;
	}
	.MainImgDiv img{
		width: 100%;
		height: 100%;
	}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>

<script>
<%-- 휴대폰 인증시 새창을 띄워줌  --%> 
function fnPhone(user_no){
	window.open("hotel/SMSAuthForm.jsp?user_no="+user_no,
			"hotel/SMSAuthForm.jsp","width=570","height=350","resizable=no","scrollbars=no");
	}
	
	
		


</script>

</head>
<body>
	<jsp:include page="../header.jsp"/>
	
	
	<div class="container text-center">
		
		<c:set var="hdto" value="${requestScope.hdto }"/>
		<c:set var="fdto" value="${requestScope.fdto }"/>
		<c:set var="rdto" value="${requestScope.rdto }"/>
		<c:set var="r_imgdto" value="${requestScope.r_imgdto }"/>
		<c:set var="udto" value="${requestScope.udto }"/>
		<c:set var="Re_dto" value="${requestScope.Re_dto }"/>
		
	
		<c:choose>
			
			<c:when test="${udto.user_phone == ''}">
				예약, 결제를 하실려면 <a onclick="fnPhone(${udto.user_no});">휴대폰 인증</a>을 하셔야합니다.
			</c:when>
			
			<c:otherwise>
				
				<div>
					<h2>호텔이름 : ${hdto.h_name }아아아글자수채우기이이이이</h2>
					<p>호텔설명 : ${hdto.h_content }</p>
					<p>호텔주의사항 : ${hdto.h_caution }	</p>
					<p>호텔규칙 : ${hdto.h_rule }</p>
					<p>세부사항 : ${hdto.h_detail }</p>	
				</div>
				
				<div>
					<h2 id="facilitiesMainH2">편의시설</h2>
				<c:if test="${fdto.wifi == 1 }">
					<div class="facilitiesDiv">
						<h3>${"와이파이" }</h3>
					</div>
				</c:if>
				<c:if test="${fdto.shampoo == 1 }">
					<div class="facilitiesDiv">
						<h3>${"샴푸무료제공 ..?" }</h3>
					</div>
				</c:if>
				<c:if test="${fdto.closet == 1 }">
					<div class="facilitiesDiv">
						<h3>${"옷장" }</h3>
					</div>
				</c:if>
				<c:if test="${fdto.tv == 1 }">
					<div class="facilitiesDiv">
						<h3>${"tv" }</h3>
					</div>
				</c:if>
				<c:if test="${fdto.aircon == 1 }">
					<div class="facilitiesDiv">
						<h3>${"에어컨" }</h3>
					</div>	
				</c:if>
				<c:if test="${fdto.hairdry == 1}">
					<div class="facilitiesDiv">
						<h3>${"헤어드라이기" }</h3>
					</div>	
				</c:if>
				<c:if test="${fdto.swim == 1 }">
					<div class="facilitiesDiv">
						<h3>${"수영장" }</h3>
					</div>
				</c:if>
				<c:if test="${fdto.wash_dry == 1 }">
					<div class="facilitiesDiv">
						<h3>${"세탁기" }</h3>
					</div>
				</c:if>
				<c:if test="${fdto.parking == 1 }">
					<div class="facilitiesDiv">
						<h3>${"주차장" }</h3>
					</div>
				</c:if>
				<c:if test="${fdto.elevator == 1 }">
					<div class="facilitiesDiv">
						<h3>${"엘리베이터" }</h3>
					</div>
				</c:if>
				<c:if test="${fdto.health == 1 }">
					<div class="facilitiesDiv">
						<h3>${"헬스장" }</h3>
					</div>
				</c:if>
				<c:if test="${fdto.etc != null }">
					<div class="facilitiesDiv">
						<p>${fdto.etc }</p>
					</div>
				</c:if>
				
				</div>
				<!-- 편의시설 정보 끝 -->

				<!-- 방이미지 뿌려주는곳  -->	
				 <!-- fn:split -> 문자열자르기 -->
				
				<c:set var="subimgname" value="${r_imgdto.imgname }"/>
				
				<c:set var="subimg" value="${fn:split(subimgname,',') }"/>	
				
				
								
								<br>
				<div class="HotelMainDiv" >
				
				<h3> 방정보</h3>
				
				<div class="MainImgDiv" id="img1">
					<img src="hotel/${hdto.h_imgpath}${hdto.h_imgname}"/>
				</div>
				
				<div class="subImgDiv">
					<div class="subImg" id="img2">
					<img src="hotel/${r_imgdto.imgpath}${subimg[0]}"/>
					</div>
					<div class="subImg" id="img3">
					<img src="hotel/${r_imgdto.imgpath}${subimg[1]}"/>
					</div>
				</div>
				
				<div class="subImgDiv">
					<div class="subImg" id="img4">
					<img src="hotel/${r_imgdto.imgpath}${subimg[2]}"/>
					</div>
					<div class="subImg" id="img5">
					<img src="hotel/${r_imgdto.imgpath}${subimg[3]}"/>
					</div>
				</div>
				
				<div class="HotelMainDiv"> 
				<br>
				체크인 날짜는 : ${Re_dto.ckin } <br>
				체크아웃 날짜는 : ${Re_dto.ckout }<br>
				총 금액은 : ${Re_dto.total_price }<br>
				예약번호는 : ${udto.user_phone }<br>
				
				위 사항이 맞습니다.<input type="checkbox"> 
				</div>
				<form action="reservation.hotel" method="post"> 
					<input type="hidden" name ="h_no" value="${Re_dto.h_no }">
					<input type="hidden" name ="h_rno" value="${Re_dto.h_rno }">
					<input type="hidden" name ="user_no" value="${Re_dto.user_no }">
					<input type="hidden" name ="total_price" value="${Re_dto.total_price }">
					<input type="hidden" name ="ckprice" value="${Re_dto.ckprice }">
					<input type="hidden" name ="begindate" value="${Re_dto.ckin }">
					<input type="hidden" name ="enddate" value="${Re_dto.ckout }">
					<input type="hidden" name ="personnel" value="${Re_dto.personnel }">
					<input type="hidden" name ="ckreservation" value="1">
					<input type="submit" value="예약하기">
				</form>
				
				
				
			</div>
			</c:otherwise>
		</c:choose>
		
	
	</div>
	
	
</body>
</html>
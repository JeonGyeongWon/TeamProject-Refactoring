<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>

<!-- 결제 api에 사용에 추가해야할 자바스크립트 링크 --> 
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-x.y.z.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>

var nowpay = confirm("지금 결제를 바로 하시겠습니까?");
if(!nowpay){
	alert('당일결제가 가능하며 선결제를 원할시 마이페이지에서 가능합니다.');
	location.href='HotelMain.hotel';
}

$(function(){
IMP.init('imp11756047');
IMP.request_pay({
    pg : 'html5_inicis',
    pay_method : 'card',
    merchant_uid : 'merchant_' + new Date().getTime(),
    name : '호텔명:${hdto.h_name}',
    amount : ${re_dto.total_price},	// 돈이 실제로 빠져나가고 익일 00시에 다시들어옵니다 테스트시에는 최소단위인 100으로 테스트해주세요
    buyer_email : 'iamport@siot.do',
    buyer_tel : '${udto.user_phone}',
}, function(rsp) {
    if ( rsp.success ) {
        var msg = '결제가 완료되었습니다.';
        alert('마이페이지에서 확인 하실수 있습니다.');
        location.href='payment.hotel?user_no=${Re_dto.user_no}&total_price=${Re_dto.total_price}&h_rno=${re_dto.h_rno}';
    } else {
        var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
        
        var ques = confirm("나중에 결제 하시겠습니까?");
        if(ques){
        	location.href="./index.jsp";
        }else{
        	alert('F5를 눌러서 재결제를 해주세요');
        }
        
    }
});
});

</script>
</head>
<body>
request.setAttribute("hdto", hdto);
			request.setAttribute("rdto", rdto);
			request.setAttribute("udto", udto);
	<c:set var="re_dto" value="${Re_dto }"/>
	<c:set var="hdto" value="${hdto }"/>
	<c:set var="rdto" value="${rdto }"/>
	<c:set var="udto" value="${udto }"/>
</body>
</html>
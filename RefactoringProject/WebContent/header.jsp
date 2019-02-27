<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=906e68dba1adb50425e650ad46575c5b&libraries=services"></script>

<!-- Animate.css -->
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
   
   

   <!-- Modernizr JS -->
   <script src="js/modernizr-2.6.2.min.js"></script>
</head>

<style>
#searchBox { height:45px;}
#searchSelect{ height:45px;}
#searchBtn{ height:45px;}
/* #keeeee{padding-left: 280px;} */

</style>



<script>
   function fnHotel(url){
      location.href =   url+'';
   }
</script>


<body>

<!-- 맨위 navbar -->
   <c:if test="${session.user_email!=null}">
      <c:set var="user_email" property="${session.user_email}"/>
      <c:set var="user_no" property="${session.user_no}"/>            <!-- 다른 작업에 참조키로 사용할 수 있도록 user_no를 세션에 저장한다. -->
      <c:set var="user_nickname" property="${session.user_nickname}"/>
   </c:if>
   <nav class="navbar navbar-expand-sm bg-light">
      <div class="container-fluid">
         <ul class="nav navbar-nav navbar-right">
            <c:if test="${user_email == null}">
               <li class="nav-item"><a href="./loginPage.um">로그인</a></li>
               <li class="nav-item"><a href="./joinPage.um">회원가입</a></li>
            </c:if>
            <c:if test="${user_email != null}">
               <li class="nav-item">${user_nickname}(${user_email})님 환영합니다.</li>
               <li class="nav-item"><a href="./logoutPro.um">로그아웃</a></li>
               <li class="nav-item"><a href="./editPage.um">회원정보수정</a></li>
            </c:if>
         </ul>
      </div>
   </nav>
      
      <!-- 검색 버튼 및 각 페이지 이동 버튼 -->
       <div class="container">
          <div class="col-xl-9 mx-auto com-md-4">
          
          </div>
          <div class="col-md-10 col-lg-8 col-xl-7 mx-auto" >
            <form action="HotelMain.hotel" method="post"  margin-left:40%">
              <div class="form-row" id="keeeee" style=" display: inline-block !important; ">
            <!--      <select class="col-md-4 enter" name="key" id="searchSelect" style="width: 100px !important;">
                  <option value="0">호텔이름</option>   검색키워드구분
                  <option value="1">지역구</option>
               </select> -->
                <div class="col-12 col-md-6 mb-2 mb-md-0" style="width: 800px;">
                  <input type="text" class="form-control form-control-lg" placeholder="부산지역검색" name="word" id="searchBox" 
                  style="width: 400px; display: inline-block !important;">
                  <button type="submit" class="btn btn-block btn-lg btn-primary" id="searchBtn" style="width: 100px; display: inline-block !important;">검색</button>
                </div>
                <div class="col-12 col-md-3" >
                </div>
              </div>
            </form>
          </div>
      </div>
      <br>
      <!-- jQuery -->
   <script src="js/jquery.min.js"></script>
   <!-- jQuery Easing -->
   <script src="js/jquery.easing.1.3.js"></script>
   <!-- Bootstrap -->
   <script src="js/bootstrap.min.js"></script>
   <!-- Carousel -->
   <script src="js/owl.carousel.min.js"></script>
   <!-- Stellar -->
   <script src="js/jquery.stellar.min.js"></script>
   <!-- Waypoints -->
   <script src="js/jquery.waypoints.min.js"></script>
   <!-- Counters -->
   <script src="js/jquery.countTo.js"></script>
   
   
   <!-- MAIN JS -->
   <script src="js/main.js"></script>
      
</body>
</html>
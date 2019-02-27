<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

   <!-- Animate.css -->
   <link rel="stylesheet" href="css/animate.css">
   <!-- Icomoon Icon Fonts-->
   <link rel="stylesheet" href="css/icomoon.css">
   <!-- Bootstrap  -->
   <link rel="stylesheet" href="css/bootstrap.css">
   <!-- Owl Carousel -->
   <link rel="stylesheet" href="css/owl.carousel.min.css">
   <link rel="stylesheet" href="css/owl.theme.default.min.css">
   <!-- Theme style  -->
   <link rel="stylesheet" href="css/style.css">
   <!-- 다음 지도관련 css -->
   <link rel="stylesheet" href="css/DaumMap.css">
   
   
   
   
   <!-- 토글버튼 css -->
   <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">

   <!-- Modernizr JS -->
   <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
   <script src="js/modernizr-2.6.2.min.js"></script>
   
   <!-- 다음지도를 위한 cdn -->
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=906e68dba1adb50425e650ad46575c5b"></script>
   
   
   
   
   
   
   
   

</head>
<body>
   
   <c:if test="${requestScope.list !=null }">
      <c:set var="list" value="${requestScope.list }"/>
   </c:if>
   
   <!-- sidebar -->
   <div id="fh5co-page">
      <a href="#" class="js-fh5co-nav-toggle fh5co-nav-toggle"><i></i></a>
      <aside id="fh5co-aside" role="complementary" class="border js-fullheight">

      <div class="text-center">
         <a href="index.jsp"><img alt="logo" src="images/logo_Bearbnb.jpg" width="200" height="100"></a> <br><br>
         <label class="checkbox-inline"><h5>아래 버튼을 눌러 위치를 확인해보세요!</h5>
         <input id="chmap" type="checkbox" data-toggle="toggle">
         </label>
      </div>
      
      <br>
         <nav id="fh5co-main-menu" role="navigation">
            <ul>
               <li class="fh5co-active"><a href="index.html">부산지역호텔보기</a></li>
               <li><a href="about.html">About</a></li>
               <li><a href="contact.html">Contact</a></li>
            </ul>
         </nav>

         <div class="fh5co-footer">
            <p><small>&copy; 2016 Nitro Free HTML5. All Rights Reserved.</span> <span>Designed by <a href="http://freehtml5.co/" target="_blank">FreeHTML5.co</a> </span> <span>Demo Images: <a href="http://unsplash.com/" target="_blank">Unsplash</a></span></small></p>
            <ul>
               <li><a href="#"><i class="icon-facebook"></i></a></li>
               <li><a href="#"><i class="icon-twitter"></i></a></li>
               <li><a href="#"><i class="icon-instagram"></i></a></li>
               <li><a href="#"><i class="icon-linkedin"></i></a></li>
            </ul>
         </div>

      </aside>
   
          <!-- 다음 api지도 -->   
      <div id="Daum_map" class="col-md-12"></div>
   </div>   
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
   
   <%-- 토글 버튼을 위한 링크 --%>
   <!--     인덱스에서 작업할때 충돌 일어남 평소 주석
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-alpha/js/bootstrap.min.js"></script>
   <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
    -->
   
   <!-- MAIN JS -->
   <script src="js/main.js"></script>
      
      <script>
      
      
      
      // 인포윈도우를 열어주는 함수입니다.
      function makeOverListener(map, marker, infowindow) {
          return function() {
              infowindow.open(map, marker);
          };
      }

      // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
      function makeOutListener(infowindow) {
          return function() {
              infowindow.close();
          };
      }
      
      
   $(function(){
         
       $("#Daum_map").hide();
      //이벤트
      $('#chmap').change(function() {
           var ckmap = ($(this).prop('checked'));   //자바스크립트의 속성을 가져옴
           
           if(ckmap){
              $("#Daum_map").show();
              
              <%-- 지도찍기... JSTL을 통해 가져왔지만 코드읽기가 불편하므로 ajax처리...를 권유합니다 ....--%>
              
              <%--!!어차피  메인 페이지에서는 무조건적으로 ajax를 통하여 불러와야합니다. check시!
                 그렇지않으면 지도가 3번생성되어 서버가  터집니다
                 
                 api설명 지도api에서 여러개 좌표는 positions라는 *객체배열*에 담아서 반환합니다.
                 자바의 ArrayList값을 바로 자바스크립트에 담을수 없으므로
                 JSTL에 foreach문을 돌려 각각의 요소 arr(배열)을 만든후 해당 객체의 속성값을 arr(배열)을 이용하여 만들어서
                 객체를 생성후 해당 객체를 배열로 반환합니다 
               --%>
                var latitude = new Array();   //위도
                var hardness = new Array();   //경도
                var hotelName = new Array();   //호텔이름
                var hotelImgName = new Array();
                var hotelImgPath = new Array();
                var hotelH_no = new Array();
                <c:forEach var="hotelDto" items="${list }" step="1">
                latitude.push(${hotelDto.latitude }); //위도 이클립스에러로 뜨는 빨간줄입니다 신경안쓰셔도됩니다!
                hardness.push(${hotelDto.hardness }); //경도 
                hotelName.push('${hotelDto.h_name}');
                hotelImgPath.push('${hotelDto.h_imgpath}');
                hotelImgName.push('${hotelDto.h_imgname}');
                hotelH_no.push('${hotelDto.h_no}');
                </c:forEach>
                
                
                var mapContainer = document.getElementById('Daum_map'), // 지도를 표시할 div  
                   mapOption = { 
                       center: new daum.maps.LatLng(37.47,  127.05), // 지도의 중심좌표
                       level: 7 // 지도의 확대 레벨 낮을수록확대입니다 최대 14   // 
                   };
               var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
            
               
               
               var arr = [];
               for(var i=0; i<latitude.length; i++){
                  var o = {};
                  o.title = hotelName[i],
                  o.latlng = new daum.maps.LatLng(hardness[i], latitude[i]),
                  arr.push(o);
               }
               
               
               
               //밑에 positions객체에 담을 값을 만듭니다.
               var positions = arr;
               
               console.log(positions);
                   
               for (var i = 0; i < positions.length; i ++) {
                  var imageSrc ="hotel/"+hotelImgPath[i]+hotelImgName[i];
                   // 마커 이미지의 이미지 크기 입니다
                   var imageSize = new daum.maps.Size(24, 35); 
                   
                   // 마커 이미지를 생성합니다    
                   var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
                   
                   // 마커를 생성합니다
                   var marker = new daum.maps.Marker({
                       map: map, // 마커를 표시할 지도
                       position: positions[i].latlng, // 마커를 표시할 위치
                       title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                       image : markerImage // 마커 이미지 
                   });
                   
                  
                   
                   // 마커에 표시할 인포윈도우를 생성합니다 
                   var infowindow = new daum.maps.InfoWindow({
                       content: positions[i].title // 인포윈도우에 표시할 내용
                   });

                   // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
                   // 이벤트 리스너로는 클로저를 만들어 등록합니다 
                   // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
                   daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
                   daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
                   
                   
                   daum.maps.event.addListener(marker, 'click', function(){
                   
                   });
                   
           }
               
      
           }else{
              $("#Daum_map").hide();
           }
      });
      
      
      
   });
   
   </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
th {
  background-color: #ff4d4d;
  color: white;
}

table{
   width:700px;
   align: center;
   margin: 10px auto;
}

td { padding:10px 20px;}

tr td:Nth-of-type(1){
   width: 150px;
   text-align: center;
   background-color:  #eee;
   color: #ff4d4d;
   font-weight: bold;
}

#upload {  text-align: center !important; }

td input {
    padding:5px 10px !important;
}

#checkbox { font-size: 12px;}
</style>


<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- 다음주소찾기 ... -->
<script>

<%--팝업창을 이용한 찾기를 가져옴--%>

$(function(){
   $("#room input[type=file]").on("change",function(){
      
      
      
      $("#subimg").html("서브이미지 5개 필수 ");
      
      for(var i=2; i<7; i++ ){
      var file = "<input type='file' name='h_img"+i+"'>";
      $("#subimg").append(file);
      }
      
   });
   
})



</script>
<script type="text/javascript">
   //<form>태그로 전송할 값의 유효성 검사
 /*   function checkValue3() {
      var re1 = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{1,45}$/ // 한글영문숫자대소문 적합한지 검사할 정규식 1~45
      var re2 = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{1,300}$/ //1~300
      var re3 = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{1,100}$/ //1~100
      var re4 = /^[0-9]{1,10}$/ //숫자로만 정규식
      var re5 = /\.(gif|jpg|jpeg|tiff|png)$///이미지 파일만 정규식
      
       if (!re1.test(document.userInfo.h_name.value)) {
         alert("숙소 이름은 45자이내로 입력하여야 합니다.");
         document.userInfo.h_name.focus();
         return false;
      } 
      
       if (!re2.test(document.userInfo.h_content.value)) {
         alert("300자이내로 입력하여야 합니다.");
         document.userInfo.h_name.focus();
         return false;
      }
      
      if (!re3.test(document.userInfo.h_rule.value)) {
         alert("100자이내로 입력하여야 합니다.");
         document.userInfo.h_rule.focus();
         return false;
      }
      if (!re3.test(document.userInfo.h_detail.value)) {
         alert("100자이내로 입력하여야 합니다.");
         document.userInfo.h_detail.focus();
         return false;
      }
      
      if (!re4.test(document.userInfo.bed.value)) {
         alert("침대 갯수는 숫자로만 입력");
         document.userInfo.bed.focus();
         return false;
      }
      
      if (!re4.test(document.userInfo.bathroom.value)) {
         alert("화장실 갯수는 숫자로만 입력");
         document.userInfo.bathroom.focus();
         return false;
      }
      
      if (!re4.test(document.userInfo.weekprice.value)) {
         alert("주중가는 숫자로만 입력");
         document.userInfo.weekprice.focus();
         return false;
      }
      
      if (!re4.test(document.userInfo.weekend_price.value)) {
         alert("주말가는 숫자로만 입력");
         document.userInfo.weekend_price.focus();
         return false;
      }

      if (!document.userInfo.h_img0.value) {
         alert("호텔 이미지를 선택를 해주세요.");
         document.userInfo.h_img0.focus();
         return false;
      }
      
      if (!re5.test(document.userInfo.h_img0.value)) {
         alert("이미지는 gif,jpg,jpeg,tiff,png 파일만 사용 가능합니다.");
         document.userInfo.h_img0.focus();
         return false;
      }
      
      
      if (!document.userInfo.imgname.value) {
         alert("메인 이미지를 선택해주세요.");
         document.userInfo.imgname.focus();
         return false;
      }
      
      if (!re5.test(document.userInfo.imgname.value)) {
         alert("이미지는 gif,jpg,jpeg,tiff,png 파일만 사용 가능합니다.");
         document.userInfo.imgname.focus();
         return false;
      }
      
      if (!document.userInfo.addr.value){
         alert("주소를 검색해 주세요.");
         document.userInfo.addr.focus();
         return false;
      }
         
      if (!document.userInfo.h_img2.value) {
         alert("서브 이미지는 모두 선택하여야 합니다.");
         document.userInfo.h_img2.focus();
         return false;
      }
      
      if (!document.userInfo.h_img3.value) {
         alert("서브 이미지는 모두 선택하여야 합니다.");
         document.userInfo.h_img3.focus();
         return false;
      }
      if (!document.userInfo.h_img4.value) {
         alert("서브 이미지는 모두 선택하여야 합니다.");
         document.userInfo.h_img4.focus();
         return false;
      }
      if (!document.userInfo.h_img5.value) {
         alert("서브 이미지는 모두 선택하여야 합니다.");
         document.userInfo.h_img5.focus();
         return false;
      }
      if (!document.userInfo.h_img6.value) {
         alert("서브 이미지는 모두 선택하여야 합니다.");
         document.userInfo.h_img6.focus();
         return false;
      }
      
      
      if (!re5.test(document.userInfo.h_img2.value)) {
         alert("이미지는 gif,jpg,jpeg,tiff,png 파일만 사용 가능합니다.");
         document.userInfo.h_img2.focus();
         return false;
      }

      if (!re5.test(document.userInfo.h_img3.value)) {
         alert("이미지는 gif,jpg,jpeg,tiff,png 파일만 사용 가능합니다.");
         document.userInfo.h_img3.focus();
         return false;
      }

      if (!re5.test(document.userInfo.h_img4.value)) {
         alert("이미지는 gif,jpg,jpeg,tiff,png 파일만 사용 가능합니다.");
         document.userInfo.h_img4.focus();
         return false;
      }

      if (!re5.test(document.userInfo.h_img5.value)) {
         alert("이미지는 gif,jpg,jpeg,tiff,png 파일만 사용 가능합니다.");
         document.userInfo.h_img5.focus();
         return false;
      }

      if (!re5.test(document.userInfo.h_img6.value)) {
         alert("이미지는 gif,jpg,jpeg,tiff,png 파일만 사용 가능합니다.");
         document.userInfo.h_img6.focus();
         return false;
      }

   }
 */

</script>       
<body>
   <form action="./InsertHotel.hotel" method="post" enctype="multipart/form-data" name="userInfo" onsubmit="return checkValue3()">
   
   
   <table>
      
         <tr><th colspan="2"><h1>호텔 등록하기</h1></th></tr>
         <tr>
            <td>호텔 이름</td>
            <td><input type="text" name="h_name" id="h_name" required="required" style="width:300px;" maxlength="45"></td>
         </tr>
         <tr>
            <td>호텔 설명</td>
            <td><textarea name="h_content" id="h_content" cols="40" rows="10" style="width:300px;" maxlength="300"></textarea></td>
         </tr>
         <tr>
            <td>주의사항</td>
            <td><input type="text" name="h_caution" id="h_caution" style="width:300px;" maxlength="100"></td>
         </tr>
         <tr>
            <td>이용규칙</td>
            <td><input type="text" name="h_rule" id="h_rule" style="width:300px;" maxlength="100"></td>
         </tr>
         <tr>
            <td>세부사항</td>
            <td><input type="text" name="h_detail" id="h_detail" style="width:300px;"></td>
         </tr>
         <tr>
            <td>호텔 이미지</td> <!-- 메인이미지 -->
            <td><input type="file" name="h_img0" id ="imgCheck"> </td>
            <!-- http://bigmark.tistory.com/28 참고 -->
         </tr>
         
         
         <!-- 
            추후수정 -> 서브이미지파일 받는것 -> 다중업로드 -> 
          -->
          
          <tr>
             <td><a onclick="execDaumPostcode();">주소찾기</a></td>
             <td><input type="text" id="sample5_address" placeholder="주소를 입력하세요" style="width:300px;" name="addr" readonly>
               <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
               <div id="map" style="width:300px;height:300px;margin-top:10px;display:none;"></div>
               </td>
          </tr>
         
      
         <tr>
            <td>편의시설</td>
            <td>
               <p id="checkbox">
               <input type="checkbox" name="wifi" id="wifi" value="1">WIFI
               <input type="checkbox" name="tv" id="tv" value="1">TV
               <input type="checkbox" name="aircon" id="aircon" value="1">에어컨
               <input type="checkbox" name="wash_dry" id="wash_dry" value="1">세탁기
               <input type="checkbox" name="closet" id="closet" value="1">옷장
               <input type="checkbox" name="shampoo" id="shampoo" value="1">욕실용품
               <input type="checkbox" name="hairdry" id="hairdry" value="1">헤어드라이어
               <br>
               <input type="checkbox" name="parking" id="parking" value="1">건물 내 무료 주차
               <input type="checkbox" name="elevator" id="elevator" value="1">엘리베이터
               <input type="checkbox" name="swim" id="swim" value="1">수영장
               <input type="checkbox" name="health" id="health" value="1">피트니스 센터
               </p>
            </td>
         </tr>
   </table>
   
   
      
      <div id="room">
      <table>
         <tr><th colspan="4"><h3>방 정보 입력하기</h3></th></tr>
         <tr>
            <td>적정인원</td>
            <td>
               <select name="personnel">
                  <option value="2">2인이하</option>
                  <option value="4">4인이하</option>
                  <option value="6">6인이하</option>
                  <option value="8">8인이상</option>
               </select>
            </td>
         </tr>
         <tr>
            <td>침대갯수</td>
            <td><input type="text" name="bed" required></td>
         </tr>
         <tr>
            <td>화장실개수</td>
            <td><input type="text" name="bathroom" required></td>
         </tr>
         <tr>
            <td>방사이즈</td>
            <td>
               <select name="roomsize">
                  <option value="싱글">싱글</option>
                  <option value="더블">더블</option>
                  <option value="트윈">트윈</option>
                  <option value="스위트">스위트</option>
               </select>
            </td>
         </tr>
         
         <!-- 줄바꿈 해야되는데 안됨 -->
         <tr>
            <td>주중가</td>
            <td><input type="text" name="weekprice" required></td>
         </tr>
         <tr>
            <td>주말가</td>
            <td><input type="text" name="weekend_price" required></td>
         </tr>
         
         <tr>
            <td>메인이미지</td>
            <td id="appendTd"><input type="file" name="h_img1" id="imgname" >
            <div id='subimg'>
      
     	 	</div>
            </td>
             
         </tr>
         
         
   
         
      </table>
       <div id="upload">
        <input type="submit" value="업로드">
       </div>
      </div>
      
     
      



   
   

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=906e68dba1adb50425e650ad46575c5b&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script>

$(function(){
   
   var wedo;
   var gyungdo;
   
   
});
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        
                        
                        // 위도, 경도 값을 가져옴
                       
                        gyungdo = result.y;
                        wedo = result.x;
                        $("#wedo").val(wedo);
                        $("#gyungdo").val(gyungdo);
                        
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
</script>
   <input type="hidden" id="wedo" name="Latitude" value=""> <!-- 위도 -->
   <input type="hidden" id="gyungdo" name="Hardness" value=""> <!-- 경도 -->
   </form>
   
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	<!-- 현재 페이지 css -->



<style>
	/*%기준을 잡기위한 html,body*/
	html,body{
		width: 100%;
		height: 100%:
	}
	
	/*호텔 사진과 정보가 들어가는 제일큰 DIv*/
	.HotelMainDiv{	
		width:100%;
		height: 40%;
	}
	
	.HotelMainDiv img{
		width: 100%;
		height: 100%;
	}	
	
	.HotelMainDiv .MainImgDiv{
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
	
	
	
	.HotelInfoDiv{	
		width:65%;
		display: inline-block;
	}
	
	
	.MainHotelImgDiv{
		width : 70%;
		height : 30%;
		margin-left: auto;
		margin-right: auto;
	}
	
	.MainHotelImgDiv img{
		width : 100%;
		height : 30%;
	}
	
	.facilitiesDiv{
		width : 50%;
		display : inline-block;
		float : left;
	}
	
	
	<!--방정보-->
	.roomInfo{
		width:65%;
		display: flow-root; /*뭔지 모르겠지만 이거하니됬다.*/
	}
	
	.roomMainImg{
		width:20%;
		display : inline-block;
		float : left;
	}
	
	.roomMainImg img{
		width:100%;
		height: 100%;
	}
	
	#roomInfo{
		width:65%;
		display: flow-root; /*뭔지 모르겠지만 이거하니됬다.*/ 
	}
	
	#roomInfo2{
		width:65%;
		display: flow-root; /*뭔지 모르겠지만 이거하니됬다.*/
	}
	
	
	
	#reservation{
		width: 35%;
		height: 100%;
		text-align: center;
		display : inline-block;
		float :right;
		font-size: medium;
		border: 1px dashed black;	
	}
	
	#reservation input{
		width:45%;
	}


	<!--댓글-->
	#commList { display:inline-block;
				border: 1px solid blue;}
	
	</style>	

<title>Insert title here</title>
</head>
<body>
		
		<jsp:include page="../header.jsp"/>
	
	
	<c:set var="hdto" value="${requestScope.hdto }"/>
	
	<c:set var="fdto" value="${requestScope.fdto }"/>
	
	<c:if test="${udto !=null }">
		<c:set var ="udto" value="${requestScope.udto}" />
	</c:if>
	
	<c:if test="${commentList != null }">
		<c:set var ="commentList" value="${requestScope.commentList }"/>
	</c:if>
	
	
	<c:choose>
		<c:when test="${hdto == null }">
			<script>
			alert('정상적인 접근이 아니거나 해당 호텔의 정보가 삭제되었습니다.')
			</script>
		</c:when>
		
		
		
		
		<c:otherwise>
		<!-- 예약시에 사용될 h_no 셋팅 -->
		<c:set var="h_no" value="${hdto.h_no }"/>
			<div class="HotelMainDiv">
				<div class="MainHotelImgDiv">
					<img src="hotel/${hdto.h_imgpath}${hdto.h_imgname}">
				</div>	 
			</div>
			<br>
			<br>
			<br>
			
		<div class="container">
		
			<div class="HotelInfoDiv">
					<h2>호텔이름 : ${hdto.h_name }</h2>
					<h3 id="bestcount">${hdto.h_bestcount }명이 해당 호텔을 추천했습니다!</h3>
					<p>호텔설명 : ${hdto.h_content }</p>
					<p>호텔주의사항 : ${hdto.h_caution }	</p>
					<p>호텔규칙 : ${hdto.h_rule }</p>
					<p>세부사항 : ${hdto.h_detail }</p>	
					
					<hr/>
					
			</div>		
			
			<div id="reservation">
						
						
				<c:choose>
					
					<c:when test="${sessionScope.user_email !=null }">
					
					<span id="price"></span>
					<br>날짜<br>
					<form action="reservation.hotel" method="post" id="res_form">
					<input type="text" placeholder="체크인" id="ckindate" name="begindate" text-align="center"> -> 
					<input type="text" placeholder="체크아웃" id="ckoutdate" name="enddate" text-align="center"><br>
					
					<!--  예약자는 : ${udto.user_email } <br>-->
					<br>인원 선택<br>
					<input type = "hidden" name="ckreservation" value="0"><!-- 예약하기와, 예약정보뿌려주기를 나누는 플래그 action가보시면압니당. -->
					<input type = "hidden" name="h_no" value="${hdto.h_no }">
					<input type = "hidden" name="h_rno" value="0" id="res_h_rno"><!-- ajax사용해서 값을 지정합니다 -->
					<input type = "hidden" name="user_no" value="${udto.user_no }" >
					<select name="personnel" id="res_personnel">
					</select>
					
					<input type = "hidden" name="total_price" value="0" id="total_price">
					<!-- 날짜선택시 표시될 총 가격이 들어갈공간 -->
					</form>
					<button onclick="CkReser();">예약하기</button><br>
					<span id="total_priceSpan"></span>
					</c:when>
					<c:otherwise>
					로그인되지 않았습니다 <a href="./loginPage.um">로그인</a>을 해주세요
					</c:otherwise>
				</c:choose>	
				<br>
						
							
			</div>
					
					
				<div class="HotelInfoDiv">
				<h2 id="facilitiesMainH2">편의시설</h2>
				<c:if test="${fdto.wifi == 1 }">
					<div class="facilitiesDiv">
						<p>${"와이파이" }</p>
					</div>
				</c:if>
				<c:if test="${fdto.shampoo == 1 }">
					<div class="facilitiesDiv">
						<p>${"어매니티 제공" }</p>
					</div>
				</c:if>
				<c:if test="${fdto.closet == 1 }">
					<div class="facilitiesDiv">
						<p>${"옷장" }</p>
					</div>
				</c:if>
				<c:if test="${fdto.tv == 1 }">
					<div class="facilitiesDiv">
						<p>${"tv" }</p>
					</div>
				</c:if>
				<c:if test="${fdto.aircon == 1 }">
					<div class="facilitiesDiv">
						<p>${"에어컨" }</p>
					</div>	
				</c:if>
				<c:if test="${fdto.hairdry == 1}">
					<div class="facilitiesDiv">
						<p>${"헤어드라이기" }</p>
					</div>	
				</c:if>
				<c:if test="${fdto.swim == 1 }">
					<div class="facilitiesDiv">
						<p>${"수영장" }</p>
					</div>
				</c:if>
				<c:if test="${fdto.wash_dry == 1 }">
					<div class="facilitiesDiv">
						<p>${"세탁기" }</p>
					</div>
				</c:if>
				<c:if test="${fdto.parking == 1 }">
					<div class="facilitiesDiv">
						<p>${"주차장" }</p>
					</div>
				</c:if>
				<c:if test="${fdto.elevator == 1 }">
					<div class="facilitiesDiv">
						<p>${"엘리베이터" }</p>
					</div>
				</c:if>
				<c:if test="${fdto.health == 1 }">
					<div class="facilitiesDiv">
						<p>${"헬스장" }</p>
					</div>
				</c:if>
				<c:if test="${fdto.etc != null }">
					<div class="facilitiesDiv">
						<p>${fdto.etc }</p>
					</div>
				</c:if>
					<hr>		
		</div><!-- 편의시설 종료 -->
		
		<div id="roomInfo">	
				
					<hr>							
					<h3>사진을 클릭하시면 큰 사진을 보실 수 있습니다.</h3>
					
		</div>
				<!-- 페이징처리해야함! -->
				<!-- 지금은 임의로 5개 만들어놨음 나중에 1개만  -->	
			<c:forEach var="room" items="${requestScope.rlist }">
				<!-- ajax에 서브이미지를 가져오기 위한 data값을 전달하기위해 셋팅 -->
				<c:set var ="h_rno" value="${room.h_rno }"/>
				<div class="roomMainImg">
					<img src="hotel/${room.imgpath }${room.imgname}">
				</div>
				<div class="roomMainImg">
					<img src="hotel/${room.imgpath }${room.imgname}">
				</div>
				<div class="roomMainImg">
					<img src="hotel/${room.imgpath }${room.imgname}">
				</div>
				<div class="roomMainImg">
					<img src="hotel/${room.imgpath }${room.imgname}">
				</div>
				<div class="roomMainImg">
					<img src="hotel/${room.imgpath }${room.imgname}">
				</div>
				
			</c:forEach>	
		</div> <!-- 컨테이너 종료 -->
		
		<%-- ajax를 통해 뿌려주는 부분 --%>
			<div class="HotelMainDiv" >
				
				<div class="MainImgDiv" id="img1">
					<!-- 메인이미지 들어갈곳 -->
				</div>
				
				<div class="subImgDiv">
					<div class="subImg" id="img2">
						<!-- 서브이미지 들어갈곳 -->	
					</div>
					<div class="subImg" id="img3">
						<!-- 서브이미지 들어갈곳 -->
					</div>
				</div>
				
				<div class="subImgDiv">
					<div class="subImg" id="img4">
						<!-- 서브이미지 들어갈곳 -->
					</div>
					<div class="subImg" id="img5">
						<!-- 서브이미지 들어갈곳 -->
					</div>
				</div>
				
				<hr/>
			</div>
			
			<div class="container text-center">
				<div id="roomInfo2">	
				<%-- ajax를 통해 뿌려주는부분 --%>			
				</div>
			</div>
			<%-- 종료 --%>	
				
			<div class="container text-center"><button class="btn btn-primary" onclick="fnUpCount(${h_no});">추천하기</button></div>
			
			<div class="container">
    <br><br>
        <div>
            <div>
                <span><strong>댓글</strong></span> <span id="cCnt"></span>
                
                	<div id="commentList">
                	<hr>
                <c:forEach var="comment" items="${commentList }" varStatus="ss">
                	<div class="commentList2">
                	댓글번호 :${ss.index+1}번 <br>
                	제목 : ${comment.subject } <br>
                	내용 : ${comment.content } <br>
                	작성날짜 : ${comment.regdate } <br>
                	추천수 : ${comment.bestcount } <br><br>
                	<hr>
                	</div>
                </c:forEach>
                	</div>
            </div>
            <div>
                <table class="table">                    
                    <tr>
                    	<td>
                    		<textarea style="width: 200px" rows="3" cols="30" id="comment_subject" name="content" placeholder="제목"></textarea>
                    	</td>
                        <td>
                            <textarea style="width: 900px" rows="3" cols="30" id="comment_content" name="content" placeholder="댓글을 입력하세요"></textarea>
                            <br>
                            <div>
                                <button id="insertcomment" class="btn pull-right btn-success">등록</button>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
       </div>
        
	</c:otherwise>
		
	</c:choose>	
	
</body>


<!-- jquery 및 jquery ui -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<script type="text/javascript">
	
		/* ckindate
		ckoutdate
		res_h_rno
		res_personnel
		total_price */
	function CkReser(){
		if($("#ckindate").val().length==0){
			alert("체크인 날짜를 정해주세요");
			return false;
		}else if($("#ckoutdate").val().length==0){
			alert("체크아웃 날짜를 정해주세요");
			return false;
		}else if($("#res_h_rno").val() == 0){
			alert("예약하려는 방정보를 클릭해 주세요");
			return false;
		}else if($("#total_price").val() == 0){
			alert("예약하려는 방정보를 클릭해 주세요");
			return false;
		}else{
			$("#res_form").submit();
		}
	}
	
	function fnUpCount(h_no){
		$.ajax({
			url : "upbestcount.hotel",
			type : "post",
			data : {
				h_no : h_no
			},
			dataType :'json',
			success : function(bestcount){
				alert("추천되었습니다.")
				$("#bestcount").html(bestcount.bestcount+"명이 해당 호텔을 추천했습니다!");
			}
		})
	}
	
	
	
	function fngetCommentList(h_cno){
		$.ajax({
			type : "post",
			url : "getCommentList.hotel",
			data : {
				h_cno : h_cno
			},
			success : function(commentDto){
				var s= JSON.parse(commentDto);
				var sd= $(".commentList2").length+1;
				
				$("#commentList").append("<div>");
				$("#commentList").append("댓글번호 : "+sd +"<br>" );
				$("#commentList").append("제목 : "+s.subject+"<br>");
				$("#commentList").append("내용 : "+s.content+"<br>");
				$("#commentList").append("작성날짜 : "+s.regdate+"<br>");
				$("#commentList").append("추천수 : "+s.bestcount+"<br><br>");
				$("#commentList").append("</div>");
				
				$("#comment_subject").val("");
				$("#comment_content").val("");
				
			},
			error : function(errorList){
				console.log(errorList);
			} 
		})
	}
	
			$(function(){
				
			$("#insertcomment").on("click",function(){
				var comment = new Object();
				comment.h_no = ${h_no};
				comment.user_no = ${udto.user_no};
				comment.subject = $("#comment_subject").val();
				comment.content = $("#comment_content").val();
				if(comment.subject == "" || comment.content == ""){
					alert("댓글 제목이나 내용이 미입력되었습니다.");
					return false;
				}
				comment.regdate = null;
				comment.bestcount = 0;
				
				// JSON.stringify()는 json을 String으로 변경시켜주는 것
				var commentJson = JSON.stringify(comment);
				
				
				 $.ajax({
					type : "post",
					url : "insertcomment.hotel",
					data : {
						commentJson : commentJson
					},
					dataType :'json',
					success : function(successcomment){
						alert("댓글을 달았습니다.");
						var h_cno = parseInt(successcomment.h_cno);
						fngetCommentList(h_cno);
					},
					error : function(errorList){
					} 
				}); 
			})
			
			// 나중에 주말가 주중가 구분하여 계산하는 식 작성 현재는 주중가로 취급
			var total_price;
			var ckin_date="";
			//날짜 -> 숫자 변환시 임시로 담을 저장소 
			
			
			
			/*jquery ui (예약날짜관련)*/
			var ckdate;	//날짜계산시 이용
			var enddate;
			var day;	// <-  두날짜 차이 계산값
			var weekend_price; /// ajax에서 가져올값
			
			minDate = new Date();
		      $("#ckindate").datepicker({
		         showAnim: 'drop',
		         numberOfMonth: 1,
		         minDate: minDate,
		         dateFormat:'yy-mm-dd',
		         onClose:function(selectedDate){
		            $('#ckin').datepicker("option","minDate",selectedDate);
		            ckdate = selectedDate	
		            /*  selectedDate는 String타입! Date타입으로 변환이필요*/
		            var date = ckdate.split("-");	// -단위 date를 짜름 차례대로 
		            var year = date[0];
		            var month = date[1];
		            var day = date[2];
		            ckdate = new Date(year,month,day);
		            // 총가격을 구하기위한 처리
		             //ckdate = new date(selectedDate);	//date타입으로 생성
		         }
		      });
		      
		      $("#ckoutdate").datepicker({
		         showAnim: 'drop',
		         numberOfMonth: 1,
		         minDate: minDate,
		         dateFormat:'yy-mm-dd',
		         onClose:function(selectedDate){
		            $('#ckout').datepicker("option","maxDate",selectedDate);
		             enddate = selectedDate;	//date타입으로 생성
		            	
		             var date = enddate.split("-");	// -단위 date를 짜름 차례대로 
			         var year = date[0];
			         var month = date[1];
			         var day = date[2];
			         
			         enddate = new Date(year,month,day);
			            
		          	 day = (enddate.getTime() - ckdate.getTime()) /(1000*60*60*24);
		          	$("#total_price").val(day*weekend_price);	//총가격을 input값으로 넣어줌
					$("#total_priceSpan").html(day*weekend_price);	//총가격을 보여줄 span영역
		         }
		      });
		/* jquery ui (예약날짜관련 종료)*/
			
			// forEach 반복마다 h_rno값을 셋팅해놓았습니다. 밑에 ajax(방정보)와 예약시에 사용합니다.
			var h_no = ${h_no};
			var h_rno = ${h_rno};
			
			
			
			$(".roomMainImg img").on("click",function(){
				var roomInfo = $("#roomInfo2");
				
				<%-- ajax Json방식으로 주고받을때 ... 연구중 삭제 하셔도됩니다!~
				var obj = new Object;
				var h_rno = ${h_rno};
				json.h_rno = h_rno;
				var jsonData = JSON.stringify(json)--%>
					
					$.ajax({
						type : "post",
						url : "BringRoomSubImg.hotel",
						data : {
							h_rno : h_rno
						},
						dataType :'json',
						
						success : function(roomsubimg){
							
							//서브이미지넣는 
							var imgpath = roomsubimg.imgpath;
							var imgname = roomsubimg.imgname.split(',');
							$("#img1").html("<img src='hotel/"+imgpath+imgname[0]+"'>");
							$("#img2").html("<img src='hotel/"+imgpath+imgname[1]+"'>");
							$("#img3").html("<img src='hotel/"+imgpath+imgname[2]+"'>");
							$("#img4").html("<img src='hotel/"+imgpath+imgname[3]+"'>");
							$("#img5").html("<img src='hotel/"+imgpath+imgname[4]+"'>");
							//위에 작업이후 roomInfo가 필요하다는걸 느껴서 변수는 그냥 roomsubimg로 통일했습니다. -> 실제로는 room정보도 같이넘어옵니다~
							//action참고
							//방정보넣는곳
							/* roomInfo.html("침대개수 : "+roomsubimg.bed);
							roomInfo.append("화장실개수 : "+roomsubimg.bathroom);
							roomInfo.append("방의 갯수 : "+roomsubimg.roomsize+"<br>");
							roomInfo.append("<h2>주중가 : "+roomsubimg.weekprice+"</h2><br>");
							roomInfo.append("<h2>주말가 : "+roomsubimg.weekend_price+"</h2>");
 */							
							//예약관련 정보넣는곳
							$("#reservation #price").html("현재 선택하신 숙소의 주중가:"+roomsubimg.weekprice+"원,<br>");
							$("#reservation #price").append("주말가는 : "+roomsubimg.weekend_price+"원 입니다.<br>");
							weekend_price = parseInt(roomsubimg.weekend_price); //String -> Int값 변경
							
							
							var roomsize = roomsubimg.roomsize;
							
							if(roomsize == "싱글"){
								$("#reservation [name='personnel']").html("<option value='1'>1명</option>");
								$("#reservation [name='personnel']").append("<option value='2'>2명</option>");
							}else if(roomsize == "더블" || roomsize == "트윈"){
								$("#reservation [name='personnel']").html("<option value='1'>1명</option>");
								$("#reservation [name='personnel']").append("<option value='2'>2명</option>");
								$("#reservation [name='personnel']").append("<option value='3'>3명</option>");
								$("#reservation [name='personnel']").append("<option value='4'>4명</option>");
							}else {
								$("#reservation [name='personnel']").html("<option value='1'>1명</option>");
								$("#reservation [name='personnel']").append("<option value='2'>2명</option>");
								$("#reservation [name='personnel']").append("<option value='3'>3명</option>");
								$("#reservation [name='personnel']").append("<option value='4'>4명</option>");
								$("#reservation [name='personnel']").append("<option value='5'>5명</option>");
								$("#reservation [name='personnel']").append("<option value='6'>6명</option>");
							}
							
							/* 예약관련 type이 hidden 곳에 value값 셋팅하는곳*/
							$("#reservation [name='h_rno']").val(roomsubimg.h_rno);
							
						},
						error : function(err){
							alert("에러");
						}
						
					});
			});
			
			
		});
	
	</script>
</html>
<%@page import="dto.UserManagementDTO"%>
<%@page import="hotel.dto.HotelDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>호텔메인</title>

<style>
#mainTag {text-align: center;
      color:red;
      }
#happy {
	padding-left: 450px;
}     

</style>

<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script>


function PageMove(page){
    location.href = "HotelMain.hotel?page="+page;
}


</script>

</head>
<body>

	<jsp:include page="/header.jsp" />
	<jsp:include page="/sidevar.jsp" />
	
<c:set var="list" value="${requestScope.list }"></c:set>

<c:choose>
	<c:when test="${list == null }">
		<h2>아직 등록된 호텔이 없습니다. 호텔을 등록해주세요↓↓↓</h2>
		<a href="../InsertHotelForm.hotel">호텔등록</a>
	
	</c:when>
	
	<c:otherwise>



<%-- 마지막에 최근등록순, 별점높은순, 댓글갯수 많은순 등등으로 설정--%>
		<div id="fh5co-main">
		<div id ="mainTag">
	<c:if test="${user_email != null }">
	<a href="InsertHotelForm.hotel" margin="10px auto;">&nbsp;&nbsp; 호텔 등록 페이지로 가기</a>
	</c:if>
	<c:if test="${user_email == null }">
	로그인 후 이용해주시기 바랍니다.
	</c:if>
</div>
			<div class="fh5co-narrow-content">
				<div class="row animate-box" data-animate-effect="fadeInLeft">
		<c:forEach var = "HotelDTO" items="${requestScope.list}" step="1">
		
					<%-- 호텔설명을 간략히 보여줌 --%>
		
					<div class="col-md-3 work-item">
						<a href="HotelDetail.hotel?h_no=${HotelDTO.h_no }" target="_blank">
							<img src="hotel/${HotelDTO.h_imgpath}${HotelDTO.h_imgname}" alt="" class="img-responsive">
							<h3 class="fh5co-work-title">${HotelDTO.h_name } </h3> 
							<%-- <h5>${HotelDTO.h_content } <h5> --%>
							<p>추천수 : ${HotelDTO.h_bestcount }</p>
						</a>
					</div>
						
			
		
	
		</c:forEach>
				</div>
			</div>
		</div>	
		
<div class="toolbar-bottom container" id="happy">
  <div class="toolbar mt-lg">
    <div class="sorter">
      <ul class="pagination">
        <li><a href="javascript:PageMove(${paging.firstPageNo})">처음</a></li>
        <li><a href="javascript:PageMove(${paging.prevPageNo})">이전</a></li>
        	<c:forEach var="i" begin="${paging.startPageNo}" end="${paging.endPageNo}" step="1">
                  <c:choose>
                      <c:when test="${i eq paging.pageNo}">
                <li class="active"><a href="javascript:PageMove(${i})">${i}</a></li>
                      </c:when>
                      <c:otherwise>
                        <li><a href="javascript:PageMove(${i})">${i}</a></li>
                      </c:otherwise>
                  </c:choose>
             </c:forEach>     
        <li><a href="javascript:PageMove(${paging.nextPageNo})">다음</a></li>
        <li><a href="javascript:PageMove(${paging.finalPageNo})">마지막</a></li>
      </ul>
    </div>
  </div>
</div>


	</c:otherwise>

</c:choose>	

<jsp:include page="/footer.jsp" />

<script src="js/modernizr-2.6.2.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-alpha/js/bootstrap.min.js"></script>
	<script
		src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
		
		
	
	
</body>
</html>
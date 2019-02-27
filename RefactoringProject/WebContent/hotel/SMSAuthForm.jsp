<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <%
 	//인증번호를 랜덤으로 만든다
 	String RandomAuthNumber = ""; 
 	for(int i=0; i<6; i++)
 	RandomAuthNumber += (int)(Math.random()*9+1);
 	//카페24에서 값을 처리할떄 (Proc)페이지는 요청값을 전부 null로 바꾼뒤 처리한다 때문에 session영역에 Random을 저장해서 처리--
 	session.setAttribute("RandomAuthNumber", RandomAuthNumber);
 %>
 
 <style>
 
 	#sendPhoneList{
 		left: -9999px; 		
 	}
 </style>
 <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
 
 	<script type="text/javascript">
 	
            function setPhoneNumber(val) {
                var numList = val.split("-");
                document.smsForm.sphone1.value = numList[0];
                document.smsForm.sphone2.value = numList[1];
            if(numList[2] != undefined){
                    document.smsForm.sphone3.value = numList[2];
        }
            }

            function loadJSON() {
                var data_file = "calljson.jsp";
                var http_request = new XMLHttpRequest();
                try {
                    // Opera 8.0+, Firefox, Chrome, Safari
                    http_request = new XMLHttpRequest();
                } catch (e) {
                    // Internet Explorer Browsers
                    try {
                        http_request = new ActiveXObject("Msxml2.XMLHTTP");

                    } catch (e) {

                        try {
                            http_request = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (e) {
                            // Eror
                            alert("지원하지 않는브라우저!");
                            return false;
                        }

                    }
                }
                http_request.onreadystatechange = function() {
                    if (http_request.readyState == 4) {
                        // Javascript function JSON.parse to parse JSON data
                        var jsonObj = JSON.parse(http_request.responseText);
                        if (jsonObj['result'] == "Success") {
                            var aList = jsonObj['list'];
                            var selectHtml = "<select name=\"sendPhone\" onchange=\"setPhoneNumber(this.value)\">";
                            selectHtml += "<option value='' selected>발신번호를 선택해주세요</option>";
                            for (var i = 0; i < aList.length; i++) {
                                selectHtml += "<option value=\"" + aList[i] + "\">";
                                selectHtml += aList[i];
                                selectHtml += "</option>";
                            }
                            selectHtml += "</select>";
                            document.getElementById("sendPhoneList").innerHTML = selectHtml;
                        }
                    }
                }

                http_request.open("GET", data_file, true);
                http_request.send();
            }
        </script>
</head>
<body>
	
        
   

	<!-- 필요없는것들 지울려고했는데 지우면 안된다. 그냥 다 hidden처리해서 안보이게했다. -->
    <body onload="loadJSON()">
    <form method="post" name="smsForm" action="SMSAuthProc.jsp" id="phoneAuth">
    	<%-- 인증번호를 히든으로보내줌 --%>
    	
        <input type="hidden" name="action" value="go"> 
        <input type="hidden" name="authNumberValue" value=<%=RandomAuthNumber %>>
        <span>
          <input type="hidden" name="smsType" value="S"></span>
        <span>
          <input type="hidden" name="smsType" value="L"></span>
        <br /> 
        <input type="hidden" name="subject" value="인증번호요청입니다!">
        <br /> 
       <input type="hidden" name="msg" value=<%=RandomAuthNumber%>>
        <br />
        <br />
        <br />받는 번호 -붙여주세요 꼭!
        <input type="text" name="rphone" value="" id="rphone">   <input type="submit" value="전송" >
        <br />
        <input type="hidden" name="destination" value="" size=80>
        <br /> 
        <input type="hidden" name="sphone1" value="010">
        <input type="hidden" name="sphone2" value="3453">
        <input type="hidden" name="sphone3" value="0091">
        <span id="sendPhoneList"></span>
        <br />
        <input type="hidden" name="rdate" maxlength="8"> 
        <br />
        <input type="hidden" name="rtime" maxlength="6"> 
        <br />
        <input type="hidden" name="returnurl" maxlength="64" value="">
        <br /> 
        <input type="hidden" name="testflag" maxlength="1"> 
        <br />
        <input type="hidden" name="nointeractive" maxlength="1"> 
        <br />
        <input type="hidden" name="repeatFlag" value="Y">
        <br /> 
        
       
    </form>
	
	
</body>
</html>
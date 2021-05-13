<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#check").click(function(){
		if($("#check").prop("checked")){
			$("input[name=selectcheck]").prop("checked",true);
		}else{
			$("input[name=selectcheck]").prop("checked",false);
		}
	})
	
})
</script>
<script type="text/javascript">

function checkdel(){
	console.log("length: " + $("input:checkbox[name=selectcheck]:checked").length);
	var a=new Array();
	
	var check=$("input[name=selectcheck]:checked");
	var count=$("input:checkbox[name=selectcheck]:checked").length;
	if(count==0){
		
		alert("삭제할 게시글을 골라주세요.");
		console.log(count);
		return;
	}else{
	check.each(function(i){
		
		var tr=check.parent().parent().eq(i);
		var td=tr.children();
		var num=td.eq(1).text()
		a.push(num);
		
	})
	var check={"check":a};
	}
	
	//3차
	////jQuery.ajaxSettings.traditional = true;
	
	//2차
	/*$.ajax({
		url:"./freeBoardDelCheck.ino",
		type:"POST",
		data:{'ArrayCheckbox':a},
		success:function(data){
			alert("옴");
		}
	})*/
	
	
	 $.ajax({
		url:"./freeBoardDelCheck.ino",
		type:"POST",
		traditional:true,
		data:{'ArrayCheckbox':a},
		success:function(data){
			 if (data.num == 1) {
				alert('삭제되었습니다.');
				location.href = './main.ino';
			} else {
				alert('삭제 실패하였습니다.');
				location.href = './main.ino'
			} 
		}
		
	}) 
}

//한글 제어 이상함 두글자는 쳐짐
/* function numberCheck(){
	if((event.keyCode < 48) || (event.keyCode>57)){
       	console.log("???")
       	event.returnValue=false;
    }
    
	
}

function numberPress(obj){
	if(event.keyCode==8 || event.keyCode==9 || event.KeyCode == 37 || event.keyCode==39 ||event.keyCode==46)
	 return;
	
	obj.value=obj.value.replace(/[\ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g,'');
	
} */

function itemchange(){
	var selectitem=$('#select').val();
	var str='<input type="text" name="select1" id="name"/>';
	var str1='<select name="select1" id="codeType">';
	<c:forEach var="commonlist" items="${freeBoardCommonList }">
	<c:if test="${commonlist.GR_CODE=='GR001'}">
	str1 += '<option value="${commonlist.CODE}">';
	str1 += '${commonlist.CODE_NAME}';
	</c:if>
	str1 += '</option>';
	</c:forEach>
	str1 += '</select>'
	var str2='<input type="text" name="select1" id="content"/>';
	var str3='<input type="text" name="select1" id="title"/>';
	var str4='<input type="text" name="select1" id="num" placeholder="숫자로만 입력하세요" onkeyup="this.value=this.value.replace(/[^0-9]/g,\'\');"  />';
	var str5='<input type="text" name="select2" id="regdate1"  placeholder="숫자로만 입력하세요" onkeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" />';
	str5 += '~';
	str5 += '<input type="text" name="select3"  id="regdate2"   placeholder="숫자로만 입력하세요" onkeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" />';
	
	
	switch(selectitem){
	
	case '0':
		$('#new').empty();
		break;
	case '1':
		$('#new').empty();
		console.log("1번작동");
		document.getElementById("new").innerHTML = str1;	
		break;
	case '2':
		$('#new').empty();
		console.log("2번작동");
		document.getElementById("new").innerHTML = str;
		break;
	case '3':
		$('#new').empty();
		console.log("3번작동");
		document.getElementById("new").innerHTML = str2;
		break;
	case '4':
		$('#new').empty();
		console.log("4번작동");
		document.getElementById("new").innerHTML = str3;
		break;
	case '5':
		$('#new').empty();
		console.log("5번작동");
		document.getElementById("new").innerHTML = str4;
		break;
	case '6':
		$('#new').empty();
		console.log("6번작동");
		document.getElementById("new").innerHTML = str5;
		break;
	default:
		break;
	}
}
function caseselect(n){
	var data=$('#selectform').serialize()+"&temp="+n;
	//&& ( !$('#regdate1').val().length==8 || !$('#regdate2').val().length==8)
	var pattern = /(^(19|20)\d{2})(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])$/;
	 if($('#select').val() == 6 && ( pattern.test($('#regdate1').val())==false || pattern.test($('#regdate1').val())==false) ){
		alert("날짜형식에 맞춰주세요. YYYYMMDD");
		
		return false;
	}else{
		//console.log(pattern.test($('#regdate1').val()));
	$.ajax({
		url:"./freeBoardselect.ino",
		type:"POST",
		data:data,
		success: function(data) {
			$('#tb').empty();
			var result=data.list;
			console.log(data.page);
			var str = '<tr>';
			$.each(result , function(i){
				str+= '<td style="width: 55px; padding-left: 30px;" align="center"><input type="checkbox" name="selectcheck" id="selectcheck" value="true" />' +result[i].codeType+'</td>';
				str+= '<td style="width: 50px; padding-left: 10px;" align="center">' + result[i].num + '</td>';
				str+= '<td style="width: 125px; "" align="center"><a href="./freeBoardDetail.ino?num='+ result[i].num +'">' + result[i].title + '</td>';
				str+= '<td style="width: 48px; padding-left: 50px;" align="center">' + result[i].name + '</td>';
				str+= '<td style="width: 100px; padding-left: 95px;" align="center">' + result[i].regdate + '</td>';
				str+= '</tr>';		
			});
			$('#tb').append(str);
			$('#paging').empty();
			$('#paging').append(data.page);
			

		}
	})
	}
}

</script>
</head>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
<form id="selectform" onsubmit="return false;">
	<div style="margin-left:40%;">
		<select id="select" name="select" onchange="itemchange()" style="float:left;" >
			<option value="0">전체</option>
				<c:forEach var="commonlist" items="${freeBoardCommonList }">
					<c:if test="${commonlist.GR_CODE=='GR002'}">
					<option value="${commonlist.CODE }">${commonlist.CODE_NAME }</option>
					</c:if>
				</c:forEach>
		</select>
		<div id="new" style="float:left;">
		
		</div>
		
		<button style="float:left;" onclick="caseselect(1)">검색</button>
	</div>
	</form>
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				
				<tr>
					<td style="width: 55px; padding-left: 30px;" align="center">
					<input type="checkbox"  name="check" id="check" value="allcheck">타입</td>
					<td style="width: 50px; padding-left: 10px;" align="center">글번호</td>
					<td style="width: 125px;" align="center">글제목</td>
					<td style="width: 48px; padding-left: 50px;" align="center">글쓴이</td>
					<td style="width: 100px; padding-left: 95px;" align="center">작성일시</td>
				</tr>
				
			</thead>
		</table>
	</div>
	<hr style="width: 600px;">
	
	<div>
		<table border="1">
			<tbody id="tb">
					<c:forEach var="dto" items="${freeBoardList }">
						<tr>
							<td style="width: 55px; padding-left: 30px;" align="center">
							<input type="checkbox" name="selectcheck" id="selectcheck" value="true" />${dto.codeType }</td>
							<td style="width: 50px; padding-left: 10px;" align="center">${dto.num }</td>
							<td style="width: 125px; "" align="center"><a href="./freeBoardDetail.ino?num=${dto.num }">${dto.title }</a></td>
							<td style="width: 48px; padding-left: 50px;" align="center">${dto.name }</td>
							<td style="width: 100px; padding-left: 95px;" align="center">${dto.regdate }</td>
						<tr>
					</c:forEach>
			</tbody>
		</table>
		<div id="paging">
		${pagination}
		</div>
		<input style="float:right; margin-right:25px;" type="button" value="삭제" onclick="checkdel(n)"/>
	</div>

</body>
</html>
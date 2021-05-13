<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	/* 
	 동기방식 submit시 onsubmit함수 onsubmit="return check()"
	 function check(){
	 if(!document.f_board.name.value){
	 alert("이름을 입력해주세요.");
	 return false;
	 }
	 if(!document.f_board.title.value){
	 alert("제목을 입력해주세요.");
	 return false;
	 }
	 if(!document.f_board.content.value){
	 alert("내용을 입력해주세요.");
	 return false;
	 }
	
	 } */
	function check() {
		if (!document.f_board.name.value) {
			alert("이름을 입력해주세요.");
			return false;
		}
		if (!document.f_board.title.value) {
			alert("제목을 입력해주세요.");
			return false;
		}
		if (!document.f_board.content.value) {
			alert("내용을 입력해주세요.");
			return false;
		}

		
				$.ajax({
					url : './freeBoardInsertPro.ino',
					type : 'POST',
					data : $('#form').serialize(),
					success : function(data) {
						console.log(data.check);
						if (data.check ==true) {

							alert('글쓰기성공');
							var btn;
							btn = confirm('메인으로 돌아가시겠습니까?');
							if (btn) {
								location.href = './main.ino';
							} else {
								location.href = './freeBoardDetail.ino?num='+ data.num;
							}
						} else {
							alert("글쓰기 실패" + data.error);
						}
					}
				});
	}

	/* function ok(){
	 alert('전송이 완료되었습니다.');
	 var btn;
	 btn = confirm("메인으로 돌아가시겠습니까?");
	 if(btn){
	 location.href="./main.ino"
	 }else{
	 location.href="./freeBoardDetail.ino"
	 }
	 } */
</script>
</head>

<body>
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width: 650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">
	<!-- action="./freeBoardInsertPro.ino" -->
	<form name="f_board" method="post" id="form">
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
					<select name="codeType">
						<c:forEach var="commonlist" items="${freeBoardCommonList }">
							<c:if test="${commonlist.GR_CODE=='GR001'}">
								<option value="${commonlist.CODE }">${commonlist.CODE_NAME }</option>
							</c:if>
						</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" /></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title" /></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25"
							cols="65"></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right"><input type="button" value="글쓰기"
						onclick="check()"> <input type="button" value="다시쓰기"
						onclick="reset()"> <input type="button" value="취소"
						onclick=""> &nbsp;&nbsp;&nbsp;</td>
				</tr>
			</tfoot>
		</table>

	</form>



</body>
</html>
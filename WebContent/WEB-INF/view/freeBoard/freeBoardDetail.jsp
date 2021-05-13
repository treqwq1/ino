<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script>
console.log(${freeBoardDto.codeType});
	function modify() {
		if (!document.insertForm.title.value) {
			alert('제목을 입력해주세요.')
		}
		if (!document.insertForm.content.value) {
			alert('내용을 입력해주세요.')
		}

		$.ajax({
			url : './freeBoardModify.ino',
			type : 'POST',
			data : $('#insertForm').serialize(),
			success : function(data) {
				if (data.num == 1) {

					alert('수정 성공하였습니다.');
					var btn;
					btn = confirm('머무르시겠습니까? 취소시 메인으로');
					if (btn) {
						location.href = './freeBoardDetail.ino?num=' + data;

					} else {
						location.href = './main.ino';
					}
				}else{
					alert('수정 실패' + data.error);
				}

			}

		})

	}
	//location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'
	function deleteBoard() {
		console.log($("#num").val())
		$.ajax({
			url : './freeBoardDelete.ino',
			type : 'POST',
			data : {
				"n" : $("#num").val()
			},
			success : function(data) {
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
	<form name="insertForm" id="insertForm">
		<input type="hidden" name="num" id="num" value="${freeBoardDto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;"><select>
							<option value="01"
								<c:if test="${freeBoardDto.codeType eq 1}">selected</c:if>>자유</option>
							<option value="02"
								<c:if test="${freeBoardDto.codeType eq 2}">selected</c:if>>익명</option>
							<option value="03"
								<c:if test="${freeBoardDto.codeType eq 3}">selected</c:if>>QnA</option>
					</select></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name"
						value="${freeBoardDto.name }" readonly /></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"
						value="${freeBoardDto.title }" /></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25"
							cols="65">${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
						<td align="right">
						<input type="button" value="수정"
						onclick="modify()"> 
						<input type="button" value="삭제"
						onclick="deleteBoard()"> 
						<input type="button" value="취소"
						onclick="location.href='./main.ino'"> 
						&nbsp;&nbsp;&nbsp;</td>
				</tr>
			</tfoot>
		</table>

	</form>


	<%-- 	<input type="hidden" name="num" value="${freeBoardDto.num }" />

		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></div>

		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"  value="${freeBoardDto.title }"/></div>

		<div style="width: 150px; float: left;">작성날자</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${freeBoardDto.regdate }"/></div>

		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></div>
		<div align="right">
		<input type="button" value="수정" onclick="modify()">
		<input type="button" value="삭제" onclick="location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'">

		<input type="button" value="취소" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div> --%>

</body>
</html>
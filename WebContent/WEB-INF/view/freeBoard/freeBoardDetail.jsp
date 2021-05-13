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
			alert('������ �Է����ּ���.')
		}
		if (!document.insertForm.content.value) {
			alert('������ �Է����ּ���.')
		}

		$.ajax({
			url : './freeBoardModify.ino',
			type : 'POST',
			data : $('#insertForm').serialize(),
			success : function(data) {
				if (data.num == 1) {

					alert('���� �����Ͽ����ϴ�.');
					var btn;
					btn = confirm('�ӹ����ðڽ��ϱ�? ��ҽ� ��������');
					if (btn) {
						location.href = './freeBoardDetail.ino?num=' + data;

					} else {
						location.href = './main.ino';
					}
				}else{
					alert('���� ����' + data.error);
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
					alert('�����Ǿ����ϴ�.');
					location.href = './main.ino';
				} else {
					alert('���� �����Ͽ����ϴ�.');
					location.href = './main.ino'
				}

			}
		})
	}
</script>
</head>
<body>

	<div>
		<h1>�����Խ���</h1>
	</div>
	<div style="width: 650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">
	<form name="insertForm" id="insertForm">
		<input type="hidden" name="num" id="num" value="${freeBoardDto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
					<td style="width: 400px;"><select>
							<option value="01"
								<c:if test="${freeBoardDto.codeType eq 1}">selected</c:if>>����</option>
							<option value="02"
								<c:if test="${freeBoardDto.codeType eq 2}">selected</c:if>>�͸�</option>
							<option value="03"
								<c:if test="${freeBoardDto.codeType eq 3}">selected</c:if>>QnA</option>
					</select></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name"
						value="${freeBoardDto.name }" readonly /></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title"
						value="${freeBoardDto.title }" /></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" rows="25"
							cols="65">${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
						<td align="right">
						<input type="button" value="����"
						onclick="modify()"> 
						<input type="button" value="����"
						onclick="deleteBoard()"> 
						<input type="button" value="���"
						onclick="location.href='./main.ino'"> 
						&nbsp;&nbsp;&nbsp;</td>
				</tr>
			</tfoot>
		</table>

	</form>


	<%-- 	<input type="hidden" name="num" value="${freeBoardDto.num }" />

		<div style="width: 150px; float: left;">�̸� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></div>

		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"  value="${freeBoardDto.title }"/></div>

		<div style="width: 150px; float: left;">�ۼ�����</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${freeBoardDto.regdate }"/></div>

		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></div>
		<div align="right">
		<input type="button" value="����" onclick="modify()">
		<input type="button" value="����" onclick="location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'">

		<input type="button" value="���" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div> --%>

</body>
</html>
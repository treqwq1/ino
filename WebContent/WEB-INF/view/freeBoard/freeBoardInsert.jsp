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
	 ������ submit�� onsubmit�Լ� onsubmit="return check()"
	 function check(){
	 if(!document.f_board.name.value){
	 alert("�̸��� �Է����ּ���.");
	 return false;
	 }
	 if(!document.f_board.title.value){
	 alert("������ �Է����ּ���.");
	 return false;
	 }
	 if(!document.f_board.content.value){
	 alert("������ �Է����ּ���.");
	 return false;
	 }
	
	 } */
	function check() {
		if (!document.f_board.name.value) {
			alert("�̸��� �Է����ּ���.");
			return false;
		}
		if (!document.f_board.title.value) {
			alert("������ �Է����ּ���.");
			return false;
		}
		if (!document.f_board.content.value) {
			alert("������ �Է����ּ���.");
			return false;
		}

		
				$.ajax({
					url : './freeBoardInsertPro.ino',
					type : 'POST',
					data : $('#form').serialize(),
					success : function(data) {
						console.log(data.check);
						if (data.check ==true) {

							alert('�۾��⼺��');
							var btn;
							btn = confirm('�������� ���ư��ðڽ��ϱ�?');
							if (btn) {
								location.href = './main.ino';
							} else {
								location.href = './freeBoardDetail.ino?num='+ data.num;
							}
						} else {
							alert("�۾��� ����" + data.error);
						}
					}
				});
	}

	/* function ok(){
	 alert('������ �Ϸ�Ǿ����ϴ�.');
	 var btn;
	 btn = confirm("�������� ���ư��ðڽ��ϱ�?");
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
		<h1>�����Խ���</h1>
	</div>
	<div style="width: 650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">
	<!-- action="./freeBoardInsertPro.ino" -->
	<form name="f_board" method="post" id="form">
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
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
					<td style="width: 150px;" align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name" /></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title" /></td>
				</tr>
				<tr>
					<td style="width: 150px;" align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" rows="25"
							cols="65"></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right"><input type="button" value="�۾���"
						onclick="check()"> <input type="button" value="�ٽþ���"
						onclick="reset()"> <input type="button" value="���"
						onclick=""> &nbsp;&nbsp;&nbsp;</td>
				</tr>
			</tfoot>
		</table>

	</form>



</body>
</html>
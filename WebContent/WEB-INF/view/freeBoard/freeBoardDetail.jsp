<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>Insert title here</title>
</head>
<body>

	<div>
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">

	<form name="insertForm">
		<input type="hidden" name="num" id="num" value="${freeBoardDto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
					<td style="width: 400px;">
						<select id="code_type">
							<option value="01"<c:if test="${freeBoardDto.codeType eq '����'}">selected="selected"</c:if>>����</option>
							<option value="02"<c:if test="${freeBoardDto.codeType eq '�͸�'}">selected="selected"</c:if>>�͸�</option>
							<option value="03"<c:if test="${freeBoardDto.codeType eq 'QNA'}">selected="selected"</c:if>>QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" id="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="����" onclick="modify()">
					<input type="button" value="����" onclick="board_delete()">
					<input type="button" value="���" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
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
<script type="text/javascript">
	
	function modify(){
		if($("#title").val()==""){
			alert("������ �Է� ���ּ��� !");
			$("#title").focus();
		}else if($("#content").val() == ""){
			alert("���� �� �Է� ���ּ���");
			$("#content").focus();
		}else {
			$.ajax({
				url : './freeBoardModify.ino',
				type : 'POST',
				data : {
					num : $("#num").val(),
					codeType : $("#code_type").val(),
					title : $("#title").val(),
					content : $("#content").val()
				},
				success : function(data){
					if(data.result == true){
						if(confirm("���� �������� �̵� �Ͻðڽ��ϱ� ? ")== true){
							alert("������������ �̵� �մϴ�.");
							location.href = './main.ino';
						}else{
							alert("���� �������� �̵��մϴ�.");
							location.href="./freeBoardDetail.ino?num="+data.num;
						}
					}else{
						alert("���� �ڵ�  : "+data.error);
					}
				}
			})
		}
		
	}
	function board_delete(){
		if(confirm("���� �Ͻðڽ��ϱ� ?") == true){
			$.ajax({
				url : './freeBoardDelete.ino',
				type : 'POST',
				data : {
					num : $("#num").val()
				},
				
				success : function(data){
					
					if(data.result == true){
						alert("�Խù��� ���� �Ǿ����ϴ�.");
						location.href = './main.ino';
					}else{
						alert("���� �ڵ� : "+data.error);
						
					}
				}
			});
		}else{
			alert("������ ��� �ϼ̽��ϴ�.");
		}
	}
</script>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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

	<form action="./freeBoardInsertPro.ino">

		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
					<td style="width: 400px;">
						<select id="code_type">
							<option value="01">����</option>
							<option value="02">�͸�</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" id="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="�۾���" onclick="board_write()">
					<input type="button" value="�ٽþ���" onclick="reset()">
					<input type="button" value="���" onclick="">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>
</body>
<script type="text/javascript">
	function board_write() {
		if($("#name").val()== ""){
			alert("�̸��� �����ּ���");
			$("#name").focus();
		}else if($("#title").val()==""){
			alert("������ ���� �ּ���");
			$("#title").focus();
		}else if($("#content").val() == ""){
			alert("������ ���� �ּ���");
			$("#content").focus();
		}else{
			$.ajax({
				url : './freeBoardInsertPro.ino',
				type : 'POST',
				data : {
					codeType : $("#code_type").val() ,
					name : $("#name").val(),
					title : $("#title").val(),
					content : $("#content").val(),
					
 				},
				success : function(data){
					if(data.result == true){
						if(confirm("������������ �̵� �Ͻðڽ��ϱ�?") == true){
							alert("������������ �̵� �մϴ�.");
							location.href="./main.ino"
						}else{
							alert("���� �������� �̵��մϴ�.");
							location.href="./freeBoardDetail.ino?num="+data.num;
						}
							
					}else{
						alert("�۾��⿡ �����߽��ϴ�.");
						
					}
				}
			});
			
		}
	}
</script>

</html>
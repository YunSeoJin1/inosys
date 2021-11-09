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
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form action="./freeBoardInsertPro.ino">

		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select id="code_type">
							<option value="01">자유</option>
							<option value="02">익명</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" id="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="글쓰기" onclick="board_write()">
					<input type="button" value="다시쓰기" onclick="reset()">
					<input type="button" value="취소" onclick="">
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
			alert("이름을 적어주세요");
			$("#name").focus();
		}else if($("#title").val()==""){
			alert("제목을 적어 주세요");
			$("#title").focus();
		}else if($("#content").val() == ""){
			alert("내용을 적어 주세요");
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
						if(confirm("메인페이지로 이동 하시겠습니까?") == true){
							alert("메인페이지로 이동 합니다.");
							location.href="./main.ino"
						}else{
							alert("수정 페이지로 이동합니다.");
							location.href="./freeBoardDetail.ino?num="+data.num;
						}
							
					}else{
						alert("글쓰기에 실패했습니다.");
						
					}
				}
			});
			
		}
	}
</script>

</html>
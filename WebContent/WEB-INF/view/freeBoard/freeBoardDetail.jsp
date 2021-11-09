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
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form name="insertForm">
		<input type="hidden" name="num" id="num" value="${freeBoardDto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select id="code_type">
							<option value="01"<c:if test="${freeBoardDto.codeType eq '자유'}">selected="selected"</c:if>>자유</option>
							<option value="02"<c:if test="${freeBoardDto.codeType eq '익명'}">selected="selected"</c:if>>익명</option>
							<option value="03"<c:if test="${freeBoardDto.codeType eq 'QNA'}">selected="selected"</c:if>>QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" id="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="수정" onclick="modify()">
					<input type="button" value="삭제" onclick="board_delete()">
					<input type="button" value="취소" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
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
<script type="text/javascript">
	
	function modify(){
		if($("#title").val()==""){
			alert("제목을 입력 해주세요 !");
			$("#title").focus();
		}else if($("#content").val() == ""){
			alert("내용 을 입력 해주세요");
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
						if(confirm("메인 페이지로 이동 하시겠습니까 ? ")== true){
							alert("메인페이지로 이동 합니다.");
							location.href = './main.ino';
						}else{
							alert("수정 페이지로 이동합니다.");
							location.href="./freeBoardDetail.ino?num="+data.num;
						}
					}else{
						alert("에러 코드  : "+data.error);
					}
				}
			})
		}
		
	}
	function board_delete(){
		if(confirm("삭제 하시겠습니까 ?") == true){
			$.ajax({
				url : './freeBoardDelete.ino',
				type : 'POST',
				data : {
					num : $("#num").val()
				},
				
				success : function(data){
					
					if(data.result == true){
						alert("게시물이 삭제 되었습니다.");
						location.href = './main.ino';
					}else{
						alert("에러 코드 : "+data.error);
						
					}
				}
			});
		}else{
			alert("삭제를 취소 하셨습니다.");
		}
	}
</script>
</html>
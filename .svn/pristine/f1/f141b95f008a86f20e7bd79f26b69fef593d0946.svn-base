<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div>
		<h1>코드등록</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./commonCode.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form action="./commonCodeInsert.ino">
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">그룹코드 :</td>
					<td style="width: 400px;">
						<select name="grCode">
							<c:forEach items="${list }" var="list">
								<option value="${list.GR_CODE }">${list.GR_NAME }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">코드 :</td>
					<td style="width: 400px;"><input type="text" name="code"/> ex) 01,02,03</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">코드명 :</td>
					<td style="width: 400px;"><input type="text" name="codeName"/> ex) 자유,익명,QnA</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">사용여부 :</td>
					<td style="width: 400px;"><input type="radio" id="usedY" name="used" value="Y" checked="checked"/>
						<label for="usedY">Y</label>
						<input type="radio" id="usedN" name="used" value="N"/>
						<label for="usedN">N</label>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="submit" value="글쓰기">
					<input type="button" value="다시쓰기" onclick="reset()">
					<input type="button" value="취소" onclick="">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>
	</form>



</body>
</html>
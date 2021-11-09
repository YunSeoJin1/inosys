<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- script 영역 -->
<script type="text/javascript">

</script>
</head>
<body>
	<div>
		<h1>공통코드 Main</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./commonCodeInsertGroup.ino">그룹코드등록</a>
		<a href="./commonCodeInsert.ino">코드등록</a>
	</div>

		<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				<tr>
					<td style="width: 55px; padding-left: 30px;" align="center">그룹코드</td>
					<td style="width: 125px; padding-left: 10px;" align="center">그룹코드명</td>
					<td style="width: 50px;" align="center">코드</td>
					<td style="width: 100px; padding-left: 50px;" align="center">코드명</td>
					<td style="width: 95px;" align="center">사용여부</td>
				</tr>
			</thead>
		</table>
	</div>
	<hr style="width: 600px;">
	
	<div>
		<table border="1">
			<tbody id="tb" name="tb">
				<c:choose>
					<c:when test="${fn:length(list) > 0}">
						<c:forEach var="dto" items="${list }">
							<tr>
								<td style="width: 55px; padding-left: 30px;" align="center">${dto.GR_CODE }</td>
								<td style="width: 125px; padding-left: 10px;" align="center">${dto.GR_NAME }</td>
								<td style="width: 50px;" align="center"><a href="./commonCodeDetail.ino?CODE=${dto.CODE }&GR_CODE=${dto.GR_CODE}">${dto.CODE }</a></td>
								<td style="width: 100px; padding-left: 50px;" align="center">${dto.CODE_NAME }</td>
								<td style="width: 95px;" align="center">${dto.USE_YN }</td>
							<tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
					<tr>
						<td colspan="5" align="center"> 조회된 데이터가 없습니다.</td>
					</tr>
					</c:otherwise>
				</c:choose>
					
			</tbody>
		</table>
	</div>

</body>
</html>
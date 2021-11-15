<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div id="search">
		<select id="selectBox" onChange="change_Menu()">
			<option value="0" selected="selected">전체</option>
			<c:forEach var="dto" items="${code_list}">
				<c:if test="${dto.GR_CODE == 'GR002'}">
					<option value="${dto.CODE}">
						${dto.CODE_NAME}
					</option>
				</c:if>
			</c:forEach>
			<!-- <option value="1">글타입</option>  selectBox 
			<option value="2">글번호</option>  input type text 대신 검색버튼클릭시 숫자체크
			<option value="3">글제목</option>  input type text 
			<option value="4">글내용</option> input type text
			<option value="5">글쓴이</option> input type text 
			<option value="6">기간</option>input type text - input type text 대신 검색버튼클릭시 숫자체크  자리수 체크 8자리 20210101
			 -->
		</select>
		<div id="search_menu">
			<input type='button' id='search_btn' value='검색' onClick='btn_click()'>
		</div>
		<!--  
		<select id="type_hidden" style="display: none">
			<option value="01" selected="selected">자유</option>
			<option value="02">익명</option>
			<option value="03">QNA</option>
		</select>
		<input id="text_hidden" type="text" style="display: none">
		<input id="text_hidden2" type="text" style="display: none">
		<input type="button" id="search_btn" value="검색">
		-->
	</div>
	
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				<tr>
					<td><input type="checkbox" id="all_check"> </td>
					<td style="width: 55px; padding-left: 30px;" align="center">타입</td>
					<td style="width: 50px; padding-left: 10px;" align="center">글번호</td>
					<td style="width: 125px;" align="center">글제목</td>
					<td style="width: 48px; padding-left: 50px;" align="center">글쓴이</td>
					<td style="width: 100px; padding-left: 95px;" align="center">작성일시</td>
				</tr>
			</thead>
		</table>
	</div>
	<hr style="width: 600px;">

<!-- 	<div id="board"> -->
	<form id="formname1" name="formname1">
		<table border="1">
			<tbody id="tb" name="tb">
					<c:forEach var="dto" items="${freeBoardList }">
						<tr>
							<td><input type="checkbox" name="check_box"  value="${dto.num} "></td>
							<td style="width: 55px; padding-left: 30px;" align="center">${dto.codeType }</td>
							<td style="width: 50px; padding-left: 10px;" align="center">${dto.num }</td>
							<td style="width: 125px; " align="center"><a href="./freeBoardDetail.ino?num=${dto.num }">${dto.title }</a></td>
							<td style="width: 48px; padding-left: 50px;" align="center">${dto.name }</td>
							<td style="width: 100px; padding-left: 95px;" align="center">${dto.regdate }</td>
						<tr>
					</c:forEach>
			</tbody>
			
		</table>
		<div>
			<table>
				<tr id="paginationBox" class="pagination">
				
						<td><a href="#" onclick="paging(1); return falsue">[처음]</a></td>
						<c:choose>
							<c:when test="${maxPage gt 10}">
								<c:forEach begin="${startPage}" end="${endPage}" var="index">
									<td><a href="#" onclick="paging(${index}); return false;">${index}</a></td>
								</c:forEach>
							</c:when>
							<c:otherwise>
							<c:forEach begin="${startPage}" end="${maxPage}" var="index">
									<td><a href="#" onclick="paging(${index}); return false;">${index}</a></td>
								</c:forEach>
							</c:otherwise>
						</c:choose>
							<c:if test="${endPage ne maxPage}">
								<td><a href='#' onclick='paging(${startPage}+10); return false'>[다음]</a></td>
							</c:if>
				</tr>
			</table>
		</div>
<!-- 	</div> -->
	<input type="button" value="삭제" onclick="check_delete()">
	</form>

</body>
<script>
$(document).ready(function(){
	$("#paginationBox a").click(function(e){
		var i = $("#paginationBox a").val();
		console.log(i);
	});
});
$(function(){
	var chkObj = document.getElementsByName("check_box");
	var rowCnt = chkObj.length;
	$("input[id='all_check']").click(function(){
		var chk_list = $("input[name='check_box']");
		for(var i = 0; i<chk_list.length; i++){
			chk_list[i].checked = this.checked;
		}
	});
	
});
function check_delete(){
	var checkArr = new Array();
	var check_list = $("input[name='check_box']");
	
		for(var i = 0 ; i<check_list.length ; i++){
			if(check_list[i].checked){
				console.log(check_list[i].value);
				checkArr.push(check_list[i].value);
				
			}
		}
		
		if(checkArr.length == 0){
			alert("선택된 글이 없습니다.");
			
		}
		else{
			console.log("선택된 글의 갯수 :"+checkArr.length);
			for(var i = 0 ; i<checkArr.length; i++){
				console.log(checkArr);
			}
			if(confirm("삭제 하시겠습니까?")== true){
				$.ajax({
					
					url : './freeBoardCheckDelete.ino',
					type : 'POST',
					
					traditional : true,
					data : {
						
						checkArr : checkArr
					},
					
					success : function(data){
						if(data.result == true){
							alert("삭제되었습니다.");
							location.reload();
						}
						else{
							alert("에러 코드 : "+ data.error);
						}
					}
				});
			}else{
				alert("삭제가 취소 되었습니다.")
			}
			
			
		}
	
};
function change_Menu(){
	var input = $("#selectBox option:selected").val();
	var html = "";
	if(input == '0'){
		html += "<div id='search_menu'>";
		html += "<input type='button' id='search_btn' value='검색' onClick='btn_click()'>";
		html += "</div>";
		$("#search_menu").html(html);
	}
	else if(input == '1'){
		html += "<div id='search_menu' name='search_menu'>";
		html += "<select id='type'>";
		html +=	"<c:forEach var='dto' items='${code_list}'>";
		html +=		"<c:if test='${dto.GR_CODE == 'GR002'}'>";
		html +=			"<option value='${dto.CODE}'>";
		html +=				"${dto.CODE_NAME}";
		html +=			"</option>";
		html +=		"</c:if>";
		html +=	"</c:forEach>";
		html += "</select>";
		html += "<input type='button' id='search_btn' value='검색' onClick='btn_click()'>";
		html += "</div>";
		
		$("#search_menu").html(html);
		
	}else if(input == '6'){
		html += "<div id='search_menu'>";
		html += "<input id='text' name='text' type='text' maxlength='8'>~";
		html += "<input id='text2' name='text2' type='text' maxlength='8'>";
		html += "<input type='button' id='search_btn' value='검색' onClick='btn_click()'>";
		html += "</div>";
		$("#search_menu").html(html);
	}else{
		html += "<div id='search_menu'>";
		html = "<input id='text' name='text' type='text'>";
		html += "<input type='button' id='search_btn' value='검색' onClick='btn_click()'>";
		html += "</div>";
		$("#search_menu").html(html);
	}
}

function btn_click(){
	var result = $("#selectBox option:selected").val();
	var codeType = $("#type option:selected").val();
	var text = $("#text").val();
	
	var page = 1;


	
	
	if(textCheck() == true){
	
		paging(page);
	}	
	else {
		
						
		var html = "";
		html += "<tr>";
		html += "<td> <p>검색어를 입력해주세요</p> </td>";
		html += "</tr>";
		$("#tb").empty
		$("#tb").html(html);
		
	}
	
}
function paging(index){
		
	data = {
			result :$("#selectBox option:selected").val(),
			codeType : $("#type option:selected").val(),
			text : $("#text").val(),
			text2 : $("#text2").val(),
			page : index
			
	};
	
	console.log(data.page);

	$.ajax({
		url : "./freeBoardSearch.ino",
		type : 'POST',
		data : data,
		cache: false,
		success : function (data){
			var html = "";
			
			const list = data.list;
			
			//console.log(list);
			//console.log("start : " +startPage);
			//console.log("end : "+endPage);
				
				if(list == ""){
					alert("검색 정보가 없습니다.");
					html += "<tr>";
					html += "<td> <p>검색결과가 없습니다. 정확히 입력 해주세요.</p> </td>";
					html += "</tr>";
					$("#tb").empty
					$("#tb").html(html);
					$("#paginationBox").empty();
				}
				else{
					boardSearch(data);
					
				}
			}
					
	});
}	

	
function boardSearch(data){
//		var html ="<div id='board'>";
//		html += "<table border='1'>";
//		html +=	"<tbody id='tb' name='tb'>";
	var html = "";
	var block ="";
	$.each(data.list, function(key, value){
	html +=	"<tr>";
	html +=	"<td><input type='checkbox' name='check_box'  value="+value.num+"></td>";
	html +=	"<td style='width: 55px; padding-left: 30px;' align='center'>"+value.codeType+"</td>";
	html +=	"<td style='width: 50px; padding-left: 10px;' align='center'>"+value.num+"</td>";
	html +=	"<td style='width: 125px; '' align='center'><a href='./freeBoardDetail.ino?num="+value.num+"'>"+value.title+"</a></td>";
	html +=	"<td style='width: 48px; padding-left: 50px;' align='center'>"+value.name+"</td>";
	html +=	"<td style='width: 100px; padding-left: 95px;' align='center'>"+value.regdate+"</td>";
	html +=	"<tr>";
	});
	
	block += "<td><a href='#' onclick='paging(1); return falsue'>[처음]</a></td>";
	if(data.page > 10){
		block += "<td><a href='#' onclick='paging("+data.page+"-10); return false'>[이전]</a></td>";
	}
	if(data.maxPage > 10){
		for (var i = data.startPage ; i<=data.endPage; i++){
			
			block += "<td><a href='#' onclick='paging("+i+"); return false;'>"+i+"</a> </td>";
			
			
		}
	}else{
		for (var i = data.startPage ; i<=data.maxPage; i++){
			
			block += "<td><a href='#' onclick='paging("+i+"); return false;'>"+i+"</a> </td>";
			
			
		}
	}
	if(data.endPage != data.maxPage){
		block += "<td><a href='#' onclick='paging("+data.startPage+"+10); return false'>[다음]</a></td>";
	}
	
//		html +="</tbody>";
//		html +="</table>";
//		html +="</div>";
	$("#tb").empty();
	$("#tb").html(html);
	$("#paginationBox").html(block);
}

function textCheck(){
	
	var result = $("#selectBox option:selected").val();
	var codeType = $("#type option:selected").val();
	var text = $("#text").val();
	var text2 = $("#text2").val();
	
	if(result == '0'){
		alert("전체보기로 돌아 갑니다.");
		return true;
	}
	else if(result == '1'){
		return true;
		
	}
	else if(result == '2'){
		if(text ==""){
			alert("검색어를 입력 해주세요");
			$("#text").focus();
			return false;
		}
		else if(isNaN(text)== true){
			alert("숫자만 입력하세요");
			$("#text").focus();
			return false;
		}
		
	}
	else if(result == '6'){
		if(text == ""){
			alert("검색어를 입력 해주세요");
			$("#text_").focus();
			return false;
		}else if(text2 == ""){
			alert("검색어를 입력 해주세요");
			$("#text2").focus();
			return false;
		}
	}
	else{
		if(text == ""){
			alert("검색어를 입력 해주세요");
			$("#text").focus();
			return false;
		}
	}
	return true;
}

	
/*
$(document).ready(function(){
	var input = document.getElementById("selectBox");
	var input2 = document.getElementById("type_hidden");
	
	
	$("#selectBox").change(function(){
		input = $("#selectBox option:selected").val(); //input.options[input.selectedIndex].value;
		if(input =='0'){
			$("#type_hidden").hide();
			$("#text_hidden").hide();
			$("#text_hidden2").hide();
		}
		else if(input == '1'){
			$("#type_hidden").show();
			$("#text_hidden").hide();
			$("#text_hidden2").hide();
		}
		else if(input =='6'){
			$("#type_hidden").hide();
			$("#text_hidden").show();
			$("#text_hidden2").show();
		}
		else{
			$("#type_hidden").hide();
			$("#text_hidden").show();
			$("#text_hidden2").hide();
		}
		
	});
	
	$("#search_btn").click(function(){
		
		var result = $("#selectBox option:selected").val();
		var codeType = $("#type_hidden option:selected").val();
		var text = $("#text_hidden").val();
		var text2 = $("#text_hidden2").val();
		
		textCheck();
		data = {
				result :$("#selectBox option:selected").val(),
				codeType : $("#type_hidden option:selected").val(),
				text : $("#text_hidden").val(),
				text2 : $("#text_hidden2").val()
		};
					
		$.ajax({
			url : "./freeBoardSearch.ino",
			type : 'POST',
			data : data,
			cache: false,
			success : function (data){
					console.log(data.list);
					
					if(data == ""){
						
						alert("검색정보가 없습니다.");
						
						 boardSearch(data.list);
					}
					else{
						
						boardSearch(data.list);
					}
				}
						
					
				
			
		});
				
	});
	

	
	
});

*/	
</script>
</html>
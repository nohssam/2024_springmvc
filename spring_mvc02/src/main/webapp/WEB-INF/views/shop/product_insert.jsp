<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/summernote-lite.css">
<style type="text/css">
#productform table {
	 width:800px;
	 margin:0 auto;
	 margin-top:20px;
	 border:1px solid black;
	 border-collapse:collapse;
	 font-size:14px;
}

#productform table th {
	    text-align:center;
	    border:1px solid black;
	    padding:10px 10px;
	}
	
#productform table td {
	    text-align:left;
	    border:1px solid black;
	    padding:10px 10px;
	}
#productform input {
  padding: 5px;
}

h2{text-align: center;}
</style>

</head>
<body>
	<div id="productform">
		<h2> 상품 등록 페이지 </h2>
		<form action="/shop_product_insert_ok" method="post" enctype="multipart/form-data">
			<table>
				<tbody>
					<tr>
						<th>분류</th>
						<td>
							<input type="radio" name="category" value="com001" required>컴퓨터
							<input type="radio" name="category" value="ele002">가전제품
							<input type="radio" name="category" value="sp003">스포츠
						</td>
					</tr>
					<tr>
						<th>제품번호</th>
						<td><input type="text" name="p_num" required> </td>
					</tr>
					<tr>
						<th>제품명</th>
						<td><input type="text" name="p_name" required></td>
					</tr>
					<tr>
						<th>판매사</th>
						<td><input type="text" name="p_company" required></td>
					</tr>
					<tr>
						<th>상품가격</th>
						<td><input type="number" name="p_price" required></td>
					</tr>
					<tr>
						<th>할인가격</th>
						<td><input type="number" name="p_saleprice" required></td>
					</tr>
					<tr>
						<th>상품이미지-S</th>
						<td><input type="file" name="file_s" required></td>
					</tr>
					<tr>
						<th>상품이미지-L</th>
						<td><input type="file" name="file_l" required></td>
					</tr>
					<tr>
						<th colspan="2">상품내용</th>
					</tr>
					<tr>
						<td colspan="2">
							<textarea rows="8" cols="50" name="p_content" id="p_content"></textarea>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr><td colspan="2" style="text-align: center;"><input type="submit" value="상품등록"></td></tr> 
				</tfoot>
			</table>
		</form>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>
	<script src="/resources/js/summernote-lite.js" ></script>
	<script src="/resources/js/lang/summernote-ko-KR.js"></script>
	<script type="text/javascript">
		$(function() {
			$("#p_content").summernote({
				lang : 'ko-KR',
				height : 300,
				focus : true,
				placeholder : "최대 3000자까지 쓸 수 있습니다.",
				callbacks : {
					onImageUpload : function(files, editor) {
						for (let i = 0; i < files.length; i++) {
							sendImage(files[i], editor);
						}
					}
				}
			});
		});
		
		function sendImage(file, editor) {
			// FormData 객체를 전송할 때 , jQuery가 설정
		  let frm = new FormData();
		  frm.append("s_file", file);
		  $.ajax({
			  url : "/saveImg",
			  data : frm,
			  method : "post",
			  contentType : false,
			  processData : false,
			  cache : false,
			  dataType : "json",
			  success : function(data) {
				 const path = data.path;
				 const fname = data.fname ;
				 console.log(path, fname);
				 $("#p_content").summernote("editor.insertImage", path+"/"+fname);
			  },
			  error : function() {
				alert("읽기실패");
			}
		  });
		}
	</script>
</body>
</html>
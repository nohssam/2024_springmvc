<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<style type="text/css">
#bbs table {
	width:580px;
	margin:0 auto;
	margin-top:20px;
	border: 1px solid black;
	border-collapse: collapse;
	font-size: 14px;
}

#bbs table caption {
	font-size: 20px;
	font-weight: bold;
	margin-bottom: 10px;
}

#bbs table th, #bbs table td {
	text-align: center;
	border: 1px solid black;
	padding: 4px 10px;
}

.no { width: 15% }
.subject { 	width: 30% }
.writer {	width: 20% }
.reg {	width: 20% }
.hit {	width: 15% }
.title {	background: lightsteelblue }
.odd {	background: silver }

/* paging */
table tfoot ol.paging {
	list-style: none;
}

table tfoot ol.paging li {
	float: left;
	margin-right: 8px;
}

table tfoot ol.paging li a {
	display: block;
	padding: 3px 7px;
	border: 1px solid #00B3DC;
	color: #2f313e;
	font-weight: bold;
}

table tfoot ol.paging li a:hover {
	background: #00B3DC;
	color: white;
	font-weight: bold;
}

.disable {
	padding: 3px 7px;
	border: 1px solid silver;
	color: silver;
}

.now {
	padding: 3px 7px;
	border: 1px solid #ff4aa5;
	background: #ff4aa5;
	color: white;
	font-weight: bold;
}
</style>

</head>
<body>
	<div id="bbs" align="center">
		<table summary="게시판 목록">
			<caption>게시판 목록</caption>
			<thead>
				<tr class="title">
					<th class="no">번호</th>
					<th class="subject">제목</th>
					<th class="writer">글쓴이</th>
					<th class="reg">날짜</th>
					<th class="hit">조회수</th>
				</tr>
			</thead>
			<tbody>
				<!-- 데이터는 AJAX 요청으로 동적 로딩 -->
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4">
						<ol class="paging">
							<!-- 페이징 목록은 AJAX 요청으로 동적 로딩 -->
						</ol>
					</td>
					<td>
						<input type="button" value="글쓰기" onclick="bbs_write()" />
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    // 페이지 로드 시 첫 페이지 데이터 요청
    loadBbsList(1);

    function loadBbsList(cPage) {
        $.ajax({
            url: '/bbs_ajax',
            type: 'GET',
            data: { cPage: cPage },
            dataType: 'json',
            success: function(response) {
                renderTable(response.list);
                renderPagination(response.paging);
            },
            error: function(error) {
                console.log("Error:", error);
            }
        });
    }

    function renderTable(list) {
        let tbody = $("#bbs tbody");
        tbody.empty();
        if (list.length === 0) {
            tbody.append("<tr><td colspan='5'><h3>게시물이 존재하지 않습니다</h3></td></tr>");
        } else {
            list.forEach(function(item) {
                let row = "<tr>" +
                    "<td>" + item.b_idx + "</td>";
                
                if (item.active == 1) {
                    row += "<td><span style='color: lightgray'>삭제된 게시물 입니다</span></td>";
                } else {
                    row += "<td><a href='/bbs_detail?b_idx=" + item.b_idx + "&cPage=" + item.nowPage + "'>" + item.subject + "</a></td>";
                }

                row += "<td>" + item.writer + "</td>" +
                       "<td>" + item.write_date + "</td>" +
                       "<td>" + item.hit + "</td>" +
                       "</tr>";

                tbody.append(row);
            });
        }
    }

    function renderPagination(paging) {
        let pagination = $("ol.paging");
        pagination.empty();
     // 이전 버튼
        let prevItem = $("<li>");
        if (paging.beginBlock <= paging.pagePerBlock) {
            // 비활성화 상태
            prevItem.addClass("disable").text("이전으로");
        } else {
            // 활성화 상태
            let prevLink = $("<a>").attr("href", "#").text("이전으로");
            prevLink.on("click", function (e) {
                e.preventDefault();
                loadBbsList(paging.beginBlock - paging.pagePerBlock);
            });
            prevItem.append(prevLink);
        }
        pagination.append(prevItem);

     // 페이지 번호
        for (let k = paging.beginBlock; k <= paging.endBlock; k++) {
            let pageItem = $("<li>");
            
            if (k === paging.nowPage) {
                // 현재 페이지 (링크 없이 표시)
                pageItem.addClass("now").text(k);
            } else {
                // 다른 페이지 (링크 추가)
                let pageLink = $("<a>").attr("href", "#").text(k);
                pageLink.on("click", function (e) {
                    e.preventDefault();
                    loadBbsList(k);
                });
                pageItem.append(pageLink);
            }

            pagination.append(pageItem);
        }

     // 다음 버튼
        let nextItem = $("<li>");
        if (paging.endBlock >= paging.totalPage) {
            // 비활성화 상태
            nextItem.addClass("disable").text("다음으로");
        } else {
            // 활성화 상태
            let nextLink = $("<a>").attr("href", "#").text("다음으로");
            nextLink.on("click", function (e) {
                e.preventDefault();
                loadBbsList(paging.beginBlock + paging.pagePerBlock);
            });
            nextItem.append(nextLink);
        }
        pagination.append(nextItem);
    }

    // 글쓰기 버튼 클릭 시 이동 함수
    window.bbs_write = function() {
        location.href = "/bbs_write";
    }


});
</script>
</body>
</html>

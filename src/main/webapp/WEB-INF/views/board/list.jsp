<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Tables</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
            	<div class="col-lg-12">
            		<div class="panel panel-default">
            			<div class="panel-heading">Board List Page
            			<button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Board</button>
            			</div>
            			<div class="panel-body">
            				<table class="table table-striped table-bordered table-hover">
            					<thead>
            						<tr>
            							<th>#번호</th>
            							<th>제목</th>
            							<th>작성자</th>
            							<th>작성일</th>
            							<th>수정일</th>
            						</tr>
            					</thead>
            					
            					<!-- 등록된 모든 정보 조회 -->
            					<c:forEach items="${list }" var="board">
            					<tr>
            						<td><c:out value="${board.bno }"/></td>
            						<td><a class="move" href="<c:out value='${board.bno }'/>">
            						<c:out value="${board.title }"/></a>
            						<b>[<c:out value="${board.replyCnt }"/>]</b></td>
            						<td><c:out value="${board.writer }"/></td>
            						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
            						<td><fmt:formatDate pattern="yyyy-MM-dd"
            						value="${board.updateDate }"/></td>
            					</tr>
            					</c:forEach>
            				</table>
            				<!-- 검색기능을 추가 
            					 페이지 번호 파라미터 유지 + 검색 조건, 키워드
            					 화면에서 검색을 하면 새로 검색을 한다는 의미 => 1페이지
            				-->
            				<div class="row">
            					<div class="col-lg-12">
            						<form id="searchForm" action="/board/list" method="get">
            							<select name="type">
            								<option value=""
            									<c:out value="${pageMaker.cri.type == null? 'selected' : '' }"/>>--</option>
            								<option value="T"
            									<c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
            								<option value="C"
            									<c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }"/>>내용</option>
            								<option value="W"
            									<c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
            								<option value="TC"
            									<c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }"/>>제목 OR 내용</option>
            								<option value="TW"
            									<c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }"/>>제목 OR 작성자</option>
            								<option value="TWC"
            									<c:out value="${pageMaker.cri.type eq 'TCW' ? 'selected' : '' }"/>>제목 OR 내용 OR 작성자</option>
            							</select>
            							<input type="text" name="keyword" 
            							value="<c:out value='${pageMaker.cri.keyword }'/>"/>
            							<!-- 페이지 정보 포함 (hidden) -->
            							<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"/>
            							<input type="hidden" name="amount" value="${pageMaker.cri.amount }"/>
            							<button class="btn btn-default">검색</button>
            						</form>
            					</div>
            				</div>
            				
            				
            				
            				<!-- 페이지 처리 -->
            				<!-- 페이지 정보를  저자ㅇ하는 form 사용자에게 보여지지 않게 -->
            				<form id="actionForm" action="/board/list" method="get">
            					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
            					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
            					<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type }'/>">
            					<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword }'/>">
            				</form>
            				
            				
            				<div class="pull-right">
            					<ul class="pagination">

            						<c:if test="${pageMaker.prev }">
            							<li class="paginate_button previous">
            								<a href="${pageMaker.startPage-1 }">Prev</a>
            							</li>
            						</c:if>
            					
            						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
            							<li class="paginate_button">
            							<a href="${num }">${num }</a>
            							</li>
            						</c:forEach>
            						
            						<c:if test="${pageMaker.next }">
            							<li class="paginate_button previous">
            								<a href="${pageMaker.endPage+1 }">Next</a>
            							</li>
            						</c:if>

            					</ul>
            				</div>
            				
            				
            				<!-- 알림 추가 
            				우리가 지금까지 사용한 알림방법 : alert() 브라우저가 제공하는 기본함수
            				새로운 알림 방법 Modal : 커스터마이징한 창을 띄워서 알려줌 -->
            				<!-- Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                        	처리가 완료 되었습니다.    
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
            			</div>
            		</div>
            	</div>
            </div>
<script type="text/javascript">
$(document).ready(function() {
	// 사용자에게 방금 등록한 게시물이 몇번으로 등록됬는지 알려주기 위해 작성
	var result = "<c:out value='${result}'/>";
	
	checkModal(result);
	
	function checkModal(result) {
		console.log(result);
		if(result == ""){
			return;
		}
		console.log("함수가 실행중입니다");
		if(parseInt(result) > 0){
			// result (사용자가 등록한 게시물의 번호) 가 0보다 크면
			$(".modal-body").html("게시글" + parseInt(result) + " 번이 등록되었습니다.");
		}
			$("#myModal").modal("show"); // Modal 창 보여주는 함수
	}
	
	// 화면 이동 버튼 이벤트 처리
	$("#regBtn").on("click" , function() {
		self.location="/board/register";	
	})
	
	// 페이지 버튼 처리
	var actionForm = $("#actionForm");
	
	// 페이지 버튼에다가 이벤트 함수 달기
	$(".paginate_button a").on("click" , function(e) {
		// 이벤트 객체 e
		// a 태그 원래 이벤트 없애준다
		e.preventDefault();
		console.log("click");
		// 클릭한 번모를 pageNum 으로 해서 보낸다.
		// action form 의 value 수정해서 보낸다
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.attr("action" , "/board/list")
		actionForm.submit();
		
	})
	
	
	// 게시물 조회를 위한 이벤트 처리 추가
	// 게시물 제목을 넣었을때 이벤트를 여기서 정의한다.
	$(".move").on("click" , function(e){
		// move 클래스가 추가된 요소의 이벤트 처리
		// 게시글 제목으 눌렀을때 이벤트 처리
		// a 태그에 달린 기본 이벤트를 동작하지 않도록 preventDefault()
		e.preventDefault();
		// 페이지 정보를 같이 전달해 줄거다. (게시물 조회 페이지 에는 정보가 없다.)
		// 1페이지로 돌아오니까 페이지 정보를 알게해준다. form 을 보낼때 게시글 번호 정보를 담아서 보낸다.
		if(actionForm.find("input[name='bno']").val() == null){
			actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") +"'>");
			actionForm.attr("action" ,"/board/get");
		} else {
			// name 이 bno 인 input 태그가 있으면 그값을 현재 선택한 게시물의 번호로 바꿔준다.
			actionForm.find("input[name='bno']").val($(this).attr("href"));
			
		}
		actionForm.submit();
		
	}) 
	
	// 검색 폼 이벤트 처리
	var searchForm = $("#searchForm");
	
	// 검색 폼의 버튼 클릭시 이벤트 처리
	$("#searchForm button").on("click", function(e) {
		// 기본 기능 동작 정지
		e.preventDefault();
		
		// 검색 조건을 선택 하도록 알림
		if(!searchForm.find("option:selected").val()){
			alert("검색 조건을 선택하세요. ");
			return false;
		}
		
		// 검색 내용을 입력하도록 알림
		// 키워드를 입력하지않았을때 알림을 띄운다.
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요 ");
			return false;
		}
		
		
		// 검색조건도 있고 키워드도 있다
		// 검색후 페이지 번호를 1번으로 지정해준다.
		searchForm.find("input[name='pageNum']").val("1");
		
		// form 전송
		searchForm.submit();
		
		
	})
	
	
})
</script>
<%@ include file="../includes/footer.jsp" %>

     
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../includes/header.jsp"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>

<div class="row">
	<div class="col-log-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Read Page</div>

			<div class="panel-body">
				<div class="form-group">
					<label>Bno</label><input class="form-control" name="bno"
						value='<c:out value="${board.bno }"/>' readonly>
				</div>
				<div class="form-group">
					<label>Title</label><input class="form-control" name="title"
						value='<c:out value="${board.title }"/>' readonly>
				</div>
				<div class="form-group">
					<label>Text Area</label>
					<textarea class="form-control" rows="3" name="content" readonly><c:out
							value="${board.content }" />
					</textarea>
				</div>
				<div class="form-group">
					<label>Writer</label><input class="form-control" name="writer"
						value='<c:out value="${board.writer }"/>' readonly>
				</div>
				<!-- 리스트 화면으로 되돌아가는 버튼 + 수정화면으로 가는 버튼 -->
				<sec:authentication property="principal" var="principal"/>
				<sec:authorize access="isAuthenticated()">
					<c:if test="${principal.username eq board.writer }"	>		<!-- eq 동일하냐 묻는 equal과 같은 것 -->
					<button data-oper="modify" class="btn btn-default">Modify</button>
					</c:if>
				</sec:authorize>
				
				
				<!-- 속성 선택자 button[data-oper='modify] -->
				<button data-oper="list" class="btn btn-info">List</button>
				<form id="operForm" action="/board/modify" method="get">
					<input type="hidden" id="bno" name="bno"
						value="<c:out value='${board.bno }'/>"> <input
						type="hidden" name="pageNum"
						value='<c:out value="${cri.pageNum }"/>'> <input
						type="hidden" name="amount"
						value='<c:out value="${cri.amount }"/>'> <input
						type="hidden" name="keyword"
						value='<c:out value="${cri.keyword }"/>'> <input
						type="hidden" name="type" value='<c:out value="${cri.type }"/>'>

				</form>

			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-log-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>Reply
				
				<sec:authorize access="isAuthenticated()">
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">NewReply</button>
					</sec:authorize>

			</div>

			<div class="panel-body">
				<!-- 댓글 시작 -->
				<ul class="chat">
					<!-- 여기에 댓글이 들어올 거에요. -->

				</ul>
			</div>
			<div class="panel-footer">
				<!-- 여기에 페이지 버튼이 들어올거다. 페이지 버튼도 동적으로 생성해서 넣는다.-->
			</div>
		</div>
	</div>
</div>
<!-- 댓글 등록용 새창 Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dissmiss="modal"
					aria-hidden="true">&times;</button>
				<!-- x버튼 -->
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> <input class="form-control" name="reply"
						placeholder="NEW REPLY">
				</div>

				<div class="form-group">
					<label>Replyer</label> <input class="form-control" name="replyer"
						placeholder="replyer" readonly>
				</div>
			</div>
			<!-- 버튼 보음 (수정, 삭제, 등록, 닫기... -->
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">
	var replyService = (function() {

		function add(reply, callback, errors) {

			// reply 댓글 객체
			// callback 콜백함수 어떤 함수를 실행 시키고 난 이후에 결과를 받을 함수 또는 그 다음에 실행될 함수
			console.log("add reply");

			$.ajax({
				type : 'post',
				url : '/replies/new',
				data : JSON.stringify(reply),
				contentType : "application/json; charset=utf-8",
				success : function(result, status, xhr) {
					// 성공했으면 실행할 함수
					if (callback) { // 콜백함수가 있으면
						callback(result); // 콜백함수 실행
					}
				},
				error : function(xhr, status, er) {
					// 에러가 발생하면 실행할 함수
					if (error) { // 에러가 있으면
						error(er); // 에러 함수 실행
					}
				}
			})

		}

		function getList(param, callback, error) {

			var page = param.page || 1;
			// 페이지가 없으면 1로 세팅
			var bno = param.bno;
			// 요청을 보낼 주소 /replies/pages/게시물번호/페이지번호
			$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
					function(data) {
						// 요청 처리 성공시 실행 되는 함수

						// 콜백함수가 있으면 콜백함수를 실행
						if (callback) {
							//	callback(data);
							// data 자리에 list가 온다
							callback(data.replyCnt, data.list);
						}
					}).fail(function(xhr, status, err) {
				// 요청처리 실패시 실행 되는 함수

				// 에러처리 함수가 있으면 에러 함수를 실행
				if (error) {
					error();
				}
			});

		}// getList 함수끝

		// 날짜 변환 기능
		function displayTime(timeValue) {
			// 어제 작성한 댓글
			// 어제 이전에 작성한 댓글
			// 오늘 작성한 댓글은 시간으로 표시해주고

			// 어제 이전에 작성한 댓글은 날짜로 표시해주기
			var today = new Date();
			// 오늘 날짜와 댓글의 날짜가 얼마나 차이나는지
			var gap = today.getTime() - timeValue;
			//gap 값도 밀리초 단위로 저장
			// 몇 밀리초가 하루일까요?
			// 1000*60*60*24 => 하루를 밀리 초 단위로 바꿈

			// 댓글 날짜
			var dateObj = new Date(timeValue);

			var str = ""; // 리턴할 날짜 (오늘 댓글이면 시간, 이전 댓글이면 날짜)
			if (gap < (1000 * 60 * 60 * 24)) {
				// 시간
				var hh = dateObj.getHours();
				// 분
				var mi = dateObj.getMinutes();
				// 초
				var ss = dateObj.getSeconds();

				// 9시
				// 09
				// 현재 시간이 9보다 크면 앞에 아무것도 안붙여주고,
				// 09 이하면 앞에 0을 붙여준더,
				str = [ (hh > 9 ? '' : '0') + hh, ':',
						(mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss ]
						.join("");
				// 배열안의 원소들이 이어붙여진다.
				// 시간
			} else {
				// 여기는 24시간 이전에 작성한 댓글
				// 날짜로 보여주기
				// 년도
				var yy = dateObj.getFullYear(); // 4자리로 된 연도
				// 월
				var mm = dateObj.getMonth() + 1; // 컴퓨터는 달을 0부터 센다

				var dd = dateObj.getDate();
				//여기도 똑같이 한자리로 된 수는 앞에 0분여주기
				str += yy + "/";
				str += (mm > 9 ? '' : '0') + mm + "/";
				str += (dd > 9 ? '' : '0') + dd;

			}
			return str;

		}

		// 댓글 지우기
		function remove(rno, replyer, callback, error) {

			$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				data : JSON.stringify({rno : rno, replyer:replyer}),
				contentType : "application/json; charset=utf-8",
				success : function(result, status, xhr) {
					// 성공하면 callback 호출
					if (callback) {
						callback(result);
					}

				},
				error : function(xhr, status, err) {
					// 실패하면 error 함수 호출
					if (error) {
						error(err);
					}
				}
			});

		} // remove 함수 끝

		function update(reply, callback, error) {

			console.log("rno : " + reply.rno);
			$.ajax({
				type : 'put',
				url : '/replies/' + reply.rno,
				data : JSON.stringify(reply),
				contentType : "application/json; charset=utf-8",
				success : function(result, status, xhr) {
					if (callback) {
						callback(result);
					}
				},
				error : function(xhr, status, err) {
					if (error) {
						error(err);
					}
				}
			})

		} // update 끝

		// 댓글 하나 조회하는 함수
		// 필요한거 : rno
		function get(rno, callback, error) {
			$.get("/replies/" + rno + ".json", function(result) {
				if (callback) {
					callback(result);
				}

			}).fail(function(xhr, status, err) {
				if (error) {
					error();
				}
			});
		}

		return {
			add : add,
			getList : getList,
			remove : remove,
			update : update,
			get : get,
			displayTime : displayTime
		};
		// replyservice 함수를 부르고 나서 그 결과값에 객체가 들어오는데
		// 그안에 add 를 가져오면 댓글 등록 기능 함수를 사용할수 있다.

	})();

	//	console.log("============== JS TEST ================");

	var bnoValue = '<c:out value="${board.bno}"/>';

	//	 add (reply , collback, error)

	/*		replyService.add(
	 {reply: "JS TEST", replyer: "tester", bno:bnoValue}, 
	 function(result) {
	 alert("RESULT : " + result);
	 }
	 );
	 */
	// getList 함수 {param, callback, error}
	/*
	 replyService.getList({bno:bnoValue, page:1} , function(list) {
	 // 현재 게시글의 댓글 목록을 콘솔에 출력
	 for(let i = 0; i<list.length; i++){
	 console.log(list[i]);
	 }
	 });
	 */
	// remove 함수 {rno, callback, error}
	/*
	 replyService.remove(10, function(count) {
	 console.log(count);
	 if (count == "success"){
	 alert("removed");
	 }
	 },
	 function(err) {
	 alert("뭔가 잘못됨");
	 }
	
	 );
	 */
	// update(reply, callback, error)
	/*
	replyService.update({
		rno : 9,
		bno : bnoValue,
		reply : "modified reply ...."
	},
	function (result) {
		alert("수정완료");
	}
	);
	 */
	// get (rno, callback, error)
	/*
	replyService.get(9, function(data) {
		console.log(data);
	});
	 */
	$(document)
			.ready(
					function() {
						var bnoValue = '<c:out value="${board.bno}"/>';
						// li 태그를 동적으로 추가한다는 것은 
						// ul 태그를 찾아서 그태그의 자손을 붙여준다.
						var replyUL = $(".chat");

						// 동적으로 댓글을 만들어서 붙여주는 함수
						showList(1);

						function showList(page) {

							// params : 페이지 정보 , 게시글번호
							// 요청이 성공했으면 그때 댓글을 만들어서 붙여주면 된다.
							// 요청이 성공했으면 그때 댓글을 만든다. ===> callback 함수에서 처리하면 된다.
							replyService
									.getList(
											{
												bno : bnoValue,
												page : page || 1
											},
											function(replyCnt, list) {
												// 요청 성공시 callback 함수에 list를 받아온다.

												console.log("replyCnt : "
														+ replyCnt);
												console.log("list : " + list);

												// 만약 페이지 번호가 -1로 전달되면 마지막 페이지로 가도록
												if (page == -1) {
													// 댓글 개수가 7개 일 때 페이지는? (한 페이지에 10개라고 하면) 한 개.
													let pageNum = Math
															.ceil(replyCnt / 10.0);
													showList(pageNum);
													return;
												}

												var comments = ""; // 여기에 html 코드를 조립
												if (list == null
														|| list.length == 0) {
													// 해당 게시물에는 댓글이 없다.
													// html 코드를 조립할 필요가 없다.
													replyUL.html("");
													return; // 함수 바로 종료
												}
												// 여기로 오면 댓글이 존재한다.
												// for문을 이용해서 list 안에 있는 댓글 목록을 
												// <li> 태그로 만들어서 조립해주면된다.
												for (let i = 0; i < list.length; i++) {
													comments += "<li class='left clearfix' data-rno='" + list[i].rno +"'>";
													comments += "<div>";
													comments += "<div class='header'>";
													comments += "<strong class='primary-font'>"
															+ list[i].replyer
															+ "</strong>";
													comments += "<small class='pull-right text-muted'>";
													comments += replyService
															.displayTime(list[i].replyDate);
													comments += "</small>";
													comments += "</div>";
													comments += "<p>";
													comments += list[i].reply;
													comments += "</p>";
													comments += "</div>";
													comments += "</li>";
												}
												replyUL.html(comments);

												//댓글 페이지 보여주기
												showReplyPage(replyCnt);
											})

						}// end showList

						var pageNum = 1;
						var replyPageFooter = $(".panel-footer");

						function showReplyPage(replyCnt) {

							// 아까 우리가 추가한 div 요소를 먼저 가져와 놓기
							// 여기 안에다가 html 코드 조립해서 페이지 버튼 만들겠다.

							var endNum = Math.ceil(pageNum / 10.0) * 10;
							var startNum = endNum - 9;
							// 앞 페이지가 존재하는지?
							let prev = startNum != 1;
							// 댓글은 마지막 페이지부터 보여주니까 일단 다음페이지는 없는 것으로
							let next = false;

							// 만약 endNum (마지막페이지) 포함 댓글 개수가 실제 댓글 개수보다 많으면
							if (endNum * 10 >= replyCnt) {
								endNum = Math.ceil(replyCnt / 10.0);
							}
							// endNum 가 댓글 개수보다 적으면 다음 페이지가 있다. next =true
							if (endNum * 10 < replyCnt) {
								next = true;
							}
							console.log(endNum + startNum + replyCnt + "");

							// 댓글 페이지 html 조립
							let pageHtml = "<ul class='pagination pull-right'>";

							// 이전 페이지가 존재하면
							if (prev) {
								pageHtml += "<li class='page-item'>";
								pageHtml += "<a class='page-link' href='"
										+ (startNum - 1) + "'>"
								pageHtml += "Prev</a></li>"
							}

							// 페이지 숫자 버튼 만들기
							for (let i = startNum; i <= endNum; i++) {
								//active : 현재 페이지 번호 표시
								let active = pageNum == i ? "active" : "";
								pageHtml += "<li class='page-item " + active +"'>";
								pageHtml += "<a class='page-link' href ='"+ i + "'>";
								pageHtml += i + "</a></li>";

							}

							// 다음 페이지가 존재하면 (10개 단위) next 버튼 활성화
							if (next) {
								pageHtml += "<li class ='page-item'>";
								pageHtml += "<a class ='page-link' href='"
										+ (endNum + 1) + "'>";
								pageHtml += "Next</a></li>";

							}
							pageHtml += "</ul>";

							//html 코드 붙이기
							replyPageFooter.html(pageHtml);
							console.log(pageHtml);

						}//end showReplyPage 	

						//모달 div 가져오기
						var modal = $(".modal");
						// 사이트 위조 방지
						var csrfHeaderName = "${_csrf.headerName}";
						var csrfTokenValue = "${_csrf.token}";
						
						// 앞으로 보낼 모든 ajax 요청의 헤더에 csrf 토큰 정보를 담아서 보낼 수 있또록 설정
						$(document).ajaxSend(function(e, xhr, options){
							xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							
						})// xhr = xmlHttpRequest 의 줄임말
						
						//사용자 이름 가져오기
						var replyer = null;
						<sec:authorize access="isAuthenticated()">
							replyer = '<sec:authentication property="principal.username"/>';
						</sec:authorize>

						$("#addReplyBtn").on("click", function(e) {
							// #addReplyBtn 은 덧글 추가하기 이므로 수정, 삭제 버튼 필요없음
							// 보여줄 필요 없다.
							// close 버튼 이외의 다른 버튼들 다 숨기고
							
							// name이 replyer인 input tage의 값을 우리가 위에서 가져온 replyer로 설정
							
							modal.find("input[name='replyer']").val(replyer);
							modal.find("button[id != 'modalCloseBtn']").hide();
							// 레지스터 버튼만 다시 보이게 해준다.
							$("#modalRegisterBtn").show();
							//  (x)버튼 다시 보이게 하기
							$(".close").show()

							modal.modal("show");

						});
						// 댓글 창 닫기 이벤트
						$("#modalCloseBtn").on("click", function(e) {
							modal.modal("hide");
						})
						// x 버튼 눌렀을 때 창 닫기
						$(".close").on("click", function(e) {
							modal.modal("hide");
						})

						// 댓글 추가 이벤트
						// name 값이 reply 인 input 태그 가져오기
						var modalInputReply = modal.find("input[name='reply']");
						// name 값이 replyer인 input 태그 가져오기
						var modalInputReplyer = modal
								.find("input[name='replyer']");

						$("#modalRegisterBtn").on("click", function(e) {
							// name 속성이 reply 인 input 찾아오기 : 댓글 내용
							// name 속성이 replyer 인 input 찾아오기 : 작성자
							// 게시글 번호 bno 가져와서 reply 객체 만든 뒤에 댓글 달기 기능 실행
							var reply = {
								reply : modalInputReply.val(),
								replyer : modalInputReplyer.val(),
								bno : bnoValue
							}

							//add (reply, callback)
							replyService.add(reply, function(result) {
								alert(result);

								modal.find("input").val("");
								modal.modal("hide");

								showList(-1);
							})

						})
						// 댓글 수정 이벤트
						// 여기서 li 태그 찾아봤자 못찾는다. 왜 와이.
						// 동적으로 ajax를 통해서 <li> 태그들이 만들어지면 
						// 그 <li> 태그들은 현재 스크립트 안에서는 찾을 수가 없다.
						// <li> 태그가 생성된 이후에 이벤트를 달아야 한다.
						// 지금 여기서 <li> 태그에 이번트를 달려고 하면 찾을 수 없다.

						// 이벤트 위임
						// 동적으로 생성되는 요소에 이벤트를 직접 달아주는게 아니라
						// 동적으로 생성될 요소의 부모 또는 형제 요소에다가 달아준 다음 나중에 이벤트의 대상을 변경해준다.

						// <li> 태그가 동적으로 생성될 것인데 여기다 달면 안 된다.
						// 이미 존재하는 태그 (부모 또는 형제) ==> <ul>
						$(".chat").on(
								"click",
								"li",
								function(e) {
									// 나중에 동적으로 생기는 <li> 태그들에게 이벤트가 발생하도록 한다.
									var rno = $(this).data("rno");

									console.log(rno);
									// 댓글 가져와서 modal 창에 띄워주면 된다.
									replyService.get(rno, function(reply) {
										modalInputReply.val(reply.reply);
										modalInputReplyer.val(reply.replyer);

										// modal의 data ("rno") 속성을 지금 클릭한 댓글의 번호로 지정
										modal.data("rno", reply.rno);
										// 여기는 register 버튼이 필요가 없음.
										// 일단 close 버튼 빼고 다 숨기고
										// 수정버튼과 제거 버튼만 남겨 놓기
										modal.find(
												"button[id!='modalCloseBtn']")
												.hide();
										$("#modalModBtn").show();
										$("#modalRemoveBtn").show();

										$(".modal").modal("show");

										
										
										
									})
								}) // class 가 chat인 tag를 가져온다.

						// 댓글 수정 처리
						$("#modalModBtn").on("click", function(e) {
							// 댓글 수정 버튼(modify 버튼)
							var reply = {
								rno : modal.data("rno"),
								reply : modalInputReply.val()
							};
							
							// 댓글의 원래 작성자 정보를 추가로 담아주고
							
							// 수정하려는 사람이 원래 작성자랑 다르면 알림창 띄우고 리턴
							
							// replyService 의 update 함수는 수정 안해도 됨
							
							// controller 의 put 수정
							

							replyService.update(reply, function(result) {
								alert(result);
								// modal 창 숨기고
								modal.modal("hide");
								// 댓글 목록 다시 가져오기
								showList(pageNum);
								// 댓글 수정 하고나서 input 값 비우기
								modal.find("input").val("");
							})

						})
						// 댓글 삭제 버튼
						$("#modalRemoveBtn").on("click", function(e) {

							//삭제하기 위해 필요한 거?? 댓글번호 rno
							let rno = modal.data("rno");
							// controller 가 댓글을 삭제하려는 사람이 기존 댓글을 등록한 사람과 같은지 검사를 해야하므로, replyer 파라미터가 필요하게 되었다.
							// 그래서 파라미터를 추가해 준다. rno, replyer
							let originalReplyer = modalInputReplyer.val();
							
							if(replyer != originalReplyer){
								alert("자신이 작성한 댓글만 삭제가 가능합니다");
								modal.modal("hide");
								return;
							}

							replyService.remove(rno , originalReplyer, function(result) { // callback 함수
								alert(result);
								showList(pageNum);
							})
						})
						// replyPageFooter한테 이벤트 위임
						// replyPageFooter 안의 li a 요소에다가 이벤트 대상 변경해주기
						replyPageFooter.on("click", "li a", function(e) {
							e.preventDefault(); // a 태그 기본 동작 제거
							console.log("page click");
							// 이동할 페이지 번호
							// href 속성에 페이지 번호를 저장 해놨으므로 꺼내서 쓰자
							let target = $(this).attr("href");
							console.log("target page : " + target);
							pageNum = target;
							showList(pageNum);
						})

					});
</script>

<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function() {
			operForm.submit();
		})

		$("button[data-oper='list']").on("click", function() {
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list");
			operForm.submit();
		})
	})
</script>

<%@ include file="../includes/footer.jsp"%>
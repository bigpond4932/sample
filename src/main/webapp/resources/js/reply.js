/**
 * 댓글 처리하는 js module
 */

console.log("reply module.......");

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
			success : function(result, status, xhr){
				// 성공했으면 실행할 함수
				if(callback) { // 콜백함수가 있으면
					callbak(result); // 콜백함수 실행
				}
			},
			error : function(xhr, status, er) {
				// 에러가 발생하면 실행할 함수
				if(error){ // 에러가 있으면
					error(er); // 에러 함수 실행
				}
			}
		})
		
		
	}
	
	// 댓글 목록을 불러오는 함수
	// 댓글 목록을 불러올때 페이지 정보가 필요한데 필요한 정보는 param ...
	function getList(param, callback, error) {
		
		var page = param.page || 1;
		// 페이지가 없으면 1로 세팅
		var bno = param.bno;
		// 요청을 보낼 주소 /replies/pages/게시물번호/페이지번호
		$.getJSON(
				"/replies/pages/" + bno + "/" + page + ".json",
				function(data) {
					// 요청 처리 성공시 실행 되는 함수
					
					// 콜백함수가 있으면 콜백함수를 실행
					if(callback){
						callback(data);
					}
				}).fail(function(xhr, status, err) {
					// 요청처리 실패시 실행 되는 함수
					
					// 에러처리 함수가 있으면 에러 함수를 실행
					if(error){
						error();
					}
				});
		
	} // getList 함수 끝
	
	
	return {
		add : add,
		getList : getList
	};
	// replyservice 함수를 부르고 나서 그 결과값에 객체가 들어오는데
	// 그안에 add 를 가져오면 댓글 등록 기능 함수를 사용할수 있다.
	
})();

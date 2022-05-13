package com.globalin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.globalin.domain.Criteria;
import com.globalin.domain.ReplyPage;
import com.globalin.domain.ReplyVO;
import com.globalin.service.ReplyService;

@RestController
@RequestMapping("/replies/")
public class ReplyController {

	@Autowired
	private ReplyService service;
	/*
	 * REST 방식으로 처리할때 주의할점
	 * 외부에서 서버를 호출할때 데이터의 포맷
	 * 
	 *
	 */
	
	
	// 등록 POST
	// url : /replies/new 
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/new",
			consumes="application/json", // 브라우저가 보낸 데이터 형식
			produces= {MediaType.TEXT_PLAIN_VALUE} // 서버가 보낼 데이터 형식
			)
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		
		int result =  service.register(vo);
		
		if(result == 1) {
			return new ResponseEntity<>("success" , HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
	
	
	
	// 조회 GET
	// url : /replies/:rno
	@GetMapping(
			value="/{rno}",
			produces= {MediaType.APPLICATION_JSON_UTF8_VALUE}
			)
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") int rno) {
		
		return new ResponseEntity<ReplyVO>(service.get(rno), HttpStatus.OK);
		
	}
	
	
	// 삭제 DELETE
	// url : /replies/:rno
	@DeleteMapping(
			value="/{rno}",
			produces= {MediaType.TEXT_PLAIN_VALUE}
			)
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo, @PathVariable("rno") int rno){
		
		// if 문 을 다른식으로 쓰는법
		return service.remove(rno) == 1 ?
				new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	
	// 수정 PUT
	// url : /replies/:rno
	@PutMapping(value="/{rno}",
			consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE}
			)
	public ResponseEntity<String> modify(
			@PathVariable("rno") int rno,
			@RequestBody ReplyVO vo
			){
		vo.setRno(rno);
		
		return service.modify(vo) == 1 ?
				new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	
	
	// 페이지 처리된 리스트 GET
	// url : /replies/pages/:bno/:page
	@GetMapping(
			value="/pages/{bno}/{page}",
			produces= {MediaType.APPLICATION_JSON_UTF8_VALUE}
			)
	public ResponseEntity<ReplyPage> getList(
			// ReplyPage  = 댓글 개수 + 댓글 리스트
			@PathVariable("page") int page,
			@PathVariable("bno") int bno){
		
		Criteria cri = new Criteria();
		cri.setPageNum(page);
		cri.setAmount(10);
		
		
		
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
		
		
	}
	
}

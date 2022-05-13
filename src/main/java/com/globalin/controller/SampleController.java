package com.globalin.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.globalin.domain.SampleVO;
import com.globalin.domain.Ticket;

@RestController
@RequestMapping("/sample")
public class SampleController {

	private Logger log = LoggerFactory.getLogger(SampleController.class);
	/*
	 * 순수한 데이터를 반환해준다.
	 * 
	 * */
	
	// 문자열을 반환하는 형태
	
	@GetMapping(value="/getText", produces="text/plain; charset=UTF-8")
	public String getText() {
		
		log.info("type : " + MediaType.TEXT_PLAIN_VALUE);
		
		return "안녕하세요";
	}
	
	@GetMapping(value="/getSample",
			produces= MediaType.APPLICATION_JSON_UTF8_VALUE
			)
	public SampleVO getSample() {
		
		return new SampleVO(2, "스티븐" , "스트레인지");
		
	}
	
	@GetMapping(value="/getList")
	public List<SampleVO> getList(){
		List<SampleVO> list = new ArrayList<>();
		
		for(int i=0; i<10; i++) {
			SampleVO s = new SampleVO(i, i + " First", i + " Last");
			list.add(s);
		}
		
		return list;
	}
	
	@GetMapping(value="/getMap")
	public Map<String, SampleVO> getMap(){
		Map<String, SampleVO> map = new HashMap<String, SampleVO>();
		map.put("First", new SampleVO(11, "그루트", "주니어"));
		return map;
	}
	
	@GetMapping(value="/check" , params= {"height" , "weight"})
	public ResponseEntity<SampleVO> check(Double height, Double weight){
		
		SampleVO s = new SampleVO(0, "" + height, "" + weight);
		
		ResponseEntity<SampleVO> result = null;
		
		if(height <= 180 ) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(s);
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(s);
		}
		return result;
	}
	
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat,
			@PathVariable("pid") Integer pid) {
		// 그자리의 값들을 가져온다는 의미
		return new String[] {"category: " + cat, "productid: " + pid};
	}
	
	@PostMapping("/ticket")
	public Ticket ticket(@RequestBody Ticket ticket) {
		
		log.info("ticket : " + ticket);
		
		return ticket;
		
	}
	
}

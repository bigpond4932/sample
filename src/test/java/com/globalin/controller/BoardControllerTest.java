package com.globalin.controller;


import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

// 이 클래스를 스프링 환경에서 테스트한다는의미
@RunWith(SpringJUnit4ClassRunner.class)
// 스프링 설정파일 위치를 지정해준다.
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
// 컨트롤러를 위한 테스트 클래스
@WebAppConfiguration
public class BoardControllerTest {

	private static Logger log = LoggerFactory.getLogger(BoardControllerTest.class);
	
	// 스프링의 웹 설정 불러오기
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders
				.get("/board/list")
				.param("pageNum", "2")
				.param("amount", "10"))
				.andReturn()
				.getModelAndView()
				.getModelMap()
				.toString()
				);
		
	}
	
//	@Test
//	public void testRegister() throws Exception{
//		String result = "";
//		result = mockMvc
//				.perform(MockMvcRequestBuilders.post("/board/register")
//				.param("title", "aaa")
//				.param("content", "bbb")
//				.param("writer","cccc"))
//				.andReturn().getModelAndView().getViewName();
//		log.info(result);
//	}
//	
	
//	@Test
//	public void testGet() throws Exception {
//		log.info(mockMvc.perform(MockMvcRequestBuilders
//				.get("/board/get")
//				.param("bno", "7"))
//				.andReturn()
//				.getModelAndView()
//				.getModelMap()
//				.toString());
//	}
//	@Test
//	public void testModify() throws Exception {
//		String result = "";
//		result  = mockMvc.perform(
//				MockMvcRequestBuilders.post("/board/modify")
//				.param("bno", "9")
//				.param("title", "change")
//				.param("content", "zlzlzlzl")
//				.param("writer", "king"))
//				.andReturn()
//				.getModelAndView()
//				.getViewName();
//		
//		log.info(result);
//		
//	}
	
//	@Test
//	public void testremove() throws Exception {
//		String result = "";
//		result = mockMvc.perform(
//				MockMvcRequestBuilders.post("/board/remove")
//				.param("bno", "8"))
//				.andReturn()
//				.getModelAndView()
//				.getViewName();
//		log.info(result);
//	}
	
	
}

package com.globalin.ex02;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.globalin.domain.BoardVO;
import com.globalin.service.BoardService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardServiceTest {
	
	@Autowired
	private BoardService service;
	
	@Test
	public void testExist() {
		assertNotNull(service);
		
	}
	
//	@Test
//	public void testRegist() {
//		BoardVO b = new BoardVO();
//		b.setTitle("aaaa");
//		b.setContent("aaaaaaaaa");
//		b.setWriter("A");
//		
//		service.register(b);
//		System.out.println("생성된 게시물의 번호 : " + b.getBno());
//	}
	
//	@Test
//	public void getList() {
//		
//		for(BoardVO b : service.getList()) {
//			System.out.println(b);
//		}
//		
//	}
	@Test
	public void testModfiy() {
		BoardVO b = service.get(7);
		if(b==null) {
			return;
		}
		System.out.println(service.modify(b));
	}
//	@Test
//	public void testDelete() {
//		System.out.println(service.remove(5));
//		
//	}
//	@Test
//	public void testRead() {
//		System.out.println(service.get(6));
//		
//	}
	
	
}

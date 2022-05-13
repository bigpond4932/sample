package com.globalin.ex02;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.globalin.domain.BoardVO;
import com.globalin.domain.Criteria;
import com.globalin.mapper.BoardMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardMapperTest {
	
	@Autowired
	private BoardMapper mapper;
	
	@Test
	public void testPaging() {
		// 페이지 정보 생성
		Criteria cri = new Criteria();
		cri.setKeyword("0");
		cri.setType("TC");
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		for(BoardVO board : list) {
			System.out.println(board);
		}
		
	}
	
	
//	@Test
//	public void testGetList() {
//		List<BoardVO> list = mapper.getList();
//		for(BoardVO b : list) {
//			System.out.println(b);
//		}
//		
//	}
//	
////	@Test
////	public void insertTest() {
////		BoardVO b = new BoardVO();
////		b.setTitle("새로운 제목");
////		b.setContent("새로운 내용");
////		b.setWriter("새로운 작가");
////		
////		mapper.insert(b);
////	}
//	
////	@Test
////	public void testInsertSelectKey() {
////		BoardVO b = new BoardVO();
////		b.setTitle("selectkey타이틀");
////		b.setContent("selectkey내용");
////		b.setWriter("selectkey작가");
////		
////		mapper.insertSelectKey(b);
////		System.out.println(b);
////	}
//	
//	@Test
//	public void testRead() {
//		BoardVO b = mapper.read(3);
//		System.out.println(b);
//	}
//	
//	@Test
//	public void deleteTest() {
//		int res = mapper.delete(1);
//		System.out.println(res);
//	}
//	
//	@Test
//	public void updateTest() {
//		BoardVO b = mapper.read(1);
//		System.out.println(mapper.update(b));
//	}
	
}

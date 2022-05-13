package com.globalin.ex02;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.globalin.domain.Criteria;
import com.globalin.domain.ReplyVO;
import com.globalin.mapper.ReplyMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ReplyMapperTest {
	
	// 테스트 전에 확인했던 실제 존재하는 게시물 번호(bno)
	private int[] bnoArr = { 260, 255, 254, 253, 252, 251, 250, 249, 248};
	
	@Autowired
	private ReplyMapper mapper;
	
//	@Test
//	public void testCreate() {
//		
//		for(int i=0; i<5; i++) {
//			ReplyVO vo = new ReplyVO();
//			
//			vo.setBno(bnoArr[i]);
//			vo.setReply("댓글 테스트 : " + i);
//			vo.setReplyer("댓글 쓴사람 : " + i);
//			
//			mapper.insert(vo);
//			
//		}
//		
//	}

//	@Test
//	public void testRead() {
//	
//		ReplyVO vo = mapper.read(2);
//		
//		vo.setReply("수정되었다");
//		mapper.update(vo);
//		
//	}

	
	
	@Test
	public void testList() {
		
		Criteria cri = new Criteria();
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[1]);
		
		System.out.println(replies.toString());
		
		
	}
	
}

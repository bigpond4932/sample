package com.globalin.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.globalin.domain.Criteria;
import com.globalin.domain.ReplyPage;
import com.globalin.domain.ReplyVO;
import com.globalin.mapper.BoardMapper;
import com.globalin.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {

	private Logger log = LoggerFactory.getLogger(sampleTxServiceImpl.class);
	
	@Autowired
	private ReplyMapper mapper;
	@Autowired
	private BoardMapper bmapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		
		log.info("register...... : " + vo.getBno(), 1);
		bmapper.updateReplyCnt(vo.getBno(),1);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(int rno) {

		log.info("get.... : " + rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		
		log.info("modify ......" +vo);
		
		return mapper.update(vo);
	}
	
	@Transactional
	@Override
	public int remove(int rno) {
		
		
		log.info("remove...." + rno);
		
		ReplyVO vo = mapper.read(rno);
		
		bmapper.updateReplyCnt(vo.getBno(),-1);
		
		return mapper.delete(rno);
	}
	// 댓글 리스트 가져오는 메소드
	@Override
	public List<ReplyVO> getList(Criteria cri, int bno) {
		
		log.info("get reply list...." + bno);
		// 이제 리스트가 아니라 replyPage를 가져다 주도록 변경
		
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPage getListPage(Criteria cri, int bno) {
		ReplyPage page = new ReplyPage();
		log.info("cri : " + cri);
		
		// 이 페이지 안에는 댓글 개수, 댓글 리스트가 들어가야 한다.
		page.setReplyCnt(mapper.getCountByBno(bno));
		page.setList(mapper.getListWithPaging(cri, bno));
		return page;
	}

}

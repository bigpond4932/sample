package com.globalin.domain;

import java.util.Date;

// 테이블에 컬럼 구조를 반여아는 클래스
// tbl_board와 매칭되는 도메인 클래스.
public class BoardVO {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate,updateDate;
	
	// 게시물의 댓글 수 까지 포함시키려면 DB의 테이블 구조도 변할 필요가 있다.
	// 게시물 정보에 댓글 수도 포함하도록 변경
	// 댓글을 추가하면 tbl_reply 테이블에 insert 하고, tbl_board 테이블에는 댓글의 수를 의미하는
	// replyCnt 라는 컬럼을 추가해서 해당 게시물 댓을의 수를 update 합니다.
	private int replyCnt;
	
	
	public int getReplyCnt() {
		return replyCnt;
	}
	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer + ", regdate="
				+ regdate + ", updateDate=" + updateDate + ", replyCnt=" + replyCnt + "]";
	}
	
	
}

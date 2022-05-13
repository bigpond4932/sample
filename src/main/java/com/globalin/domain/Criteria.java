package com.globalin.domain;

// 검색 정보까지 담도록 수정

public class Criteria {

	private int pageNum;
	private int amount;
	
	// 검색 타입 : 제목 작성자 내용 등등
	// 타입이 여러개일 경우 처리가 필요하다.
	// 제목 : T , 작성자 : W  , 내용 : C
	// 복합조건일때를 대비해서 문자열을 쪼갠 다음 
	private String type;
	// 검색할 키워드
	private String keyword;
	
	public Criteria() {
		// 페이지 번호는 1 , 한페이지당 10
		this.pageNum = 1;
		this.amount = 10;
	}
	
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", type=" + type + ", keyword=" + keyword + "]";
	}
	
	// type 을 쪼개서 문자열 배열로 만들어서 리턴해주는 메소드
	// type = "TWC" 
	// String[] typeArr = {"T" , "W" , "C"};
	public String[] getTypeArr() {
		String[] result = {};
		if(type == null) {
			// 검색 조건이 없다 빈배열을 리턴해준다
		} else {
			// 검색조건이 한개이상 있다. 타입을 쪼개서 배열로 만들어준다.
			result = type.split("");
		}
		return result;
		
	}
	
	
	
	
	
}
